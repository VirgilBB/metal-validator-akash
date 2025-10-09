# Metal Testnet Validator Setup Guide

## 🧪 **Testing on Metal Tahoe Testnet**

This guide shows you how to deploy and test a Metal validator on the **Tahoe Testnet** before moving to mainnet.

## 🎯 **Why Test on Testnet First?**

- ✅ **Safe testing** - No real funds at risk
- ✅ **Free testnet tokens** - Get testnet METAL from faucet
- ✅ **Validate setup** - Ensure everything works correctly
- ✅ **Learn the process** - Practice before mainnet

## 🚀 **Quick Start - Testnet Deployment**

### **Step 1: Deploy Testnet Template**

Use the testnet-specific template:
```bash
# Deploy using the testnet template
akash tx deployment create templates/metal-node-operator/deploy-testnet.yml --from myWallet
```

### **Step 2: Get Testnet METAL Tokens**

1. **Visit Metal Faucet**: https://faucet.metalblockchain.org/
2. **Enter your wallet address** (the one you used for deployment)
3. **Complete CAPTCHA** and request testnet METAL
4. **Wait for tokens** to arrive in your wallet

### **Step 3: Monitor Deployment**

Watch the deployment logs for:
```
=== METAL TESTNET VALIDATOR SETUP DATA ===
Copy the following data to your Metal TESTNET dashboard:

1. NODE ID:
NodeID-...

2. PRIVATE KEY (for staking):
-----BEGIN PRIVATE KEY-----
...

3. CERTIFICATE (for staking):
-----BEGIN CERTIFICATE-----
...

4. PUBLIC KEY (extracted from certificate):
-----BEGIN PUBLIC KEY-----
...

5. CERTIFICATE SIGNATURE (for proof of possession):
Signature Algorithm: ecdsa-with-SHA256
...
```

## 🔧 **Testnet Configuration**

### **Network Details:**
- **Network Name**: Metal Tahoe C-Chain
- **Network ID**: 381932 (testnet)
- **RPC URL**: https://tahoe.metalblockchain.org/ext/bc/C/rpc
- **Explorer**: https://tahoe.metalscan.io/
- **Chain ID**: 381932

### **Key Differences from Mainnet:**
- ✅ **Network ID**: 381932 (vs 381931 for mainnet)
- ✅ **Free testnet tokens** available
- ✅ **Separate testnet dashboard**
- ✅ **No real value at risk**

## 📋 **Testnet Validator Setup Process**

### **1. Deploy Testnet Node**
- Use `deploy-testnet.yml` template
- Wait for staking keys to generate
- Copy all validator data from logs

### **2. Access Testnet Dashboard**
- Visit Metal testnet validator dashboard
- Use the testnet-specific URL
- Register with your testnet validator data

### **3. Stake Testnet Tokens**
- Use testnet METAL tokens (from faucet)
- No real money required
- Test the complete validator process

### **4. Verify Testnet Operation**
- Check validator status on testnet explorer
- Monitor testnet performance
- Ensure everything works correctly

## 🎯 **Moving to Mainnet**

Once testnet validation is complete:

1. **Deploy mainnet template**: `deploy.yml` (network ID 381931)
2. **Use real METAL tokens** for staking
3. **Register on mainnet dashboard**
4. **Monitor mainnet performance**

## 📊 **Testnet vs Mainnet Comparison**

| Feature | Testnet | Mainnet |
|---------|---------|---------|
| Network ID | 381932 | 381931 |
| Tokens | Free (faucet) | Real METAL |
| Risk | None | Real value |
| Explorer | tahoe.metalscan.io | metalscan.io |
| RPC | tahoe.metalblockchain.org | metalblockchain.org |

## 🔗 **Testnet Resources**

- **Faucet**: https://faucet.metalblockchain.org/
- **Explorer**: https://tahoe.metalscan.io/
- **RPC**: https://tahoe.metalblockchain.org/ext/bc/C/rpc
- **Documentation**: https://docs.metalblockchain.org/

## ✅ **Success Criteria**

Your testnet deployment is successful when:
- ✅ **Node starts** without errors
- ✅ **Staking keys generate** automatically
- ✅ **All validator data** is displayed in logs
- ✅ **Node connects** to testnet network
- ✅ **Validator registration** works on testnet

## 🚨 **Troubleshooting**

### **Common Issues:**
- **File descriptor limits**: Already handled in template
- **Network connectivity**: Check firewall settings
- **Staking key generation**: Wait for full initialization
- **API access**: Ensure nginx proxy is working

### **Getting Help:**
- Check deployment logs for specific errors
- Verify network connectivity
- Ensure sufficient testnet tokens
- Contact Metal community for support

---

**Ready to test? Deploy the testnet template and start your Metal validator journey!** 🚀
