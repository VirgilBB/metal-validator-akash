# Metal Validator Deployment Tutorial

A step-by-step guide to deploy a Metal blockchain validator on Akash Network.

## 🎯 What This Tutorial Does

This tutorial will help you:
1. **Deploy a Metal validator node** on Akash Network
2. **Extract validator data** (Node ID, Public Key, Signature)
3. **Complete validator setup** on Metal dashboard
4. **Start earning staking rewards**

## 📋 Prerequisites

### Required Assets
- **2,000+ METAL tokens** (minimum for validator)
- **5-10 AKT tokens** (~$10-40 for Akash deployment)
- **Metal wallet** with private key access

### Technical Requirements
- **Computer** (Mac/Linux/Windows)
- **Internet connection** (stable)
- **Terminal access** (basic command line)
- **30-60 minutes** for setup

## 🚀 Step-by-Step Deployment

### Step 1: Install Akash CLI

#### macOS
```bash
brew tap akash-network/tap
brew install akash-provider-services
```

#### Linux/Windows
```bash
curl -sSL https://raw.githubusercontent.com/akash-network/provider/main/install.sh | bash
```

### Step 2: Create Akash Account

```bash
# Set environment variables
export AKASH_KEY_NAME=myWallet
export AKASH_KEYRING_BACKEND=os

# Create new account
provider-services keys add $AKASH_KEY_NAME

# IMPORTANT: Save the 24-word mnemonic phrase!
```

### Step 3: Configure Akash Network

```bash
# Configure for mainnet
export AKASH_NET="https://raw.githubusercontent.com/akash-network/net/main/mainnet"
export AKASH_CHAIN_ID="$(curl -s "$AKASH_NET/chain-id.txt")"
export AKASH_NODE="$(curl -s "$AKASH_NET/rpc-nodes.txt" | head -n 1)"
export AKASH_ACCOUNT_ADDRESS="$(provider-services keys show $AKASH_KEY_NAME -a)"

# Set gas configuration
export AKASH_GAS=auto
export AKASH_GAS_ADJUSTMENT=1.25
export AKASH_GAS_PRICES=0.0025uakt
export AKASH_SIGN_MODE=amino-json
```

### Step 4: Get AKT Tokens

**Purchase 5-10 AKT tokens from:**
- **Coinbase**: Most user-friendly
- **Kraken**: Professional platform
- **Gate.io**: Alternative exchange
- **Osmosis DEX**: Decentralized option

**Send AKT to your address:**
```bash
echo $AKASH_ACCOUNT_ADDRESS
# Send AKT to this address
```

### Step 5: Create Certificate

```bash
# Generate certificate
provider-services tx cert generate client --from $AKASH_KEY_NAME

# Publish certificate (costs ~277 uakt)
provider-services tx cert publish client --from $AKASH_KEY_NAME --yes
```

### Step 6: Deploy Metal Validator

#### For Testnet (Recommended First)
```bash
# Deploy to Metal Tahoe Testnet
provider-services tx deployment create deploy-testnet-cerebro.yml --from $AKASH_KEY_NAME --yes
```

#### For Mainnet
```bash
# Deploy to Metal Mainnet
provider-services tx deployment create deploy.yml --from $AKASH_KEY_NAME --yes
```

### Step 7: Accept Provider Bid

```bash
# Set deployment sequence (from deployment output)
export AKASH_DSEQ=YOUR_DSEQ_NUMBER

# View available bids
provider-services query market bid list --owner=$AKASH_ACCOUNT_ADDRESS --node $AKASH_NODE --dseq $AKASH_DSEQ --state=open

# Choose provider and create lease
export AKASH_PROVIDER=CHOSEN_PROVIDER_ADDRESS
provider-services tx market lease create --dseq $AKASH_DSEQ --provider $AKASH_PROVIDER --from $AKASH_KEY_NAME --yes
```

### Step 8: Send Manifest

```bash
# Upload deployment manifest
provider-services send-manifest deploy-testnet-cerebro.yml --dseq $AKASH_DSEQ --provider $AKASH_PROVIDER --from $AKASH_KEY_NAME
```

## 📊 Extract Validator Data

### Step 9: Monitor Deployment Logs

```bash
# Get deployment status
provider-services lease-status --dseq $AKASH_DSEQ --from $AKASH_KEY_NAME --provider $AKASH_PROVIDER
```

**Look for this section in the logs:**

```
========================================
=== METAL TESTNET VALIDATOR SETUP DATA ===
========================================

Copy the following data to your Metal TESTNET dashboard:

Node ID:
NodeID-YourNodeIDHere

Proof of Possession (Public Key):
0x3059301306072a8648ce3d020106082a8648ce3d03010703420004...

Signature:
3045022100aceb51df23c56286126054f1c53b78befe78a7724881dcd6e9c67cf068d04ecd0221009c7af5e25f6206470f30054699c8dafad1702372740122392a7d631a9ba5a74b
```

### Step 10: Copy Validator Data

**Save these three pieces of data:**
1. **Node ID**: `NodeID-YourNodeIDHere` (include the full "NodeID-" prefix)
2. **Public Key**: The 0x hexadecimal string
3. **Signature**: The hexadecimal signature string

## 🎯 Complete Validator Setup

### Step 11: Access Metal Dashboard

- Go to **Metal Validator Dashboard**
- Navigate to **"Add Validator"** section

### Step 12: Enter Validator Data

1. **Node ID**: Paste the complete NodeID (including "NodeID-" prefix)
2. **Public Key**: Paste the 0x hexadecimal string
3. **Signature**: Paste the signature hex string
4. **Validator Name**: Choose your validator name
5. **Staking Amount**: Enter your METAL amount (2000+ tokens)
6. **Staking Duration**: Choose duration (21+ days)
7. **Reward Address**: Your Metal wallet address

### Step 13: Submit Validator Registration

- Review all information
- Submit validator transaction
- Wait for confirmation

## 💰 Expected Results

### Monthly Revenue
- **Staking Rewards**: $500-$2,000 (5-15% APY on 2,000+ METAL)
- **Akash Costs**: ~$350/month
- **Net Profit**: $150-$1,650/month

### Success Indicators
- ✅ Node deployed and running
- ✅ Blockchain synced (100%)
- ✅ Validator data extracted successfully
- ✅ Validator registered on Metal dashboard
- ✅ Staking rewards accumulating

## 🔧 Troubleshooting

### Common Issues

#### "No bids received"
- **Cause**: Resource requirements too high
- **Solution**: Check template resource requirements

#### "Insufficient balance"
- **Cause**: Not enough AKT for escrow
- **Solution**: Add more AKT to wallet

#### "Certificate not found"
- **Cause**: Certificate not published
- **Solution**: Re-run certificate publish command

#### "Node ID not found"
- **Cause**: Node not fully started
- **Solution**: Wait 5-10 minutes for full initialization

### Support Resources
- **Akash Discord**: https://discord.akash.network
- **Metal Blockchain Telegram**: https://t.me/MetalBlockchainValidators
- **Template Repository**: https://github.com/VirgilBB/metal-validator-akash

## 🎉 Congratulations!

You've successfully deployed a **Metal Blockchain Validator** on Akash Network!

**Your setup provides:**
- ✅ **Passive income** from METAL staking
- ✅ **Decentralized hosting** on Akash network
- ✅ **Professional validator infrastructure**
- ✅ **Scalable setup** for additional validators

**Next steps:**
1. **Monitor your rewards** on Metal dashboard
2. **Scale up** with more METAL tokens
3. **Share your success** in Metal community

**Welcome to the decentralized economy!** 🚀
