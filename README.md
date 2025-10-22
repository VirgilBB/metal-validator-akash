# Metal Blockchain Validator on Akash Network

<img src="assets/metalblockchain-logo.png" alt="Metal Blockchain Logo" width="200" height="200">

Deploy a Metal blockchain validator node on Akash Network with dedicated IP support for optimal P2P connectivity.

## 📊 Version Table

| Component | Version | Source |
|-----------|---------|--------|
| MetalGo | v1.12.0-hotfix | [GitHub Releases](https://github.com/MetalBlockchain/metalgo/releases/tag/v1.12.0-hotfix) |
| Ubuntu | 22.04 | [Docker Hub](https://hub.docker.com/_/ubuntu) |
| Network | Testnet/Mainnet | [Metal Documentation](https://docs.metalblockchain.org/) |
| Akash SDL | 2.0 | [Akash Documentation](https://docs.akash.network/) |

## 🚀 Quick Deploy

### Option 1: Akash Console (Recommended)
1. Go to [Akash Console](https://console.akash.network/)
2. Click "Deploy" → "From Template"
3. Upload `deploy-testnet.yml` (testnet) or `deploy-mainnet.yml` (mainnet)
4. Choose a provider with `ip-lease: true` attribute
5. Deploy and wait 5-10 minutes

### Option 2: Akash CLI
```bash
# For testnet
akash tx deployment create deploy-testnet.yml --from <your-wallet> --yes

# For mainnet  
akash tx deployment create deploy-mainnet.yml --from <your-wallet> --yes
```

## 📋 What You Get

After deployment, check your logs for:

```
=== METAL TESTNET VALIDATOR SETUP DATA ===
=== METAL MAINNET VALIDATOR SETUP DATA ===

Node ID: NodeID-ABC123...
BLS Public Key: 0x3059301306...
BLS Signature: 0x3045022100...

=== NETWORK STATUS ===
Public IP: 95.217.127.48  ← Dedicated IP from provider
Connected Peers: 20+
Network: Metal Testnet (Tahoe) / Metal Mainnet
```

## 🔧 Key Features

- **Dedicated IP Support**: Uses `endpoints` with `kind: ip` for optimal P2P connectivity
- **Auto IP Detection**: Multi-fallback IP detection (api.ipify.org → ifconfig.me → icanhazip.com)
- **File Descriptor Limits**: Increased to 65536 to prevent "too many open files" errors
- **Peer Monitoring**: Real-time peer count monitoring every 5 minutes
- **Bootstrap Detection**: Waits for blockchain to fully bootstrap before reporting success

## 📁 Files

| File | Purpose |
|------|---------|
| `deploy-testnet.yml` | **Testnet deployment** (recommended for testing) |
| `deploy-mainnet.yml` | **Mainnet deployment** (production) |
| `README.md` | This documentation |
| `TUTORIAL.md` | Complete step-by-step guide |
| `assets/metalblockchain-logo.png` | Official Metal logo |

## 💰 Cost

Approximately **$2-5/month** on Akash Network (varies by provider)

## ⚙️ Requirements

- Akash wallet with AKT tokens
- Provider with `ip-lease: true` attribute (for dedicated IP)
- 5-10 minutes for deployment and bootstrap

## 🔗 Resources

- [Metal Blockchain](https://metalblockchain.org/)
- [Metal Testnet Explorer](https://tahoe.metalscan.io/)
- [Akash Network](https://akash.network/)
- [Metal Validator Dashboard](https://metalblockchain.org/validators)

## 🐛 Troubleshooting

### Problem: Node shows "Not connected" in explorer
**Solution**: Ensure you're using a provider with `ip-lease: true` attribute. Check deployment logs for dedicated IP assignment.

### Problem: "too many open files" errors
**Solution**: The template includes `ulimit -n 65536` to prevent this issue.

### Problem: 0 peers connected
**Solution**: Check that the detected public IP is from the provider's MetalLB pool, not the provider base IP.

## 💡 Need Help?

- **Issues?** Open an issue in this repo
- **Questions?** Join [Akash Discord](https://discord.akash.network/)
- **Metal Support?** Join [Metal Discord](https://discord.gg/metalblockchain)

---

**Deploy, copy your validator data, register on Metal dashboard, and start earning rewards!** 🎉