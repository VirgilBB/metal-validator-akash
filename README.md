<p align="center">
  <img src="assets/metalblockchain-logo.png" alt="Metal Blockchain Logo" width="200" />
</p>

# Deploy Metal Blockchain Validator on Akash Network

Launch a Metal blockchain validator node in minutes on Akash's decentralized cloud for a fraction of traditional VPS costs. Metal blockchain, developed by Metallicus, powers a compliant Digital Asset Banking Network connecting traditional finance with blockchain technology for regulated institutions.

## Requirements

Before deploying, ensure you have:

- Akash wallet with AKT tokens (for deployment costs)
- Metal wallet with 2,000+ METAL tokens (for mainnet staking)
- Access to Akash Console (no CLI required)
- 5-10 minutes for deployment and bootstrap

## Cost

Mainnet: Approximately $5-15/month on Akash Network (varies by provider and market conditions)

## Quick Deploy

1. Go to [Akash Console](https://console.akash.network)
2. Click "Deploy" → "Upload SDL"
3. Upload `deploy.yaml` from this repository
4. Deploy and wait 5-10 minutes

**GitHub Raw URL:**
```
https://raw.githubusercontent.com/VirgilBB/Metal-Validator/main/deploy.yaml
```

## Two-Step Deployment Process

The template requires a two-step deployment:

### Step 1: Initial Deployment
Deploy the `deploy.yaml` to trigger LoadBalancer IP assignment. Wait 1-2 minutes for the IP to appear.

### Step 2: Update with LoadBalancer IP
1. In Akash Console → Your Deployment → "IP(s)" field, copy your assigned IP
2. Click "Update" on your deployment
3. Find the `METAL_PUBLIC_IP` environment variable
4. Enter your LoadBalancer IP with port
   - Example: `METAL_PUBLIC_IP=http://203.45.67.89:9650`
5. Click "Update" to save

**Why two steps?** The LoadBalancer IP is assigned after deployment, so we update the configuration once the IP is available.

**Important:** Update promptly after getting your IP—don't wait too long between deployments.

## Registering Your Validator

After the update completes, check your deployment logs for your validator credentials:
```
========================================
METAL MAINNET VALIDATOR - SETUP DATA
========================================

⚠️  SAVE THIS DATA NOW ⚠️

Node ID
NodeID-ABC123...

Proof of Possession - Public Key
0x3059301306...

Proof of Possession - Signature
0x3045022100...

Copy all three values above to register your validator on the Metal wallet dashboard:
https://wallet.metalblockchain.org/

========================================
NETWORK STATUS
========================================

✅ Node is running
✅ Connected to 167 peers
✅ Network: Metal Mainnet

Next steps:
1. Go to Akash Console → Leases tab → Copy the IP address
   (Example format: 203.45.67.89:9650)
2. Update deployment: METAL_PUBLIC_IP=http://203.45.67.89:9650
   (Replace with your actual IP from step 1)
3. Register validator using the data above

⚠️  No IP assigned? Redeploy on a different provider.

Verify your node: https://explorer.metalblockchain.org/validators
(Search for your Node ID after registration)

========================================
```

**Copy all three pieces of data:**
- Node ID
- Proof of Possession - Public Key  
- Proof of Possession - Signature

All three are required to register your validator on the [Metal Wallet Dashboard](https://wallet.metalblockchain.org/).

**Note:** Use the final Node ID, Public Key, and Signature from logs AFTER the IP update completes.

## Backup Your Validator (Highly Recommended)

**⚠️ Highly Recommended:** Backup your validator credentials while your deployment is accessible. If your provider goes down or your deployment is lost, you can recover your validator identity instead of re-registering.

### Quick Backup (2 minutes)

1. In Akash Console → Your Deployment → **Shell** tab
2. Run this command:
```bash
   curl -s https://raw.githubusercontent.com/VirgilBB/Metal-Validator/main/metal-node-recovery/backup-node.sh | bash
```
3. **Copy and securely save** the base64 backup string that appears
4. Store it somewhere safe (encrypted password manager, secure note, etc.)

**That's it.** If you ever need to recover your validator, contact cerebro@cerebro.host with your backup string.

**Security:** Your backup contains your staking keys—keep it secure and never share it publicly.

## Key Features

- **Dedicated IP Support**: Uses endpoints with `kind: ip` for optimal P2P connectivity
- **Advanced IP Detection**: Multi-method IP detection (Kubernetes API → Environment Variables → External Services)
- **Manual IP Override**: Set `METAL_PUBLIC_IP` environment variable if auto-detection fails
- **File Descriptor Limits**: Increased to 65536 to prevent "too many open files" errors
- **Peer Monitoring**: Real-time peer count monitoring every 5 minutes
- **Bootstrap Detection**: Waits for blockchain to fully bootstrap before reporting success

## Resources

- [Metal Blockchain](https://www.metalblockchain.org/)
- [Metal Mainnet Explorer](https://explorer.metalblockchain.org/)
- [Metal Wallet Dashboard](https://wallet.metalblockchain.org/)
- [Akash Network](https://akash.network/)
- [Akash Console](https://console.akash.network/)

## Troubleshooting

**Node shows "Not connected" in explorer**  
Complete the two-step deployment process. Set `METAL_PUBLIC_IP` to your LoadBalancer IP in Akash Console → Update deployment.

**"too many open files" errors**  
The template includes `ulimit -n 65536` to prevent this issue.

**0 peers connected**  
Ensure you completed the two-step process and set the correct LoadBalancer IP in `METAL_PUBLIC_IP`.

**Initial Node ID changes after update**  
This is normal. Use the final Node ID, Public Key, and Signature from logs AFTER the IP update completes.

**No IP assigned in Leases tab**  
Redeploy on a different provider.

## Need Help?

- **Direct Support**: Email cerebro@cerebro.host
- **Issues?** Open an issue in [this repository](https://github.com/VirgilBB/Metal-Validator)
- **Questions?** Join [Akash Discord](https://discord.gg/akash)
- **Metal Support?** Join [Metal Discord](https://discord.gg/B2QDmgf)

Deploy, copy your validator data, register on Metal dashboard, and start earning rewards!
