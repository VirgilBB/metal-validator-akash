# Metal Blockchain Node - Port Configuration Guide

## 🔧 **Critical Ports for Metal Blockchain**

### **✅ Required Ports (Must Be Open)**

| Port | Protocol | Purpose | Access | Critical |
|------|----------|---------|--------|----------|
| **9650** | TCP | RPC/HTTP API | Global | ✅ **CRITICAL** |
| **9651** | TCP | P2P Network | Global | ✅ **CRITICAL** |
| **80** | TCP | HTTP Proxy | Global | ✅ **CRITICAL** |
| **443** | TCP | HTTPS Proxy | Global | Optional |

### **🚨 Why These Ports Are Critical:**

#### **Port 9650 (RPC/HTTP API)**
- **Purpose**: Node interactions, staking operations, validator registration
- **Used by**: Wallets, dApps, monitoring tools
- **Without it**: Node cannot be controlled or monitored
- **Akash exposure**: `expose: port: 9650, as: 9650, to: global: true`

#### **Port 9651 (P2P Network)**
- **Purpose**: Peer discovery, consensus participation, blockchain sync
- **Used by**: Other Metal nodes for network communication
- **Without it**: Node cannot join the network or participate in consensus
- **Akash exposure**: `expose: port: 9651, as: 9651, to: global: true`

#### **Port 80 (HTTP Proxy)**
- **Purpose**: Secure access to RPC, health checks, load balancing
- **Used by**: External access, monitoring, security
- **Without it**: No secure external access to node
- **Akash exposure**: `expose: port: 80, as: 80, to: global: true`

---

## 🔧 **Akash SDL Port Configuration**

### **✅ Correct Configuration:**
```yaml
services:
  metalgo:
    expose:
      - port: 9650
        as: 9650
        to:
          - global: true
        proto: tcp
      - port: 9651  
        as: 9651
        to:
          - global: true
        proto: tcp
```

### **❌ Common Mistakes:**
```yaml
# WRONG - Missing proto specification
expose:
  - port: 9650
    as: 9650
    to:
      - global: true

# WRONG - Not exposing P2P port
expose:
  - port: 9650
    as: 9650
    to:
      - global: true
  # Missing port 9651!

# WRONG - Using UDP instead of TCP
expose:
  - port: 9651
    as: 9651
    to:
      - global: true
    proto: udp  # Should be tcp
```

---

## 🌐 **Network Discovery Requirements**

### **For Metal Blockchain Network:**
1. **Bootstrap Nodes**: Node needs to connect to existing network
2. **Peer Discovery**: P2P port must be accessible for peer connections
3. **Consensus Participation**: Port 9651 required for validator operations
4. **RPC Access**: Port 9650 required for staking operations

### **Akash Network Considerations:**
- **Provider Firewall**: Akash providers must allow these ports
- **Load Balancer**: Akash ingress handles external access
- **Service Discovery**: Akash DNS resolution for internal communication
- **Security**: Nginx proxy provides rate limiting and access control

---

## 🔍 **Port Verification Commands**

### **Check if Ports Are Open:**
```bash
# Check RPC port (should return node info)
curl -X POST http://YOUR_NODE_URL:9650/rpc \
  -H "Content-Type: application/json" \
  -d '{"jsonrpc":"2.0","method":"info.getNodeID","params":{},"id":1}'

# Check P2P port (should be listening)
telnet YOUR_NODE_URL 9651

# Check HTTP proxy
curl http://YOUR_NODE_URL/health

# Extract validator data from logs
# Look for these sections in deployment logs:
# === STAKING KEYS ===
# Private Key: <staker.key content>
# Certificate: <staker.crt content>
# === NODE ID ===
# NodeID-<your_node_id>
```

### **Monitor Port Usage:**
```bash
# Check what's listening on ports
netstat -tlnp | grep -E "(9650|9651|80)"

# Check Metal node logs
docker logs metalgo 2>&1 | grep -E "(listening|port|P2P|RPC)"
```

---

## 🚨 **Troubleshooting Port Issues**

### **Common Problems:**

#### **"Node not syncing"**
- **Cause**: Port 9651 not accessible for P2P connections
- **Solution**: Verify P2P port is exposed and accessible
- **Check**: `telnet YOUR_NODE_URL 9651`

#### **"Cannot connect to RPC"**
- **Cause**: Port 9650 not accessible for API calls
- **Solution**: Verify RPC port is exposed and Metal node is running
- **Check**: `curl http://YOUR_NODE_URL:9650/rpc`

#### **"Validator not participating"**
- **Cause**: P2P port blocked, node cannot join consensus
- **Solution**: Ensure port 9651 is globally accessible
- **Check**: Monitor node logs for peer connection errors

#### **"External access denied"**
- **Cause**: HTTP proxy not configured or port 80 blocked
- **Solution**: Verify Nginx proxy is running and port 80 is exposed
- **Check**: `curl http://YOUR_NODE_URL/health`

---

## 🔧 **Advanced Port Configuration**

### **For High-Performance Nodes:**
```yaml
# Additional ports for monitoring
expose:
  - port: 9090  # Prometheus metrics
    as: 9090
    to:
      - global: true
  - port: 3000  # Grafana dashboard
    as: 3000
    to:
      - global: true
```

### **For Load Balancing:**
```yaml
# Multiple Metal nodes behind load balancer
services:
  metalgo-1:
    expose:
      - port: 9650
        as: 9650
  metalgo-2:
    expose:
      - port: 9650
        as: 9651
  nginx-proxy:
    expose:
      - port: 80
        as: 80
```

---

## ✅ **Port Configuration Checklist**

### **Before Deployment:**
- [ ] Port 9650 exposed for RPC access
- [ ] Port 9651 exposed for P2P network
- [ ] Port 80 exposed for HTTP proxy
- [ ] All ports use TCP protocol
- [ ] All ports accessible globally
- [ ] Nginx proxy configured correctly

### **After Deployment:**
- [ ] RPC endpoint responding (`curl http://NODE_URL:9650/rpc`)
- [ ] P2P port accessible (`telnet NODE_URL 9651`)
- [ ] HTTP proxy working (`curl http://NODE_URL/health`)
- [ ] Node syncing with network
- [ ] Node ID extracted from logs (`NodeID-<string>`)
- [ ] Staking private key displayed in logs
- [ ] Staking certificate displayed in logs
- [ ] All validator data ready for Metal dashboard
- [ ] Validator participating in consensus

### **Monitoring:**
- [ ] Port status in Grafana dashboard
- [ ] Network connectivity metrics
- [ ] Peer connection count
- [ ] RPC request success rate

---

## 🎯 **Key Success Factors**

1. **All critical ports must be exposed globally**
2. **P2P port (9651) is most critical for network participation**
3. **RPC port (9650) is required for staking operations**
4. **HTTP proxy provides secure external access**
5. **Port configuration affects validator performance**

**Remember: Without proper port configuration, your Metal node cannot participate in the network or earn staking rewards!** 🚨
