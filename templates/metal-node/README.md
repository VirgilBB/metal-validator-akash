# Metal Blockchain Node on Akash

Deploy a Metal blockchain validator node on Akash Network (Testnet or Mainnet).

---

## 🚀 Quick Start

### Choose Your Network

**Testnet (Recommended for Testing):**
```bash
akash tx deployment create deploy-testnet.yml \
  --from <your-wallet> \
  --node https://rpc.akashnet.net:443 \
  --chain-id akashnet-2 \
  --gas-prices 0.025uakt \
  --gas auto \
  --gas-adjustment 1.5
```

**Mainnet (Production):**
```bash
akash tx deployment create deploy-mainnet.yml \
  --from <your-wallet> \
  --node https://rpc.akashnet.net:443 \
  --chain-id akashnet-2 \
  --gas-prices 0.025uakt \
  --gas auto \
  --gas-adjustment 1.5
```

---

## ✅ What You Get

After 5-10 minutes, your deployment will show:

**Testnet:**
```
========================================
=== METAL TESTNET VALIDATOR SETUP DATA ===
========================================

Node ID: NodeID-xxxxx...
BLS Public Key: 0xabc123...
BLS Signature: 0xdef456...

Network: Metal Testnet (Tahoe)
Explorer: https://tahoe.metalscan.io/
```

**Mainnet:**
```
========================================
=== METAL MAINNET VALIDATOR SETUP DATA ===
========================================

Node ID: NodeID-xxxxx...
BLS Public Key: 0xabc123...
BLS Signature: 0xdef456...

Network: Metal Mainnet
Explorer: https://metalscan.io/
```

**Both Networks:**
- ✅ Dedicated IP from provider's MetalLB pool
- ✅ 20+ connected peers
- ✅ No "too many open files" errors

---

## 📊 Requirements

### Resources
- **CPU**: 2.0 cores
- **Memory**: 4 GB RAM
- **Storage**: 120 GB
- **Network**: Dedicated IP from provider (IP Lease)

### Provider Requirements
- Must support IP Leases (`ip-lease: true` attribute)
- MetalLB configured with available IP pool
- Ports 9650 (RPC) and 9651 (P2P) exposed globally

---

## 📁 Files

| File | Purpose | Status |
|------|---------|--------|
| `deploy-testnet.yml` | Testnet deployment template | ✅ **USE FOR TESTING** |
| `deploy-mainnet.yml` | Mainnet deployment template | ✅ **USE FOR PRODUCTION** |
| `README.md` | This file | 📄 Start here |
| `metal-instructions` | Generic Metal documentation | 📋 Reference only |

---

## 🔍 Verification

### Check Dedicated IP
Look in deployment logs for:
```
Detected public IP: 194.28.98.217  ← Should be from provider's MetalLB pool
```

**NOT:**
```
Detected public IP: 65.109.89.92  ← Provider base IP (wrong!)
```

### Check P2P Connectivity
```
Connected Peers: 20+  ← Should be 20 or more
```

### Check Metal Explorer
1. Go to: https://tahoe.metalscan.io/
2. Search for your Node ID
3. Status should show: **"Connected"**
   - May take 30-60 minutes for explorer to update

---

## ⚙️ Configuration

### v1.0 Features
- ✅ Multi-fallback IP detection
- ✅ IPv4 forced (`-4` flag)
- ✅ File descriptor limit: 65536
- ✅ IP Lease support for dedicated IPs
- ✅ Automatic bootstrap
- ✅ Peer monitoring every 5 minutes

### Network Details

**Testnet:**
- **Network**: Metal Tahoe Testnet
- **Network ID**: tahoe
- **RPC Port**: 9650 (HTTP)
- **P2P Port**: 9651 (TCP)
- **Explorer**: https://tahoe.metalscan.io/

**Mainnet:**
- **Network**: Metal Mainnet
- **Network ID**: 381931
- **RPC Port**: 9650 (HTTP)
- **P2P Port**: 9651 (TCP)
- **Explorer**: https://metalscan.io/

---

## 🐛 Troubleshooting

### Problem: Shows provider base IP (65.109.89.92)
**Cause**: IP Lease not working
**Fix**: Ensure provider has:
- MetalLB installed and configured
- IP pool with available IPs
- Provider attribute: `ip-lease: true`
- Provider config: `ipoperator: true`

### Problem: 0 peers connected
**Cause**: Wrong public IP advertised
**Fix**: Check deployment logs for detected IP - should be from MetalLB pool

### Problem: "too many open files" errors
**Cause**: Using old template without file limit fix
**Fix**: Use v1.0 template (has `ulimit -n 65536`)

### Problem: Explorer shows "Not connected"
**Cause**: Explorer lag (indexer delay)
**Fix**: Wait 30-60 minutes, check peer count in logs (if 20+ peers, it's working)

---

## 📚 Documentation

- `VERSION_HISTORY.md` - Complete changelog
- `WHICH_TEMPLATE_TO_USE.md` - Template comparison
- `METAL_NODE_INSTALLATION_GUIDE.md` - Official Metal docs
- `QUICK_START.MTL.md` - Fast deployment guide

---

## 🎯 Success Criteria

Your deployment is successful when:
- ✅ Pod is running (1/1 Ready)
- ✅ Dedicated IP from MetalLB pool (not provider base IP)
- ✅ 20+ peers connected
- ✅ No "too many open files" errors in logs
- ✅ Node shows in Metal explorer (may take 30-60 min)

---

## 📞 Support

**Issues?**
- Check `VERSION_HISTORY.md` for known issues
- Verify you're using `deploy-metal-testnet-v1.0.yml`
- Ensure provider supports IP Leases
- Check deployment logs for error messages

---

**Version**: v2.2
**Last Updated**: 2025-10-22
**Status**: ✅ Production Ready - MAINNET SIMPLIFIED & WORKING
**Networks**: Metal Tahoe Testnet + Metal Mainnet
**Latest Fix**: ✅ Mainnet simplified - auto-bootstrap working perfectly (167 peers)

