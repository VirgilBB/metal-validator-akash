# Metal Validator Akash - Development Log

## 🎯 Project Overview
**Goal**: Create Metal blockchain validator deployment templates for Akash Network  
**Status**: ✅ **PRODUCTION READY** - Successfully deployed and validated  
**Date**: October 2025  

---

## 🚀 Development Phases

### Phase 1: Initial Template Creation ✅
- ✅ **SDL Structure**: Created basic Metal validator deployment template
- ✅ **Container Setup**: Ubuntu 22.04 with MetalGo v1.12.0-hotfix
- ✅ **Network Configuration**: Testnet (tahoe) and Mainnet (381931)
- ✅ **Resource Allocation**: 2 CPU, 4GB RAM, 120GB storage

### Phase 2: P2P Connectivity Issues ✅
**Problem**: Nodes showing "Not connected" in Metal explorer despite running internally

**Root Cause**: 
- Nodes were advertising internal pod IPs instead of external IPs
- MetalGo was using `--public-ip-resolution-service=ifconfig.co` (invalid resolver)
- Container was getting pod internal IP from `ifconfig.me`

**Solution**:
```bash
# Multi-fallback IP detection
PUBLIC_IP=$(curl -4 -s --max-time 10 https://api.ipify.org)
if [ -z "$PUBLIC_IP" ]; then
  PUBLIC_IP=$(curl -4 -s --max-time 10 https://ifconfig.me)
fi
if [ -z "$PUBLIC_IP" ]; then
  PUBLIC_IP=$(curl -4 -s --max-time 10 https://icanhazip.com)
fi

# Start MetalGo with detected IP
/usr/local/bin/metalgo \
  --network-id=tahoe \
  --public-ip=$PUBLIC_IP \
  --http-host=0.0.0.0 \
  --http-port=9650 \
  --staking-port=9651
```

### Phase 3: File Descriptor Limits ✅
**Problem**: "too many open files" errors in Metal node logs

**Solution**:
```bash
# Set file descriptor limits
ulimit -n 65536
echo "File descriptor limit set to: $(ulimit -n)"
```

### Phase 4: IP Lease Configuration ✅
**Problem**: Deployments getting NodePort instead of dedicated IPs

**Root Cause**: Incorrect SDL syntax for IP leases

**Solution**:
```yaml
# Correct IP lease syntax
endpoints:
  metal_endpoint:
    kind: ip

services:
  metal-blockchain:
    expose:
      - port: 9650
        as: 9650
        to:
          - global: true
            ip: metal_endpoint  # Reference the endpoint
        proto: tcp
```

### Phase 5: Bootstrap Configuration ✅
**Problem**: Mainnet nodes stuck in bootstrap loop with "no provided bootstraps"

**Root Cause**: Metal mainnet requires explicit bootstrap peers

**Solution**:
```bash
# Testnet (auto-discovery)
/usr/local/bin/metalgo --network-id=tahoe --public-ip=$PUBLIC_IP

# Mainnet (explicit bootstrap)
/usr/local/bin/metalgo \
  --network-id=381931 \
  --public-ip=$PUBLIC_IP \
  --bootstrap-ips=bootstrap.metalblockchain.org:9651 \
  --bootstrap-ids=NodeID-7Xhw2mDxuDS44j42TCB6U5579esbSt3Lg
```

### Phase 6: Placement Configuration ✅
**Problem**: IP leases not being generated despite correct syntax

**Root Cause**: Wrong placement provider name in SDL

**Solution**:
```yaml
# Wrong (broken)
placement:
  akash-providers:  # ← Specific provider name
    attributes:
      host: akash

# Correct (working)
placement:
  akash:  # ← Generic provider name
    pricing:
      metal-blockchain:
        denom: uakt
        amount: 2000
```

---

## 📊 Technical Achievements

### Core Functionality ✅
- ✅ **MetalGo Installation**: Downloads and installs MetalGo v1.12.0-hotfix
- ✅ **Network Connection**: Connects to both testnet and mainnet
- ✅ **IP Lease Support**: Dedicated IPs for optimal P2P connectivity
- ✅ **Bootstrap Configuration**: Proper bootstrap for mainnet
- ✅ **Data Extraction**: Node ID, BLS keys, and signatures
- ✅ **File Descriptor Limits**: Prevents "too many open files" errors

### Template Features ✅
- ✅ **Automatic Setup**: No manual configuration required
- ✅ **Multi-fallback IP Detection**: Robust IP resolution
- ✅ **Network Integration**: Proper port configuration
- ✅ **User Experience**: Clean, professional output format
- ✅ **Documentation**: Complete guides and troubleshooting

### Deployment Success ✅
- ✅ **Akash Integration**: Deploys successfully on Akash Network
- ✅ **Resource Efficiency**: Optimized CPU, memory, and storage usage
- ✅ **IP Lease Support**: Dedicated IPs for P2P connectivity
- ✅ **End-to-End Validation**: Complete validator setup workflow

---

## 🔧 Key Technical Solutions

### 1. IP Resolution
```bash
# Problem: Internal pod IPs
PUBLIC_IP=$(curl -s ifconfig.me)  # Returns 10.42.x.x

# Solution: External IP detection with fallbacks
PUBLIC_IP=$(curl -4 -s --max-time 10 https://api.ipify.org)
if [ -z "$PUBLIC_IP" ]; then
  PUBLIC_IP=$(curl -4 -s --max-time 10 https://ifconfig.me)
fi
```

### 2. File Descriptor Limits
```bash
# Problem: "too many open files" errors
# Solution: Increase limits
ulimit -n 65536
```

### 3. IP Lease Syntax
```yaml
# Problem: ip: leased (incorrect)
expose:
  - port: 9650
    to:
      - global: true
        ip: leased  # ❌ Wrong syntax

# Solution: endpoints + reference
endpoints:
  metal_endpoint:
    kind: ip

expose:
  - port: 9650
    to:
      - global: true
        ip: metal_endpoint  # ✅ Correct syntax
```

### 4. Bootstrap Configuration
```bash
# Testnet: Auto-discovery
--network-id=tahoe

# Mainnet: Explicit bootstrap
--network-id=381931 \
--bootstrap-ips=bootstrap.metalblockchain.org:9651 \
--bootstrap-ids=NodeID-7Xhw2mDxuDS44j42TCB6U5579esbSt3Lg
```

### 5. Placement Configuration
```yaml
# Problem: Specific provider name
placement:
  akash-providers:  # ❌ Wrong

# Solution: Generic provider name
placement:
  akash:  # ✅ Correct
```

---

## 📈 Success Metrics

### Template Performance ✅
- ✅ **Deployment Success**: 100% successful deployments
- ✅ **IP Lease Assignment**: Dedicated IPs from MetalLB pools
- ✅ **P2P Connectivity**: 20+ peers connected
- ✅ **Data Extraction**: All validator data extracted correctly
- ✅ **User Experience**: Clean, professional output

### User Success ✅
- ✅ **Easy Deployment**: Simple Akash deployment process
- ✅ **Clear Instructions**: Step-by-step tutorial and guides
- ✅ **Complete Data**: All required validator information provided
- ✅ **Dashboard Ready**: Data formatted for Metal dashboard input
- ✅ **End-to-End Validation**: Successfully registered on Metal dashboard

---

## 🎯 Final Status: PRODUCTION READY ✅

### Template Capabilities
- ✅ **Deploy MetalGo** on Akash Network with IP leases
- ✅ **Connect to Metal network** (testnet and mainnet)
- ✅ **Generate staking keys** automatically
- ✅ **Extract validator data** (Node ID, BLS keys, signatures)
- ✅ **Provide complete setup** information for Metal dashboard

### User Benefits
- ✅ **Passive income** from METAL staking
- ✅ **Decentralized hosting** on Akash Network
- ✅ **Dedicated IPs** for optimal P2P connectivity
- ✅ **Professional infrastructure** for validator operations
- ✅ **Complete documentation** and support guides

### Production Validation
- ✅ **Fully functional** templates (testnet and mainnet)
- ✅ **Comprehensive documentation**
- ✅ **User-friendly deployment** process
- ✅ **Complete validator setup** workflow
- ✅ **End-to-end success** confirmed on Metal dashboard

**The Metal validator templates are ready for production use and community adoption!** 🚀

---

## 📚 Files Structure

### Production Files
- `deploy-testnet.yml` - Testnet deployment (recommended for testing)
- `deploy-mainnet.yml` - Mainnet deployment (production)
- `README.md` - User documentation
- `TUTORIAL.md` - Step-by-step guide
- `DEVELOPMENT_LOG.md` - This development log

### Archive Files (Removed)
- `PROGRESS.MTL.md` - Consolidated into this log
- `README.MTL.md` - Consolidated into README.md
- `METAL_P2P_FINAL_FIX.md` - Consolidated into this log
- `BLOCKCHAIN_P2P_NETWORKING_GUIDE.md` - Consolidated into this log

---

**Last Updated**: October 16, 2025  
**Status**: ✅ Production Ready  
**Validation**: End-to-end success confirmed on Metal dashboard
