# Metal Blockchain Node - Akash Console Deployment

## 🌐 **Deploy via Akash Console (Recommended for Most Users)**

### **Step 1: Access Akash Console**
1. **Go to**: https://console.akash.network
2. **Connect your wallet** (Keplr, Cosmostation, etc.)
3. **Switch to Mainnet** (not Sandbox)

### **Step 2: Create New Deployment**
1. **Click**: "Create Deployment"
2. **Choose**: "Custom Template" or "Upload SDL"
3. **Upload**: `deploy-simple.yml` file

### **Step 3: Configure Your Metal Node**
**Before uploading, edit the SDL file with your details:**

```yaml
# Replace these values in deploy-simple.yml:
env:
  - METAL_VALIDATOR_NAME=YOUR_VALIDATOR_NAME
  - METAL_STAKING_AMOUNT=YOUR_METAL_AMOUNT_IN_WEI
  - METAL_WALLET_ADDRESS=YOUR_METAL_WALLET_ADDRESS
```

**Example for your setup:**
```yaml
env:
  - METAL_VALIDATOR_NAME=akash_template_deployment
  - METAL_STAKING_AMOUNT=2004000000000000000000  # 2004 METAL in wei
  - METAL_WALLET_ADDRESS=P-metal1dyqrc76fstllslqy50lg9pfd5fvfdnhpqwj5lm
```

### **Step 4: Deploy and Monitor**
1. **Review configuration** in Console
2. **Click "Deploy"**
3. **Wait for provider bids** (1-5 minutes)
4. **Accept a bid** (choose lowest price)
5. **Monitor deployment** in Console dashboard

---

## 💻 **Deploy via Command Line (Advanced Users)**

### **Your Current Setup:**
```bash
cd /Users/vb/akash/templates/metal-node-operator
./deploy-simple.sh
```

**This will:**
- ✅ Ask for your validator name
- ✅ Ask for your Metal wallet address  
- ✅ Ask for your METAL amount
- ✅ Create deployment automatically
- ✅ Handle all the Akash CLI commands

---

## 🎯 **Which Method Should We Test?**

### **For Template Validation:**
**I recommend testing BOTH:**

1. **🌐 Console First** (most users will use this)
   - Upload `deploy-simple.yml` 
   - Edit environment variables
   - Deploy through web interface
   - Monitor in Console dashboard

2. **💻 CLI Second** (for advanced users)
   - Run `./deploy-simple.sh`
   - Interactive configuration
   - Automated deployment

### **Let's Test Console Deployment Now:**
<｜tool▁calls▁begin｜><｜tool▁call▁begin｜>
run_terminal_cmd
