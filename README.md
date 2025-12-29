<p align="center">
  <img src="assets/metalblockchain-logo.png" alt="Metal Blockchain Logo" width="200" />
</p>

# Deploy Metal Blockchain Validator on Akash Network

Launch a Metal blockchain validator node in minutes on Akash's decentralized cloud for a fraction of traditional VPS costs. Metal blockchain, developed by Metallicus, powers a compliant Digital Asset Banking Network connecting traditional finance with blockchain technology for regulated institutions. This deployment includes dedicated IP support for optimal peer-to-peer connectivity and validator performance.

## Requirements

Before deploying, ensure you have:

- **Akash wallet** with AKT tokens (for deployment costs)
- **Metal wallet** with 2,000+ METAL tokens (for mainnet staking)
- **Access to Akash Console** (no CLI required)
- **5-10 minutes** for deployment and bootstrap

## Cost

- **Mainnet**: Approximately $5-15/month on Akash Network
- Varies by provider and market conditions

## Quick Deploy

1. Go to [Akash Console](https://console.akash.network/)
2. Click "Deploy" → "Upload SDL"
3. Upload `deploy.yaml` from this repository
4. Deploy and wait 5-10 minutes

**GitHub Raw URL:**
```
https://raw.githubusercontent.com/VirgilBB/Metal-Validator/main/deploy.yaml
```

## Two-Step Deployment Process

The template requires a two-step deployment process:

1. **Deploy first** - Create deployment to get LoadBalancer IP assigned
2. **Get IP** - Check your deployment logs for the "Public IP" value (e.g., `Public IP: 23.121.249.57`)
   - **Option A:** If Akash Console → Deployment → "IP(s)" field shows an IP, use that
   - **Option B:** If "IP(s)" field is empty, use the IP from your logs (shown as "Public IP: X.X.X.X")
   - **Note:** The IP in logs is the actual LoadBalancer IP your node is using
3. **Update deployment** - Add environment variable in Akash Console:
   - Go to your deployment → Click "Update"
   - Find the `METAL_PUBLIC_IP` environment variable
   - Enter the IP from step 2 (just the IP, no port)
   - **Example:** If your logs show `Public IP: 23.121.249.57`, set: `METAL_PUBLIC_IP=23.121.249.57`
   - **Note:** Use just the IP address (no port). Your RPC endpoint will be `http://23.121.249.57:9650`
   - Click "Update" to save
4. **Copy validator data** - After the update completes, copy ALL THREE pieces of data from logs:
   - **Node ID** (e.g., `NodeID-ABC123...`)
   - **Proof of Possession - Public Key** (e.g., `0x3059301306...`)
   - **Proof of Possession - Signature** (e.g., `0x3045022100...`)
   - **All three are required** for validator registration on the Metal dashboard

**Why two steps?** The LoadBalancer IP is assigned AFTER deployment, so we need to update with the correct IP.

**Important:** Do not wait too long between deployments. Update the deployment promptly after getting the LoadBalancer IP.

## What You Get

After deployment, check your logs for:

```
========================================
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
Network: Metal Mainnet
RPC Endpoint: http://62.3.50.131:9650
P2P Port: 9651
```

**Access Your Node:**
- **RPC Endpoint:** `http://<your-ip>:9650` (Example: `http://203.45.67.89:9650`)
  - Use the IP from your logs (shown as "Public IP: X.X.X.X")
  - Port `9650` is for RPC/API access
- **P2P Port:** `9651` (for peer-to-peer connections, not for direct access)

## Key Features

- **Dedicated IP Support**: Uses `endpoints` with `kind: ip` for optimal P2P connectivity
- **Advanced IP Detection**: Multi-method IP detection (Kubernetes API → Environment Variables → External Services)
- **Manual IP Override**: Set `METAL_PUBLIC_IP` environment variable if auto-detection fails
- **File Descriptor Limits**: Increased to 65536 to prevent "too many open files" errors
- **Peer Monitoring**: Real-time peer count monitoring every 5 minutes
- **Bootstrap Detection**: Waits for blockchain to fully bootstrap before reporting success

## Resources

- [Metal Blockchain](https://metalblockchain.org/)
- [Metal Mainnet Explorer](https://explorer.metalblockchain.org/validators)
- [Metal Validator Dashboard](https://metalblockchain.org/validators)
- [Akash Network](https://akash.network/)
- [Akash Console](https://console.akash.network/)

## Troubleshooting

### Problem: Node shows "Not connected" in explorer
**Solution**: Complete the two-step deployment process. In Akash Console → Update deployment, set `METAL_PUBLIC_IP` to your LoadBalancer IP:
- **If "IP(s)" field shows an IP:** Use that IP
- **If "IP(s)" field is empty:** Use the IP from your logs (shown as "Public IP: X.X.X.X")
- Example: `METAL_PUBLIC_IP=23.121.249.57` (use your actual IP)

### Problem: "too many open files" errors
**Solution**: The template includes `ulimit -n 65536` to prevent this issue.

### Problem: 0 peers connected
**Solution**: Ensure you completed the two-step process and set the correct LoadBalancer IP in `METAL_PUBLIC_IP`. Example: `METAL_PUBLIC_IP=203.45.67.89` (use your actual IP from Akash Console).

### Problem: Initial Node ID changes after update
**Solution**: This is normal. Use the final Node ID, Public Key, and Signature from logs AFTER the IP update completes. All three are required for validator registration.

## Need Help?

- **Direct Support:** Email [cerebro@cerebro.host](mailto:cerebro@cerebro.host)
- **Issues?** Open an issue in this repo
- **Questions?** Join [Akash Discord](https://discord.akash.network/)
- **Metal Support?** Join [Metal Discord](https://discord.gg/metalblockchain)

---

Deploy, copy your validator data (Node ID, Public Key, and Signature), register on Metal dashboard, and start earning rewards!
