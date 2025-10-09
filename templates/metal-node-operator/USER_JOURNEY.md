# Metal Blockchain Node Operator - Complete User Journey

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

### **Phase 3: Configuration (15 minutes)**

#### **Step 3.1: Prepare Metal Wallet Information**
**Gather the following:**
- [ ] **Metal wallet address** (where your METAL tokens are)
- [ ] **Metal private key** (for validator setup)
- [ ] **Validator name** (public name for your node)
- [ ] **Staking amount** (e.g., 2005 METAL)

#### **Step 3.2: Update Deployment Configuration**
**Edit the deployment file with your details:**
```yaml
# In deploy-mainnet.yml, update:
env:
  - METAL_VALIDATOR_NAME=YOUR_VALIDATOR_NAME
  - METAL_STAKING_AMOUNT=2005000000000000000000  # Your METAL amount in wei
  
# In revenue-tracker service:
env:
  - STAKING_AMOUNT=2005  # Your METAL amount
  - VALIDATOR_ADDRESS=YOUR_METAL_WALLET_ADDRESS
```

### **Phase 4: Deployment (20 minutes)**

#### **Step 4.1: Deploy Metal Node**
```bash
# Navigate to template directory
cd /path/to/templates/metal-node-operator

# Deploy to Akash (costs ~5 AKT escrow)
provider-services tx deployment create deploy-mainnet.yml --from $AKASH_KEY_NAME --yes
```

#### **Step 4.2: Accept Provider Bid**
```bash
# Set deployment sequence (from deployment output)
export AKASH_DSEQ=YOUR_DSEQ_NUMBER

# View available bids
provider-services query market bid list --owner=$AKASH_ACCOUNT_ADDRESS --node $AKASH_NODE --dseq $AKASH_DSEQ --state=open

# Choose provider and create lease
export AKASH_PROVIDER=CHOSEN_PROVIDER_ADDRESS
provider-services tx market lease create --dseq $AKASH_DSEQ --provider $AKASH_PROVIDER --from $AKASH_KEY_NAME --yes
```

#### **Step 4.3: Send Manifest**
```bash
# Upload deployment manifest
provider-services send-manifest deploy-mainnet.yml --dseq $AKASH_DSEQ --provider $AKASH_PROVIDER --from $AKASH_KEY_NAME
```

### **Phase 5: Validation & Monitoring (Ongoing)**

#### **Step 5.1: Access Your Node**
```bash
# Get deployment URLs
provider-services lease-status --dseq $AKASH_DSEQ --from $AKASH_KEY_NAME --provider $AKASH_PROVIDER
```

**Access points:**
- **Grafana Dashboard**: `http://YOUR_DEPLOYMENT_URL:3000` (admin/metal_node_2024)
- **Metal Node RPC**: `http://YOUR_DEPLOYMENT_URL:9650`
- **Prometheus Metrics**: `http://YOUR_DEPLOYMENT_URL:9090`
- **Revenue Tracker**: `http://YOUR_DEPLOYMENT_URL:8080`

#### **Step 5.2: Configure Staking**
1. **Access Metal node** via RPC endpoint
2. **Import your Metal wallet** private key
3. **Start validator** with your METAL tokens
4. **Monitor staking rewards** via dashboard

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

### **Support Resources**
- **Akash Discord**: https://discord.akash.network
- **Metal Blockchain Telegram**: https://t.me/MetalBlockchainValidators
- **Documentation**: This guide + deployment files

---

## 📊 **Success Metrics**

### **Week 1 Targets**
- [ ] Node deployed and running
- [ ] Blockchain synced (100%)
- [ ] Validator active and staking
- [ ] Monitoring dashboards operational

### **Month 1 Targets**
- [ ] Consistent uptime (>99%)
- [ ] Staking rewards accumulating
- [ ] Revenue tracking accurate
- [ ] ROI calculation positive

### **Ongoing Monitoring**
- **Daily**: Check node status via Grafana
- **Weekly**: Review staking rewards
- **Monthly**: Calculate ROI and adjust if needed

---

## 🎉 **Congratulations!**

You've successfully deployed a **Metal Blockchain Node Operator** on Akash Network!

**Your setup provides:**
- ✅ **Passive income** from METAL staking
- ✅ **Professional monitoring** with Grafana dashboards
- ✅ **Cost-effective hosting** on decentralized cloud
- ✅ **Scalable infrastructure** for additional validators

**Next steps:**
1. **Monitor your rewards** daily
2. **Scale up** with more METAL tokens
3. **Share your success** in Metal community
4. **Consider additional** Akash templates for diversification

**Welcome to the decentralized economy!** 🚀
