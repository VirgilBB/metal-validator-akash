# Metal Validator - CLI Deployment Guide

**Fast, efficient deployment using `provider-services` CLI instead of Akash Console.**

---

## Prerequisites

1. **Install provider-services CLI**
```bash
# MacOS (Homebrew)
brew tap akash-network/tap
brew install akash-provider-services

# Or download binary
curl -sfL https://raw.githubusercontent.com/akash-network/provider/main/install.sh | bash
sudo mv ./bin/provider-services /usr/local/bin
```

2. **Verify installation**
```bash
provider-services version
# Should show: v0.10.0 or later
```

---

## Setup (One-Time)

### 1. Configure Environment

```bash
# Network configuration (MAINNET)
export AKASH_NET="https://raw.githubusercontent.com/akash-network/net/main/mainnet"
export AKASH_CHAIN_ID="akashnet-2"
export AKASH_NODE="https://rpc.akashnet.net:443"

# Gas settings
export AKASH_GAS="auto"
export AKASH_GAS_ADJUSTMENT="1.5"
export AKASH_GAS_PRICES="0.025uakt"

# Wallet
export AKASH_KEY_NAME="my-wallet"
export AKASH_KEYRING_BACKEND="os"
```

### 2. Create or Import Wallet

**New wallet:**
```bash
provider-services keys add $AKASH_KEY_NAME
# SAVE THE MNEMONIC!
```

**Import existing:**
```bash
provider-services keys add $AKASH_KEY_NAME --recover
# Enter your 24-word mnemonic
```

### 3. Get Wallet Address

```bash
export AKASH_ACCOUNT_ADDRESS="$(provider-services keys show $AKASH_KEY_NAME -a)"
echo $AKASH_ACCOUNT_ADDRESS
```

### 4. Fund Wallet

Minimum 0.5 AKT required. Check balance:
```bash
provider-services query bank balances $AKASH_ACCOUNT_ADDRESS
```

---

## Deploy Metal Validator (CLI Method)

### 1. Navigate to Template Directory

```bash
cd ~/akash/templates/metal-node
```

### 2. Create Deployment

```bash
provider-services tx deployment create deploy-testnet.yml \
  --from $AKASH_KEY_NAME
```

**Save the DSEQ (deployment sequence number)** from the output:
```
"dseq": "12345678"
```

Set it as a variable:
```bash
export AKASH_DSEQ=12345678
```

### 3. Wait for Bids (30 seconds)

```bash
sleep 30
```

### 4. Query Bids

```bash
provider-services query market bid list \
  --owner $AKASH_ACCOUNT_ADDRESS \
  --dseq $AKASH_DSEQ
```

**Choose a provider and save the address:**
```bash
export AKASH_PROVIDER="akash1..."
```

### 5. Create Lease

```bash
provider-services tx market lease create \
  --dseq $AKASH_DSEQ \
  --gseq 1 \
  --oseq 1 \
  --provider $AKASH_PROVIDER \
  --from $AKASH_KEY_NAME
```

### 6. Send Manifest

```bash
provider-services send-manifest deploy-testnet.yml \
  --dseq $AKASH_DSEQ \
  --provider $AKASH_PROVIDER \
  --from $AKASH_KEY_NAME
```

---

## Monitor Deployment

### View Logs

```bash
provider-services lease-logs \
  --dseq $AKASH_DSEQ \
  --provider $AKASH_PROVIDER \
  --from $AKASH_KEY_NAME
```

### Check Status

```bash
provider-services lease-status \
  --dseq $AKASH_DSEQ \
  --provider $AKASH_PROVIDER \
  --from $AKASH_KEY_NAME
```

### Get Service URI

```bash
provider-services lease-status \
  --dseq $AKASH_DSEQ \
  --provider $AKASH_PROVIDER \
  --from $AKASH_KEY_NAME | jq -r '.services.metal-blockchain.uris[0]'
```

---

## Update Deployment

If you need to change the image version or environment variables:

### 1. Edit SDL File

```bash
nano deploy-testnet.yml
# Make changes (image version, env vars, etc.)
```

### 2. Update On-Chain Hash

```bash
provider-services tx deployment update deploy-testnet.yml \
  --dseq $AKASH_DSEQ \
  --from $AKASH_KEY_NAME
```

### 3. Send Updated Manifest

```bash
provider-services send-manifest deploy-testnet.yml \
  --dseq $AKASH_DSEQ \
  --provider $AKASH_PROVIDER \
  --from $AKASH_KEY_NAME
```

---

## Close Deployment

```bash
provider-services tx deployment close \
  --dseq $AKASH_DSEQ \
  --from $AKASH_KEY_NAME
```

This returns your deposit and closes all leases.

---

## Complete Deployment Script

Save this as `deploy-metal.sh`:

```bash
#!/bin/bash

# Metal Validator Quick Deploy Script

# Check environment variables
if [ -z "$AKASH_KEY_NAME" ] || [ -z "$AKASH_NODE" ] || [ -z "$AKASH_CHAIN_ID" ]; then
  echo "Error: Environment variables not set. Run setup first."
  exit 1
fi

SDL_FILE="${1:-deploy-testnet.yml}"

if [ ! -f "$SDL_FILE" ]; then
  echo "Error: SDL file not found: $SDL_FILE"
  exit 1
fi

echo "Deploying: $SDL_FILE"

# Create deployment
echo "Creating deployment..."
RESULT=$(provider-services tx deployment create "$SDL_FILE" \
  --from $AKASH_KEY_NAME -y --output json)

DSEQ=$(echo "$RESULT" | jq -r '.logs[0].events[] | select(.type=="akash.v1.EventDeploymentCreated") | .attributes[] | select(.key=="dseq") | .value')

if [ -z "$DSEQ" ] || [ "$DSEQ" = "null" ]; then
  echo "Error: Could not extract DSEQ from deployment creation"
  echo "$RESULT"
  exit 1
fi

echo "Deployment created: DSEQ=$DSEQ"
echo "Waiting for bids (30 seconds)..."
sleep 30

# Query bids
AKASH_ADDRESS=$(provider-services keys show $AKASH_KEY_NAME -a)
BIDS=$(provider-services query market bid list \
  --owner $AKASH_ADDRESS \
  --dseq $DSEQ \
  --output json)

PROVIDER=$(echo "$BIDS" | jq -r '.bids[0].bid.bid_id.provider // empty')

if [ -z "$PROVIDER" ]; then
  echo "Error: No bids received"
  exit 1
fi

echo "Creating lease with provider: $PROVIDER"
provider-services tx market lease create \
  --dseq $DSEQ \
  --gseq 1 \
  --oseq 1 \
  --provider $PROVIDER \
  --from $AKASH_KEY_NAME -y

sleep 5

echo "Sending manifest..."
provider-services send-manifest "$SDL_FILE" \
  --dseq $DSEQ \
  --provider $PROVIDER \
  --from $AKASH_KEY_NAME

echo ""
echo "========================================="
echo "Deployment complete!"
echo "========================================="
echo "DSEQ: $DSEQ"
echo "Provider: $PROVIDER"
echo ""
echo "View logs:"
echo "  provider-services lease-logs --dseq $DSEQ --provider $PROVIDER --from $AKASH_KEY_NAME"
echo ""
echo "Get service URI:"
echo "  provider-services lease-status --dseq $DSEQ --provider $PROVIDER --from $AKASH_KEY_NAME | jq -r '.services.metal-blockchain.uris[0]'"
```

Make it executable:
```bash
chmod +x deploy-metal.sh
```

Run it:
```bash
./deploy-metal.sh deploy-testnet.yml
```

---

## Troubleshooting

### "insufficient fees"
Increase gas prices:
```bash
export AKASH_GAS_PRICES="0.05uakt"
```

### "no bids received"
Wait longer (some providers take 60-90 seconds), or increase pricing in SDL:
```yaml
pricing:
  metal-blockchain:
    amount: 5000  # Increase from 3000
```

### "account not found"
Fund your wallet with at least 0.5 AKT.

### RPC Node Down
Try alternative RPC:
```bash
export AKASH_NODE="https://rpc.akash.forbole.com:443"
# or
export AKASH_NODE="https://akash-rpc.polkachu.com:443"
```

---

## Persistent Configuration

Add to `~/.bashrc` or `~/.zshrc`:

```bash
# Akash Network Configuration
export AKASH_NET="https://raw.githubusercontent.com/akash-network/net/main/mainnet"
export AKASH_CHAIN_ID="akashnet-2"
export AKASH_NODE="https://rpc.akashnet.net:443"
export AKASH_GAS="auto"
export AKASH_GAS_ADJUSTMENT="1.5"
export AKASH_GAS_PRICES="0.025uakt"
export AKASH_KEY_NAME="my-wallet"
export AKASH_KEYRING_BACKEND="os"

# Set wallet address automatically
export AKASH_ACCOUNT_ADDRESS="$(provider-services keys show $AKASH_KEY_NAME -a 2>/dev/null)"
```

Then:
```bash
source ~/.bashrc  # or ~/.zshrc
```

---

## Why CLI vs Console?

**CLI Advantages:**
- **Faster:** No UI loading times
- **Scriptable:** Automate deployments
- **Reproducible:** Version-controlled scripts
- **Efficient:** No manual clicking
- **Power user:** More control and options

**CLI Disadvantages:**
- Requires environment setup
- Less visual feedback
- Need to remember commands

For production deployments and repeated testing, **CLI is significantly faster**.

