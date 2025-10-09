# Metal Blockchain Node Operator - Akash Template

## 🎯 **Two Template Options:**

### **1. `deploy.yml` - Core Template (Recommended)**
- **Purpose**: Deploy Metal node + Nginx proxy
- **Use case**: Most users, simple setup
- **Services**: MetalGo node + Nginx proxy
- **Cost**: Lower (2,500 uakt per block)

### **2. `deploy-with-monitoring.yml` - Full Monitoring**
- **Purpose**: Deploy Metal node + monitoring stack
- **Use case**: Advanced users, full monitoring
- **Services**: MetalGo + Prometheus + Grafana + Nginx
- **Cost**: Higher (4,000 uakt per block)

---

## 🚀 **Quick Start:**

### **Step 1: Choose Template**
- **Beginners**: Use `deploy.yml`
- **Advanced**: Use `deploy-with-monitoring.yml`

### **Step 2: Deploy via Akash Console**
1. Upload chosen template
2. Configure environment variables (optional)
3. Deploy to Akash
4. Wait for node to start (5-10 minutes)

### **Step 3: Get Node ID**
- Access your deployment URL
- Node ID will be available via logs or API
- Copy Node ID (format: `NodeID-<string>`)

### **Step 4: Complete on Metal Dashboard**
1. Go to Metal dashboard
2. Enter Node ID from template
3. Set validator name, staking amount, duration
4. Submit validator registration

---

## ⚙️ **Template Configuration:**

### **Environment Variables (Optional):**
```yaml
METAL_BOOTSTRAP_IPS=    # Bootstrap node IPs
METAL_BOOTSTRAP_IDS=    # Bootstrap node IDs
GRAFANA_PASSWORD=       # Grafana password (monitoring template only)
```

### **Required Ports:**
- **9650**: RPC/HTTP API (must be accessible)
- **9651**: P2P Network (must be accessible)
- **80/443**: HTTP/HTTPS proxy
- **3000**: Grafana (monitoring template only)
- **9090**: Prometheus (monitoring template only)

---

## 📋 **User Workflow:**

### **Template DOES:**
- ✅ Deploy Metal node on Akash
- ✅ Extract Node ID automatically
- ✅ Handle port configuration
- ✅ Provide monitoring (if using monitoring template)

### **Template DOESN'T:**
- ❌ Set validator name (user does this on dashboard)
- ❌ Configure staking amounts (user does this on dashboard)
- ❌ Set staking dates (user does this on dashboard)
- ❌ Handle wallet addresses (user provides their own)

### **User Responsibilities:**
1. **Deploy template** → Get Node ID
2. **Go to Metal dashboard** → Complete validator setup
3. **Configure staking** → Set amounts, dates, wallet, name
4. **Submit validator** → Start earning rewards

---

## 🔧 **Technical Details:**

### **Core Template (`deploy.yml`):**
- **Services**: MetalGo + Nginx
- **Resources**: 2 CPU, 4GB RAM, 100GB storage
- **Cost**: ~2,500 uakt per block
- **Use case**: Basic Metal node operation

### **Monitoring Template (`deploy-with-monitoring.yml`):**
- **Services**: MetalGo + Prometheus + Grafana + Nginx
- **Resources**: 3.5 CPU, 7GB RAM, 160GB storage
- **Cost**: ~4,000 uakt per block
- **Use case**: Full monitoring and analytics

---

## 🎉 **Success Criteria:**

### **Template Success:**
- ✅ Node starts and syncs
- ✅ Ports 9650/9651 are accessible
- ✅ Node ID is available
- ✅ User can access services

### **User Success:**
- ✅ User gets Node ID from template
- ✅ User completes validator setup on dashboard
- ✅ Validator appears on Metal network
- ✅ User earns staking rewards

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

**Choose your template and start earning Metal staking rewards!** 🚀