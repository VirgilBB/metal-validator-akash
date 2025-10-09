#!/bin/bash

# Metal Blockchain Node Operator - Easy Deployment Script
# Supports any amount of METAL tokens (minimum 2,000)

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🏗️  Metal Blockchain Node Operator Deployment${NC}"
echo "=============================================="
echo ""

# Function to validate METAL amount
validate_metal_amount() {
    local amount=$1
    if (( $(echo "$amount < 2000" | bc -l) )); then
        echo -e "${RED}❌ Error: Minimum 2,000 METAL tokens required for validator${NC}"
        echo "You entered: $amount METAL"
        exit 1
    fi
    echo -e "${GREEN}✅ Valid staking amount: $amount METAL${NC}"
}

# Function to convert METAL to wei (18 decimals)
metal_to_wei() {
    local metal_amount=$1
    # Multiply by 10^18 for wei conversion
    echo "${metal_amount}000000000000000000"
}

# Function to calculate expected monthly revenue
calculate_revenue() {
    local metal_amount=$1
    local metal_price=${2:-0.50}  # Default $0.50 per METAL
    local apy_low=5
    local apy_high=15
    
    local value_usd=$(echo "$metal_amount * $metal_price" | bc -l)
    local monthly_low=$(echo "$value_usd * $apy_low / 100 / 12" | bc -l)
    local monthly_high=$(echo "$value_usd * $apy_high / 100 / 12" | bc -l)
    
    printf "💰 Expected Monthly Revenue:\n"
    printf "   METAL Value: $%.0f ($%.2f/METAL)\n" "$value_usd" "$metal_price"
    printf "   Conservative (5%% APY): $%.0f/month\n" "$monthly_low"
    printf "   Optimistic (15%% APY): $%.0f/month\n" "$monthly_high"
    printf "   Akash Costs: ~$350/month\n"
    printf "   Net Profit: $%.0f - $%.0f/month\n" "$(echo "$monthly_low - 350" | bc -l)" "$(echo "$monthly_high - 350" | bc -l)"
}

# Get user inputs
echo -e "${YELLOW}📋 Please provide the following information:${NC}"
echo ""

# Validator name
read -p "🏷️  Validator name (default: akash_template_deployment): " VALIDATOR_NAME
VALIDATOR_NAME=${VALIDATOR_NAME:-akash_template_deployment}

# Metal wallet address
read -p "🔑 Metal wallet address (P-metal...): " METAL_WALLET
if [[ ! $METAL_WALLET =~ ^P-metal[a-zA-Z0-9]+ ]]; then
    echo -e "${RED}❌ Invalid Metal wallet address format${NC}"
    echo "Expected format: P-metal..."
    exit 1
fi

# METAL staking amount
read -p "💎 METAL tokens to stake (minimum 2000): " STAKING_AMOUNT
validate_metal_amount "$STAKING_AMOUNT"

# Convert to wei
STAKING_AMOUNT_WEI=$(metal_to_wei "$STAKING_AMOUNT")

# Expected APY
read -p "📈 Expected APY % (default: 10): " EXPECTED_APY
EXPECTED_APY=${EXPECTED_APY:-10}

# Grafana password
read -p "🔐 Grafana dashboard password (default: metal_node_2024): " GRAFANA_PASSWORD
GRAFANA_PASSWORD=${GRAFANA_PASSWORD:-metal_node_2024}

echo ""
echo -e "${GREEN}✅ Configuration Summary:${NC}"
echo "   Validator Name: $VALIDATOR_NAME"
echo "   Metal Wallet: $METAL_WALLET"
echo "   Staking Amount: $STAKING_AMOUNT METAL"
echo "   Expected APY: $EXPECTED_APY%"
echo "   Grafana Password: $GRAFANA_PASSWORD"
echo ""

# Calculate and show revenue projection
calculate_revenue "$STAKING_AMOUNT"
echo ""

# Confirm deployment
read -p "🚀 Deploy Metal Node with these settings? (y/N): " confirm
if [[ ! $confirm =~ ^[Yy]$ ]]; then
    echo "Deployment cancelled."
    exit 0
fi

# Check Akash configuration
echo -e "${BLUE}🔍 Checking Akash configuration...${NC}"

if [ -z "$AKASH_KEY_NAME" ]; then
    echo -e "${RED}❌ AKASH_KEY_NAME not set${NC}"
    echo "Run: export AKASH_KEY_NAME=myWallet"
    exit 1
fi

if [ -z "$AKASH_NODE" ]; then
    echo -e "${RED}❌ AKASH_NODE not set${NC}"
    echo "Run the network configuration commands from DEPLOYMENT-ALL-GUIDE.md"
    exit 1
fi

if [ -z "$AKASH_ACCOUNT_ADDRESS" ]; then
    export AKASH_ACCOUNT_ADDRESS="$(provider-services keys show $AKASH_KEY_NAME -a)"
fi

echo -e "${GREEN}✅ Akash configuration looks good${NC}"
echo "Account: $AKASH_ACCOUNT_ADDRESS"
echo "Node: $AKASH_NODE"

# Check balance
echo -e "${BLUE}💰 Checking account balance...${NC}"
BALANCE=$(provider-services query bank balances --node $AKASH_NODE $AKASH_ACCOUNT_ADDRESS --output json 2>/dev/null | jq -r '.balances[0].amount // "0"' 2>/dev/null || echo "0")
BALANCE_AKT=$((BALANCE / 1000000))

if [ $BALANCE_AKT -lt 5 ]; then
    echo -e "${RED}❌ Insufficient balance: ${BALANCE_AKT} AKT${NC}"
    echo "You need at least 5 AKT to deploy Metal Node"
    echo "Current balance: $BALANCE_AKT AKT"
    echo ""
    echo "Get AKT tokens from:"
    echo "- Coinbase (most user-friendly)"
    echo "- Kraken, Gate.io, or Osmosis DEX"
    exit 1
fi

echo -e "${GREEN}✅ Sufficient balance: ${BALANCE_AKT} AKT${NC}"

# Create deployment file with user's settings
echo -e "${BLUE}📝 Creating deployment configuration...${NC}"

# Create temporary deployment file
DEPLOY_FILE="deploy-${VALIDATOR_NAME}.yml"
cp deploy-flexible.yml "$DEPLOY_FILE"

# Replace placeholders with actual values
sed -i.bak "s/\${VALIDATOR_NAME:-akash_template_deployment}/$VALIDATOR_NAME/g" "$DEPLOY_FILE"
sed -i.bak "s/\${STAKING_AMOUNT_WEI:-2004000000000000000000}/$STAKING_AMOUNT_WEI/g" "$DEPLOY_FILE"
sed -i.bak "s/\${METAL_WALLET:-P-metal1dyqrc76fstllslqy50lg9pfd5fvfdnhpqwj5lm}/$METAL_WALLET/g" "$DEPLOY_FILE"
sed -i.bak "s/\${STAKING_AMOUNT:-2004}/$STAKING_AMOUNT/g" "$DEPLOY_FILE"
sed -i.bak "s/\${EXPECTED_APY:-10}/$EXPECTED_APY/g" "$DEPLOY_FILE"
sed -i.bak "s/\${GRAFANA_PASSWORD:-metal_node_2024}/$GRAFANA_PASSWORD/g" "$DEPLOY_FILE"

# Clean up backup file
rm "${DEPLOY_FILE}.bak"

echo -e "${GREEN}✅ Deployment file created: $DEPLOY_FILE${NC}"

# Deploy to Akash
echo -e "${BLUE}🚀 Deploying Metal Node to Akash...${NC}"
echo "This will create a deployment and escrow ~5 AKT..."

provider-services tx deployment create "$DEPLOY_FILE" --from $AKASH_KEY_NAME --yes

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Deployment created successfully!${NC}"
    echo ""
    echo -e "${YELLOW}📋 Next steps:${NC}"
    echo "1. Wait for provider bids (1-5 minutes)"
    echo "2. Check bids: provider-services query market bid list --owner=\$AKASH_ACCOUNT_ADDRESS --node \$AKASH_NODE --dseq DSEQ_NUMBER --state=open"
    echo "3. Create lease with chosen provider"
    echo "4. Send manifest to start your Metal node"
    echo ""
    echo -e "${BLUE}💡 Tip: Save your deployment sequence number (DSEQ) from the output above${NC}"
    echo ""
    echo -e "${GREEN}🎉 Your Metal validator will start earning staking rewards once deployed!${NC}"
    
    # Save deployment info
    echo "VALIDATOR_NAME=$VALIDATOR_NAME" > "deployment-${VALIDATOR_NAME}.env"
    echo "METAL_WALLET=$METAL_WALLET" >> "deployment-${VALIDATOR_NAME}.env"
    echo "STAKING_AMOUNT=$STAKING_AMOUNT" >> "deployment-${VALIDATOR_NAME}.env"
    echo "EXPECTED_APY=$EXPECTED_APY" >> "deployment-${VALIDATOR_NAME}.env"
    echo "DEPLOY_FILE=$DEPLOY_FILE" >> "deployment-${VALIDATOR_NAME}.env"
    
    echo -e "${BLUE}💾 Deployment info saved to: deployment-${VALIDATOR_NAME}.env${NC}"
else
    echo -e "${RED}❌ Deployment failed${NC}"
    exit 1
fi
