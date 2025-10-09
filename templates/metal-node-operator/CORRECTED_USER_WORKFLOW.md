# Metal Blockchain Node - Corrected User Workflow

## 🎯 **What This Template Actually Does:**

### **Template Purpose:**
1. **Deploy Metal node** on Akash compute
2. **Extract Node ID** automatically  
3. **Provide Node ID** to user
4. **User completes setup** on Metal dashboard

### **What Template DOESN'T Do:**
- ❌ Set validator name (user does this on dashboard)
- ❌ Configure staking amounts (user does this on dashboard)  
- ❌ Set staking dates (user does this on dashboard)
- ❌ Handle wallet addresses (user provides their own)

---

## 🔧 **Corrected Template Configuration:**

### **Removed Issues:**
- ✅ **No VALIDATOR_NAME** - users set name on dashboard
- ✅ **No WEI references** - use METAL tokens directly
- ✅ **No hardcoded wallet** - template is generic
- ✅ **Fixed port configuration** - proper 9650/9651 exposure

### **Template Environment Variables:**
```yaml
env:
  - METAL_NETWORK_ID=381931
  - METAL_PUBLIC_IP=AKASH_CLUSTER_PUBLIC_HOSTNAME
  - METAL_HTTP_HOST=0.0.0.0
  - METAL_HTTP_PORT=9650
  - METAL_P2P_PORT=9651
  - METAL_STAKING_ENABLED=true
```

---

## 📋 **User Workflow:**

### **Step 1: Deploy Template**
- User deploys template via Akash Console
- Template starts Metal node
- Node generates unique Node ID

### **Step 2: Extract Validator Data**
- User monitors deployment logs
- Extracts Node ID (format: `NodeID-<string>`)
- Extracts Staking Private Key from logs
- Extracts Staking Certificate from logs
- All validator data ready for Metal dashboard setup

### **Step 3: Complete on Metal Dashboard**
- User goes to Metal dashboard
- Enters Node ID from template
- **Sets validator name** (user choice)
- **Sets staking amount** (user choice)
- **Sets staking duration** (user choice)
- **Sets reward address** (user's wallet)
- **Submits validator registration**

---

## 🚨 **Critical Port Configuration:**

### **Required Ports:**
- **9650**: RPC/HTTP API (must be accessible)
- **9651**: P2P Network (must be accessible)

### **Port Issues Fixed:**
- ✅ **Direct port exposure** in SDL
- ✅ **Nginx proxy configuration** for proper routing
- ✅ **CORS headers** for API access
- ✅ **Health check endpoint** for monitoring

### **Port Verification:**
```bash
# Check RPC port
curl http://YOUR_DEPLOYMENT_URL:9650/ext/info

# Check P2P port  
telnet YOUR_DEPLOYMENT_URL 9651
```

---

## 💰 **Staking Configuration:**

### **User Provides:**
- **Staking amount**: Any amount > 2000 METAL
- **Staking duration**: User choice (21 days minimum)
- **Delegation fee**: User choice (2% default)
- **Reward address**: User's Metal wallet

### **Template Provides:**
- **Node ID**: For validator registration
- **Staking Private Key**: For validator authentication
- **Staking Certificate**: For validator verification
- **Running node**: For network participation
- **Port access**: For network connectivity

---

## 🔄 **Complete User Journey:**

### **1. Deploy Template**
```bash
# Via Akash Console
1. Upload deploy-fixed-ports.yml
2. Configure environment variables
3. Deploy to Akash
4. Wait for node to start (5-10 minutes)
```

### **2. Extract Validator Data**
```bash
# Monitor deployment logs for validator data
# Look for these sections in the logs:

# === STAKING KEYS ===
# Private Key: <staker.key content>
# Certificate: <staker.crt content>

# === NODE ID ===
# NodeID-<your_node_id>

# Copy all three pieces of data:
# 1. Node ID: NodeID-<string>
# 2. Staking Private Key: <key content>
# 3. Staking Certificate: <cert content>
```

### **3. Register Validator**
```bash
# Go to Metal dashboard
1. Enter Node ID from template
2. Set validator name
3. Set staking amount (METAL tokens)
4. Set staking duration
5. Set reward address
6. Submit validator transaction
```

### **4. Monitor Node**
```bash
# Check node status
curl http://YOUR_DEPLOYMENT_URL:9650/ext/info

# Check staking status
# Use Metal dashboard or API calls
```

---

## ⚠️ **Important Notes:**

### **Template Limitations:**
- Template only provides Node ID
- User must complete validator setup on dashboard
- User must provide their own wallet address
- User must configure all staking parameters

### **Port Requirements:**
- Ports 9650 and 9651 must be accessible
- Node won't be discovered without proper port configuration
- Nginx proxy ensures proper traffic routing

### **User Responsibilities:**
- Provide their own Metal wallet address
- Configure staking parameters on dashboard
- Monitor node uptime and performance
- Handle validator rewards and management

---

## 🎉 **Success Criteria:**

### **Template Success:**
- ✅ Node starts and syncs
- ✅ Node ID is extracted and available
- ✅ Staking keys are generated and displayed
- ✅ All validator data is accessible in logs
- ✅ Ports 9650/9651 are accessible
- ✅ User has complete validator setup data

### **User Success:**
- ✅ User gets Node ID from template
- ✅ User completes validator setup on dashboard
- ✅ Validator appears on Metal network
- ✅ User earns staking rewards

---

## 🔧 **Technical Implementation:**

### **Docker Container:**
- Uses official `metalblockchain/metalgo:latest`
- No custom Dockerfile needed
- Standard Metal node configuration

### **Port Configuration:**
- Direct port exposure in SDL
- Nginx proxy for additional routing
- Health check endpoints for monitoring

### **Storage Requirements:**
- Persistent storage for blockchain data
- Node ID storage for retrieval
- Configuration file persistence

---

## 📞 **Support:**

### **Template Issues:**
- Check port accessibility
- Verify node sync status
- Monitor deployment logs

### **Validator Setup:**
- Use Metal dashboard for configuration
- Follow Metal documentation for staking
- Contact Metal support for validator issues

---

**This template provides the infrastructure, users provide the configuration!** 🚀
