# Metal Node Operator - Quick Start Guide

## 🎯 **Your Specific Configuration**

### **✅ Ready to Deploy:**
- **Akash Wallet**: `akash1fr0pf566qtwm3xp5z7tscnl0zxmq46d7xz22gd` (45.3 AKT ✅)
- **Metal Wallet**: `P-metal1dyqrc76fstllslqy50lg9pfd5fvfdnhpqwj5lm` (2,004 METAL ✅)
- **Validator Name**: `akash_template_deployment`
- **Network**: Akash Mainnet (akashnet-2)

---

## 🚀 **One-Command Deployment**

### **Option 1: Interactive Deployment (Recommended)**
```bash
cd /Users/vb/akash/templates/metal-node-operator
./deploy-metal-node.sh
```

**The script will ask for:**
- Validator name: `akash_template_deployment`
- Metal wallet: `P-metal1dyqrc76fstllslqy50lg9pfd5fvfdnhpqwj5lm`
- METAL amount: `2004` (or any amount ≥2000)
- Expected APY: `10` (or your preference)

### **Option 2: Pre-configured Deployment**
```bash
cd /Users/vb/akash/templates/metal-node-operator

# Set your configuration
export VALIDATOR_NAME="akash_template_deployment"
export METAL_WALLET="P-metal1dyqrc76fstllslqy50lg9pfd5fvfdnhpqwj5lm"
export STAKING_AMOUNT="2004"
export EXPECTED_APY="10"

# Deploy directly
provider-services tx deployment create deploy-flexible.yml --from $AKASH_KEY_NAME --yes
```

---

## 💰 **Your Expected Returns**

### **With 2,004 METAL @ $0.50/METAL:**
- **Portfolio Value**: $1,002
- **Conservative (5% APY)**: $4.18/month
- **Moderate (10% APY)**: $8.35/month
- **Optimistic (15% APY)**: $12.53/month
- **Akash Costs**: ~$350/month
- **Net Result**: **This setup needs higher METAL price or more tokens for profitability**

### **Break-Even Analysis:**
- **At $2.00/METAL**: $33-100/month revenue (still negative after costs)
- **At $5.00/METAL**: $83-250/month revenue (break-even to small profit)
- **At $10.00/METAL**: $167-500/month revenue (profitable)

---

## 🔧 **For Other Users (Any Amount ≥2000 METAL)**

### **Flexible Deployment Script:**
The `deploy-metal-node.sh` script supports:
- ✅ **Any METAL amount** ≥2000 tokens
- ✅ **Custom validator names**
- ✅ **Any Metal wallet address**
- ✅ **Automatic revenue calculations**
- ✅ **Balance validation**

### **Example for Different Users:**
```bash
# User with 5,000 METAL
./deploy-metal-node.sh
# Enter: 5000 METAL, custom name, their wallet

# User with 10,000 METAL  
./deploy-metal-node.sh
# Enter: 10000 METAL, custom name, their wallet
```

---

## 📊 **Monitoring Your Deployment**

### **After Deployment:**
1. **Get deployment URLs**:
   ```bash
   provider-services lease-status --dseq $AKASH_DSEQ --from $AKASH_KEY_NAME --provider $AKASH_PROVIDER
   ```

2. **Access dashboards**:
   - **Grafana**: `http://YOUR_URL:3000` (admin/metal_node_2024)
   - **Metal Node**: `http://YOUR_URL:9650`
   - **Revenue Tracker**: `http://YOUR_URL:8080`

### **Key Metrics to Monitor:**
- ✅ **Node sync status** (should reach 100%)
- ✅ **Validator status** (active/inactive)
- ✅ **Staking rewards** (accumulating)
- ✅ **Uptime** (target >99%)

---

## 🎯 **Success Criteria**

### **Week 1:**
- [ ] Node deployed and syncing
- [ ] Validator registered with 2,004 METAL
- [ ] Monitoring dashboards accessible
- [ ] Revenue tracking operational

### **Month 1:**
- [ ] Consistent uptime >99%
- [ ] Staking rewards accumulating
- [ ] ROI calculation (may be negative initially)
- [ ] Consider scaling up if profitable

---

## 💡 **Optimization Tips**

### **For Profitability:**
1. **Scale up**: Add more METAL tokens when price is favorable
2. **Monitor costs**: Optimize Akash resource allocation
3. **Track performance**: Use Grafana dashboards for insights
4. **Community engagement**: Join Metal validator community

### **For Other Deployers:**
1. **Minimum viable**: 2,000 METAL + realistic price expectations
2. **Sweet spot**: 5,000+ METAL for better economics
3. **Whale territory**: 10,000+ METAL for significant returns

---

## 🚀 **Ready to Deploy?**

**Your setup is ready! Run:**
```bash
cd /Users/vb/akash/templates/metal-node-operator
./deploy-metal-node.sh
```

**The script will handle everything and create your Metal validator node!** 🎉
