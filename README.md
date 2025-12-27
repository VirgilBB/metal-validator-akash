# Metal Blockchain Validator on Akash Network

<img src="assets/metalblockchain-logo.png" alt="Metal Blockchain Logo" width="200" height="200">

Deploy a Metal blockchain validator node on Akash Network with dedicated IP support for optimal P2P connectivity.

## Version Table

| Component | Version | Source |
|-----------|---------|--------|
| MetalGo | v1.12.0-hotfix | [GitHub Releases](https://github.com/MetalBlockchain/metalgo/releases/tag/v1.12.0-hotfix) |
| Ubuntu | 22.04 | [Docker Hub](https://hub.docker.com/_/ubuntu) |
| Network | Testnet/Mainnet | [Metal Documentation](https://docs.metalblockchain.org/) |
| Akash SDL | 2.5 | [Akash Documentation](https://docs.akash.network/) |

## Quick Deploy

### Akash Console (Recommended - No CLI Required)

1. Go to [Akash Console](https://console.akash.network/)
2. Click "Deploy" → "Upload SDL"
3. Upload `deploy-testnet.yml` (testnet) or `deploy-mainnet.yml` (mainnet)
4. Choose a provider with `ip-lease: true` attribute
5. Deploy and wait 5-10 minutes

**GitHub Raw URLs:**
- Testnet: `https://raw.githubusercontent.com/VirgilBB/metal-validator-akash/main/deploy-testnet.yml`
- Mainnet: `https://raw.githubusercontent.com/VirgilBB/metal-validator-akash/main/deploy-mainnet.yml`

## Important: Two-Step Deployment Process

The template requires a two-step deployment process:

1. **Deploy first** - Create deployment to get LoadBalancer IP assigned
2. **Get IP** - Check Akash Console → Deployment → "IP(s)" field
3. **Update YAML** - Set `METAL_PUBLIC_IP=<your-loadbalancer-ip>` in the YAML file
4. **Update deployment** - Upload updated YAML via Akash Console → Update
5. **Use final Node ID** - Copy Node ID from logs AFTER the update completes

**Why two steps?** The LoadBalancer IP is assigned AFTER deployment, so we need to update the YAML with the correct IP.

**Important:** Do not wait too long between deployments. A cache has been known to not allow updates after too much time has passed. Update the deployment promptly after getting the LoadBalancer IP.

## What You Get

After deployment, check your logs for:

```
========================================
=== METAL TESTNET VALIDATOR SETUP DATA ===
=== METAL MAINNET VALIDATOR SETUP DATA ===
========================================

Node ID
NodeID-ABC123...

Proof of Possession - Public Key
0x3059301306...

Proof of Possession - Signature
0x3045022100...

========================================
=== NETWORK STATUS ===
========================================
Public IP: 62.3.50.131
Connected Peers: 20+
Network: Metal Testnet (Tahoe) / Metal Mainnet
```

## Key Features

- **Dedicated IP Support**: Uses `endpoints` with `kind: ip` for optimal P2P connectivity
- **Advanced IP Detection**: Multi-method IP detection (Kubernetes API → Environment Variables → External Services)
- **Manual IP Override**: Set `METAL_PUBLIC_IP` environment variable if auto-detection fails
- **File Descriptor Limits**: Increased to 65536 to prevent "too many open files" errors
- **Peer Monitoring**: Real-time peer count monitoring every 5 minutes
- **Bootstrap Detection**: Waits for blockchain to fully bootstrap before reporting success

## Files

| File | Purpose |
|------|---------|
| `deploy-testnet.yml` | **Testnet deployment** (recommended for testing) |
| `deploy-mainnet.yml` | **Mainnet deployment** (production) |
| `README.md` | This documentation |
| `TUTORIAL-MAINNET.md` | Complete mainnet deployment guide |
| `TUTORIAL-TESTNET.md` | Complete testnet deployment guide |
| `docker-compose.yml` | Local testing/development setup |
| `assets/metalblockchain-logo.png` | Official Metal logo |

## Cost

- **Testnet**: Approximately $2-5/month on Akash Network
- **Mainnet**: Approximately $5-15/month on Akash Network
- Varies by provider and market conditions

## Requirements

- Akash wallet with AKT tokens
- Metal wallet with METAL tokens (1 METAL for testnet, 2,000+ METAL for mainnet)
- Provider with `ip-lease: true` attribute (for dedicated IP)
- Access to Akash Console (no CLI required)
- 5-10 minutes for deployment and bootstrap

## Resources

- [Metal Blockchain](https://metalblockchain.org/)
- [Metal Testnet Explorer](https://tahoe-explorer.metalblockchain.org/validators)
- [Metal Mainnet Explorer](https://explorer.metalblockchain.org/validators)
- [Metal Testnet Faucet](https://faucet.metalblockchain.org/)
- [Akash Network](https://akash.network/)
- [Akash Console](https://console.akash.network/)
- [Metal Validator Dashboard](https://metalblockchain.org/validators)

## Troubleshooting

### Problem: Node shows "Not connected" in explorer
**Solution**: Complete the two-step deployment process. Set `METAL_PUBLIC_IP` to your LoadBalancer IP from Akash Console and update the deployment.

### Problem: "too many open files" errors
**Solution**: The template includes `ulimit -n 65536` to prevent this issue.

### Problem: 0 peers connected
**Solution**: Ensure you completed the two-step process and set the correct LoadBalancer IP in `METAL_PUBLIC_IP`.

### Problem: Initial Node ID changes after update
**Solution**: This is normal. Use the final Node ID from logs AFTER the IP update completes.

## Need Help?

- **Issues?** Open an issue in this repo
- **Questions?** Join [Akash Discord](https://discord.akash.network/)
- **Metal Support?** Join [Metal Discord](https://discord.gg/metalblockchain)

---

Deploy, copy your validator data, register on Metal dashboard, and start earning rewards!
