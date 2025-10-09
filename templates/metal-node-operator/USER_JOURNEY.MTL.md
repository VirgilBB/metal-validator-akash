# Metal Blockchain Validator - Complete User Journey

## 🎯 **What This Template Does**

### **Template Purpose:**
1. **Deploy Metal node** on Akash decentralized cloud
2. **Extract Node ID** automatically from running node
3. **Extract Staking Keys** (Public Key + Signature)
4. **Provide complete validator data** for Metal dashboard setup

### **What Template DOESN'T Do:**
- ❌ Set validator name (user does this on dashboard)
- ❌ Configure staking amounts (user does this on dashboard)  
- ❌ Set staking dates (user does this on dashboard)
- ❌ Handle wallet addresses (user provides their own)

---

## 👤 **Target User Profile**
- **Assets**: 2,000+ METAL tokens ready for staking
- **Goal**: Earn 5-15% APY through Metal validator staking
- **Experience**: New to Akash, familiar with cryptocurrency
- **Time Investment**: 30-60 minutes setup, passive income thereafter

---

## 🎯 **Expected Outcomes**
- **Monthly Revenue**: $500-$2,000 (based on 2,000+ METAL at 5-15% APY)
- **Setup Cost**: $10-40 (5-10 AKT tokens for Akash deployment)
- **Ongoing Costs**: ~$350/month (Akash compute costs)
- **Net Profit**: $150-$1,650/month

---

## 📋 **Prerequisites Checklist**

### ✅ **Required Assets**
- [ ] **2,000+ METAL tokens** (minimum for validator)
- [ ] **Metal wallet** with private key access
- [ ] **5-10 AKT tokens** (~$10-40 for Akash deployment)
- [ ] **Akash wallet** (we'll create this)

### ✅ **Technical Requirements**
- [ ] **Computer** (Mac/Linux/Windows)
- [ ] **Internet connection** (stable)
- [ ] **Terminal access** (basic command line)
- [ ] **30-60 minutes** for initial setup

---

## 🚀 **Step-by-Step Journey**

### **Phase 1: Preparation (10 minutes)**

#### **Step 1.1: Install Akash CLI**
```bash
# macOS
brew tap akash-network/tap
brew install akash-provider-services

# Verify installation
provider-services version
```

#### **Step 1.2: Create Akash Account**
```bash
# Set environment variables
export AKASH_KEY_NAME=myWallet
export AKASH_KEYRING_BACKEND=os

# Create new account
provider-services keys add $AKASH_KEY_NAME

# IMPORTANT: Save the 24-word mnemonic phrase!
```

#### **Step 1.3: Configure Akash Mainnet**
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

### **Phase 2: Funding (15 minutes)**

#### **Step 2.1: Get AKT Tokens**
**Purchase 5-10 AKT tokens from:**
- **Coinbase**: Most user-friendly, widely available
- **Kraken**: Professional trading platform
- **Gate.io**: Alternative centralized exchange
- **Osmosis DEX**: Decentralized option

**Send AKT to your Akash address:**
```bash
echo $AKASH_ACCOUNT_ADDRESS
# Send AKT to this address
```

#### **Step 2.2: Create Certificate**
```bash
# Generate certificate
provider-services tx cert generate client --from $AKASH_KEY_NAME

# Publish certificate (costs ~277 uakt)
provider-services tx cert publish client --from $AKASH_KEY_NAME --yes
```

### **Phase 3: Deployment (20 minutes)**

#### **Step 3.1: Deploy Metal Node**
```bash
# Navigate to template directory
cd /path/to/templates/metal-node-operator

# Deploy to Akash (costs ~5 AKT escrow)
provider-services tx deployment create deploy-testnet-cerebro.yml --from $AKASH_KEY_NAME --yes
```

#### **Step 3.2: Accept Provider Bid**
```bash
# Set deployment sequence (from deployment output)
export AKASH_DSEQ=YOUR_DSEQ_NUMBER

# View available bids
provider-services query market bid list --owner=$AKASH_ACCOUNT_ADDRESS --node $AKASH_NODE --dseq $AKASH_DSEQ --state=open

# Choose provider and create lease
export AKASH_PROVIDER=CHOSEN_PROVIDER_ADDRESS
provider-services tx market lease create --dseq $AKASH_DSEQ --provider $AKASH_PROVIDER --from $AKASH_KEY_NAME --yes
```

#### **Step 3.3: Send Manifest**
```bash
# Upload deployment manifest
provider-services send-manifest deploy-testnet-cerebro.yml --dseq $AKASH_DSEQ --provider $AKASH_PROVIDER --from $AKASH_KEY_NAME
```

### **Phase 4: Extract Validator Data (5 minutes)**

#### **Step 4.1: Monitor Deployment Logs**
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
NodeID-[YOUR_NODE_ID]

Proof of Possession
The public key portion of the proof of possession:

Public Key:
-----BEGIN PUBLIC KEY-----
[YOUR_PUBLIC_KEY]
-----END PUBLIC KEY-----

The signature portion of the proof of possession:

Signature:
[YOUR_SIGNATURE_HEX_STRING]
```

#### **Step 4.2: Copy Validator Data**
**Save these three pieces of data:**
1. **Node ID**: `NodeID-[YOUR_NODE_ID]`
2. **Public Key**: The full PEM format key
3. **Signature**: The hexadecimal signature string

### **Phase 5: Complete Validator Setup (10 minutes)**

#### **Step 5.1: Access Metal Dashboard**
- Go to **Metal Validator Dashboard**
- Navigate to **"Add Validator"** section

#### **Step 5.2: Enter Validator Data**
1. **Node ID**: Paste the NodeID from template logs
2. **Public Key**: Paste the full public key from logs
3. **Signature**: Paste the signature hex string from logs
4. **Validator Name**: Choose your validator name
5. **Staking Amount**: Enter your METAL amount (2000+ tokens)
6. **Staking Duration**: Choose duration (21+ days)
7. **Reward Address**: Your Metal wallet address

#### **Step 5.3: Submit Validator Registration**
- Review all information
- Submit validator transaction
- Wait for confirmation

---

## 💰 **Revenue Expectations**

### **Monthly Breakdown**
| Component | Amount | Notes |
|-----------|--------|-------|
| **Staking Rewards** | $500-$2,000 | 5-15% APY on 2,000+ METAL |
| **Akash Costs** | -$350 | Compute resources |
| **AKT Fees** | -$5 | Transaction fees |
| **Net Profit** | **$145-$1,645** | **Monthly passive income** |

### **Annual Projection**
- **Conservative (5% APY)**: $1,740/year net profit
- **Moderate (10% APY)**: $9,840/year net profit  
- **Optimistic (15% APY)**: $17,940/year net profit

---

## 🔧 **Troubleshooting Guide**

### **Common Issues**

#### **"No bids received"**
- **Cause**: Resource requirements too high
- **Solution**: Reduce CPU/memory in deploy.yml

#### **"Insufficient balance"**
- **Cause**: Not enough AKT for escrow
- **Solution**: Add more AKT to wallet

#### **"Certificate not found"**
- **Cause**: Certificate not published
- **Solution**: Re-run certificate publish command

#### **"Metal node not syncing"**
- **Cause**: Network connectivity issues
- **Solution**: Check firewall settings, restart deployment

#### **"Node ID not found"**
- **Cause**: Node not fully started
- **Solution**: Wait 5-10 minutes for full initialization

#### **"Signature extraction failed"**
- **Cause**: Certificate parsing issues
- **Solution**: Check staking keys exist, restart if needed

### **Support Resources**
- **Akash Discord**: https://discord.akash.network
- **Metal Blockchain Telegram**: https://t.me/MetalBlockchainValidators
- **Documentation**: This guide + deployment files

---

## 📊 **Success Metrics**

### **Week 1 Targets**
- [ ] Node deployed and running
- [ ] Blockchain synced (100%)
- [ ] Validator data extracted successfully
- [ ] Validator registered on Metal dashboard

### **Month 1 Targets**
- [ ] Consistent uptime (>99%)
- [ ] Staking rewards accumulating
- [ ] Validator active on Metal network
- [ ] ROI calculation positive

### **Ongoing Monitoring**
- **Daily**: Check node status via Akash
- **Weekly**: Review staking rewards on Metal dashboard
- **Monthly**: Calculate ROI and adjust if needed

---

## 🎉 **Congratulations!**

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
4. **Consider additional** Akash templates for diversification

**Welcome to the decentralized economy!** 🚀

---

## 📞 **Template Support**

### **Template Issues:**
- Check port accessibility (9650/9651)
- Verify node sync status
- Monitor deployment logs for validator data

### **Validator Setup:**
- Use Metal dashboard for configuration
- Follow Metal documentation for staking
- Contact Metal support for validator issues

**This template provides the infrastructure, users provide the configuration!** 🚀