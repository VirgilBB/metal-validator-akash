# Metal Validator Development Guide

**Project:** Metal Blockchain Validator on Akash Network  
**Status:** ✅ Active Development  
**Last Updated:** 2025-12-20

---

## 📁 Project Structure

```
templates/metal-node/
├── deploy-testnet.yml          # Testnet deployment template (PRIMARY)
├── deploy-mainnet.yml          # Mainnet deployment template (PRIMARY)
├── METAL-README.md             # User-facing documentation
├── METAL-CHANGELOG.md          # Version history and fixes
├── METAL-DEVELOPMENT.md        # This file - dev guide
├── METAL-PROGRESS.md           # Current status and next steps
├── METAL-TROUBLESHOOTING.md    # Common issues and solutions
├── TESTNET_GUIDE.md            # Testnet-specific guide
├── METAL_NODE_INSTALLATION_GUIDE.md  # Official Metal docs
├── IP_FIX_NAT_TRAVERSAL.md     # IP detection fix documentation
└── metal-node-instructions     # Official Metal setup instructions
```

---

## 🔧 Development Workflow

### 1. Making Changes

**Primary Files:**
- `deploy-testnet.yml` - Testnet configuration
- `deploy-mainnet.yml` - Mainnet configuration

**When you edit these files:**

```bash
# 1. Edit the template
vim /Users/vb/akash/templates/metal-node/deploy-testnet.yml

# 2. Test locally (see Testing section below)

# 3. Commit to local repo
cd /Users/vb/akash/templates/metal-node
git add deploy-testnet.yml deploy-mainnet.yml
git commit -m "🔧 FIX: Description of change"

# 4. Sync to GitHub staging repo
cd /Users/vb/akash/metal-node-staging/metal-validator-akash
cp /Users/vb/akash/templates/metal-node/deploy-testnet.yml .
cp /Users/vb/akash/templates/metal-node/deploy-mainnet.yml .
git add -A
git commit -m "🔧 FIX: Description of change"
git push origin main

# 5. Update documentation
# - Update METAL-CHANGELOG.md with changes
# - Update METAL-PROGRESS.md with status
# - Update METAL-README.md if user-facing changes
```

---

## 🧪 Testing Workflow

### Testing on Testnet (Recommended)

**1. Deploy Test Instance:**
```bash
# Via Akash Console (easiest):
# - Go to https://console.akash.network/
# - Click "Deploy" → "From File"
# - Upload: deploy-testnet.yml
# - Accept bid from provider with IP lease support
# - Wait 10 minutes
# - Check logs

# Via CLI:
akash tx deployment create deploy-testnet.yml \
  --from <your-wallet> \
  --node https://rpc.akashnet.net:443 \
  --chain-id akashnet-2 \
  --gas-prices 0.025uakt \
  --gas auto \
  --gas-adjustment 1.5
```

**2. Monitor Deployment:**
```bash
# In Akash Console:
# - Click "View logs"
# - Look for these key lines:

# ✅ "Detected public IP: X.X.X.X"
# ✅ "Bootstrap complete!"
# ✅ "Connected Peers: 20+"
# ✅ "SUCCESS: Node is connected to X peer(s)"
```

**3. Verify Success:**
- **Logs show 20+ peers** → Success! 🎉
- **Explorer shows "Connected"** (after 15-30 min) → Full success!
- **Logs show 0 peers** → Issue, check troubleshooting

**4. Check Metal Explorer:**
- Testnet: https://tahoe.metalscan.io/
- Search for Node ID (from logs)
- Status should be **GREEN "Connected"**

---

## 🐛 Debugging Failed Deployments

### Quick Debug Checklist

```bash
# 1. Check provider has IP lease support
# Look for in Akash Console:
# IP(s): 162.230.144.169:9650  ← Same IP for both ports = GOOD
#        162.230.144.169:9651

# 2. Check logs for IP detection
grep "Detected public IP" logs.txt
# Should show: ✅ Detected public IP: 162.230.144.169

# 3. Check peer count
grep "Connected Peers" logs.txt
# Should show: Connected Peers: 20+ (not 0)

# 4. Check for errors
grep -i "error" logs.txt
grep -i "failed" logs.txt
grep -i "refused" logs.txt
```

### Common Issues

| Issue | Symptom | Fix |
|-------|---------|-----|
| No IP lease | Logs show provider base IP | Redeploy with `ip-lease: true` provider |
| IP mismatch | 0 peers, different IPs | Fixed in current version (explicit --public-ip) |
| Bootstrap timeout | Stuck at "Still bootstrapping..." | Wait longer (can take 5-10 min) |
| Port not open | "Connection refused" on 9651 | Check provider firewall |

---

## 📝 Key Configuration Parameters

### MetalGo Flags

```bash
# Current working configuration:
/usr/local/bin/metalgo \
  --network-id=tahoe \              # Or "mainnet" for production
  --http-host=0.0.0.0 \             # Listen on all interfaces (RPC)
  --http-port=9650 \                # RPC port
  --staking-port=9651 \             # P2P port
  --staking-host=0.0.0.0 \          # Listen on all interfaces (P2P)
  --public-ip=$PUBLIC_IP \          # CRITICAL: Must be Akash-assigned IP
  --log-level=info                  # Can be: info, debug, trace
```

### Akash SDL Parameters

```yaml
# IP Lease Configuration (CRITICAL)
endpoints:
  metal_endpoint:
    kind: ip                        # Request dedicated IP

# Provider Filtering (CRITICAL)
placement:
  akash-providers:
    attributes:
      host: akash                   # Only certified providers
      ip-lease: true                # MUST support IP leases
    pricing:
      metal-blockchain:
        denom: uakt
        amount: 3000                # Higher = better providers

# Resource Requirements
compute:
  metal-blockchain:
    resources:
      cpu:
        units: 2.0                  # 2 cores minimum
      memory:
        size: 4Gi                   # 4GB RAM minimum
      storage:
        - size: 120Gi               # 120GB storage minimum
```

---

## 🔍 IP Detection Logic

### How It Works (Current Implementation)

```bash
# 1. Try multiple IP detection services with fallback
PUBLIC_IP=""
for service in "ifconfig.me" "api.ipify.org" "icanhazip.com"; do
  IP=$(curl -4 -s --max-time 5 https://$service 2>/dev/null || \
       curl -4 -s --max-time 5 http://$service 2>/dev/null)
  
  # 2. Validate it's a proper IPv4 address
  if [ -n "$IP" ] && [[ "$IP" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    PUBLIC_IP="$IP"
    break
  fi
done

# 3. Pass to MetalGo
if [ -n "$PUBLIC_IP" ]; then
  PUBLIC_IP_FLAG="--public-ip=$PUBLIC_IP"
else
  PUBLIC_IP_FLAG=""  # Fallback to no flag (not recommended)
fi
```

### Why This Works

1. **Akash assigns dedicated IP** from MetalLB pool (e.g., 162.230.144.169)
2. **External services return this IP** when queried from container
3. **MetalGo advertises this IP** to other nodes
4. **Other nodes connect successfully** ✅

### Why NAT Traversal Doesn't Work

- STUN/NAT traversal assumes you're behind NAT
- Akash's IP lease gives you a **direct public IP**
- STUN may detect wrong IP or fail entirely
- **Solution:** Explicitly use `--public-ip` flag ✅

---

## 📊 Performance Metrics

### Expected Bootstrap Times

| Stage | Testnet | Mainnet |
|-------|---------|---------|
| Node start | 30 sec | 30 sec |
| API ready | 1-2 min | 1-2 min |
| Bootstrap complete | 3-5 min | 5-10 min |
| Peer connections | 5-7 min | 7-12 min |
| Explorer update | 15-30 min | 30-60 min |

### Expected Peer Counts

- **Testnet (Tahoe):** 20-40 peers
- **Mainnet:** 100-200 peers (167 confirmed working)

---

## 🔄 Version Control

### Git Workflow

```bash
# Check current status
cd /Users/vb/akash/templates/metal-node
git status
git log --oneline -10

# View recent changes
git diff HEAD~1 deploy-testnet.yml

# Revert to previous version (if needed)
git log --oneline  # Find commit hash
git show <hash>:deploy-testnet.yml > deploy-testnet-old.yml
```

### Important Commits

```bash
# View key fixes
git log --grep="FIX" --oneline
git log --grep="public-ip" --oneline
git log --grep="NAT" --oneline
```

---

## 🚀 Release Checklist

### Before Releasing New Version

- [ ] **Test on testnet** - Deploy and verify 20+ peers
- [ ] **Check IP detection** - Verify correct IP in logs
- [ ] **Verify explorer status** - Wait for GREEN "Connected"
- [ ] **Test on mainnet** - Deploy and verify 100+ peers (optional)
- [ ] **Update METAL-CHANGELOG.md** - Document changes
- [ ] **Update METAL-README.md** - Update version number
- [ ] **Update METAL-PROGRESS.md** - Mark tasks complete
- [ ] **Commit to local repo** - With descriptive message
- [ ] **Push to GitHub** - Sync staging repo
- [ ] **Test GitHub deployment** - Deploy from GitHub URL
- [ ] **Update awesome-akash** - Submit PR if major update

---

## 🤝 Contributing

### For Community Contributors

1. **Fork the repo:** https://github.com/VirgilBB/metal-validator-akash
2. **Test your changes** on testnet first
3. **Document changes** in commit message
4. **Submit PR** with clear description
5. **Include test results** (screenshots welcome!)

### For Maintainers

1. **Review PR** for security issues
2. **Test on testnet** before merging
3. **Update documentation** if needed
4. **Merge and tag** if appropriate
5. **Announce** in Akash/Metal communities

---

## 📚 Useful Resources

### Akash Network
- **Console:** https://console.akash.network/
- **Docs:** https://docs.akash.network/
- **Discord:** https://discord.gg/akash
- **Provider List:** https://akash.network/providers

### Metal Blockchain
- **Docs:** https://docs.metalblockchain.org/
- **Testnet Explorer:** https://tahoe.metalscan.io/
- **Mainnet Explorer:** https://metalscan.io/
- **GitHub:** https://github.com/MetalBlockchain/metalgo

### Development Tools
- **SDL Validator:** https://akash.network/sdl-validator
- **Akash CLI:** https://docs.akash.network/cli
- **MetalGo API:** https://docs.metalblockchain.org/api

---

## 🔐 Security Notes

### Sensitive Information

**Never commit:**
- Private keys (`.key` files)
- Wallet seeds/mnemonics
- API tokens
- Provider credentials

**Safe to commit:**
- SDL templates (deploy-*.yml)
- Documentation
- Scripts (without secrets)
- Configuration examples

### Best Practices

1. **Use environment variables** for secrets
2. **Test on testnet** before mainnet
3. **Monitor deployments** regularly
4. **Backup validator keys** (staker.key, staker.crt)
5. **Keep MetalGo updated** to latest version

---

## 📞 Support

### Getting Help

1. **Check METAL-TROUBLESHOOTING.md** first
2. **Review METAL-CHANGELOG.md** for known issues
3. **Search GitHub issues**
4. **Ask in Akash Discord** (#support channel)
5. **Ask in Metal Discord** (#validators channel)

### Reporting Issues

**Template:**
```
**Problem:** Brief description
**Template:** testnet or mainnet
**Provider:** provider.example.com
**Logs:** (paste relevant logs)
**Expected:** What should happen
**Actual:** What actually happened
```

---

**Happy Deploying! 🚀**

