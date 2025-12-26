# Metal Validator Deployment Tutorial - MAINNET

Complete step-by-step guide to deploy your Metal validator on Akash Network **Mainnet**.

## 📋 Prerequisites

Before you begin, make sure you have:
- ✅ Akash wallet with AKT tokens (for deployment costs)
- ✅ Metal wallet with 2,000+ METAL tokens (for staking)
- ✅ Access to Akash Console (no CLI required)

## 🚀 Deploy Your Validator

1. **Go to Akash Console**
   - Visit: https://console.akash.network/
   - Connect your wallet (Keplr or Leap)

2. **Create Deployment**
   - Click "Deploy" button
   - Select "Upload SDL"
   - Choose `deploy-mainnet.yml` from this repository
   - **GitHub Raw URL**: `https://raw.githubusercontent.com/VirgilBB/metal-validator-akash/main/deploy-mainnet.yml`

3. **Review and Accept Bid**
   - Wait for providers to bid (~30 seconds)
   - Select a provider (choose based on price and reputation)
   - Click "Accept Bid"

4. **Wait for Deployment**
   - Deployment takes 5-10 minutes
   - Click "Logs" to monitor progress

## ⚠️ IMPORTANT: Two-Step Deployment Process

**The template requires a two-step deployment process:**

1. **Deploy first** - Create deployment to get LoadBalancer IP assigned
2. **Get IP** - Check Akash Console → Deployment → "IP(s)" field (e.g., `162.230.144.169`)
3. **Update YAML** - Set `METAL_PUBLIC_IP=<your-loadbalancer-ip>` in `deploy-mainnet.yml` line 15
4. **Update deployment** - Upload updated YAML via Akash Console → Update
5. **Note:** Initial Node ID will change after update (this is normal - storage not persistent yet)
6. **Use final Node ID** - Copy Node ID from logs AFTER the update completes
7. **Wait 30-60 minutes** - Explorer will show "Connected" status

**Why two steps?** The LoadBalancer IP is assigned AFTER deployment, so we need to update the YAML with the correct IP.

**⚠️ IMPORTANT:** Do not wait too long between deployments. A cache has been known to not allow updates after too much time has passed. Update the deployment promptly after getting the LoadBalancer IP.

## 📊 Monitor Your Deployment

### What to Look For

Watch your deployment logs for this section:

```
========================================
=== METAL MAINNET VALIDATOR SETUP DATA ===
========================================

Copy the following data to your Metal MAINNET dashboard:

Node ID
NodeID-ABC123...

Proof of Possession - Public Key
0x3059301306...

Proof of Possession - Signature
0x3045022100...

========================================
=== MAINNET DEPLOYMENT COMPLETE ===
========================================
```

### Copy Your Data

When you see the above output:
1. **Copy Node ID** - The full `NodeID-...` string
2. **Copy BLS Public Key** - The `0x...` hex string
3. **Copy BLS Signature** - The signature `0x...` hex string

**⚠️ IMPORTANT:** Disregard the initial Node ID shown in the first deployment. Use the **final Node ID** from logs AFTER you update the deployment with the correct IP.

## 🎯 Register Your Validator

### Step 1: Go to Metal Dashboard

**Mainnet:**
- Dashboard: https://metalblockchain.org/validators
- Explorer: https://explorer.metalblockchain.org/validators

### Step 2: Complete Registration Form

Fill in the following:
- **Node ID**: Paste from logs (use the FINAL Node ID after IP update)
- **BLS Public Key**: Paste from logs  
- **BLS Signature**: Paste from logs
- **Validator Name**: Choose a name
- **Staking Amount**: How much METAL to stake (minimum 2,000 METAL)
- **Staking Duration**: How long to stake
- **Reward Address**: Where to receive rewards

### Step 3: Submit Transaction

- Review all details
- Sign the transaction with your Metal wallet
- Wait for confirmation (~5 seconds)

## ✅ Verify Your Validator

### Check Status

1. **On Metal Explorer:**
   - Go to: https://explorer.metalblockchain.org/validators
   - Search for your Node ID
   - Status should show "Connected" (may take 30-60 minutes after IP update)

2. **Via API:**
   ```bash
   curl -X POST https://rpc.metalblockchain.org/ext/P \
     -H 'Content-Type: application/json' \
     -d '{"jsonrpc":"2.0","method":"platform.getCurrentValidators","params":{},"id":1}'
   ```

## 💰 Costs

### Akash Network
- **Estimated**: $5-15/month
- **Depends on**: Provider, resources, market conditions

### Metal Staking
- **Minimum**: 2,000 METAL tokens
- **Lock period**: Your chosen duration
- **Rewards**: Based on network inflation and your stake

## 🔧 Troubleshooting

### Deployment Issues

**Problem:** Deployment not accepting bids
- **Solution**: Increase pricing in SDL or try different providers

**Problem:** Can't see logs
- **Solution**: Wait 2-3 minutes after deployment starts

**Problem:** Node ID shows "not-found"
- **Solution**: Wait longer (API needs ~30 seconds to initialize)

### Validator Issues

**Problem:** Validator not appearing on explorer
- **Solution**: 
  - Wait 5 minutes after registration
  - Verify Node ID matches exactly (including "NodeID-" prefix)
  - Check you have enough METAL staked
  - **Make sure you used the FINAL Node ID after IP update**

**Problem:** Validator showing as "Not Connected"
- **Solution**:
  - Ensure you completed the two-step process (IP update)
  - Check that `METAL_PUBLIC_IP` is set to your LoadBalancer IP
  - Wait 30-60 minutes for explorer to update
  - Ensure your Akash deployment is still running
  - Check that ports 9650 and 9651 are accessible
  - Verify your node is synced (check logs)

## 📱 Management

### Keep Your Deployment Running

Your validator must run continuously:
- Monitor your Akash deployment
- Ensure sufficient AKT balance for ongoing costs
- Check validator status regularly on Metal explorer

### Update Your Deployment

If you need to update:
1. Update environment variables in Akash Console (mutable - preserves Node ID)
2. Or close existing deployment and deploy new version
3. If redeploying, update validator info on Metal dashboard with new Node ID

## 🔗 Useful Links

- [Metal Blockchain Docs](https://metalblockchain.org/)
- [Akash Network Docs](https://docs.akash.network/)
- [Akash Console](https://console.akash.network/)
- [Metal Explorer - Mainnet](https://explorer.metalblockchain.org/validators)
- [Metal Discord](https://discord.gg/metalblockchain)
- [Akash Discord](https://discord.akash.network/)

## 💡 Tips

1. **Monitor Regularly**: Check your validator status daily
2. **Keep Backups**: Save your Node ID and wallet info securely
3. **Join Community**: Discord channels are great for support
4. **Track Costs**: Monitor your Akash spending
5. **Use Final Node ID**: Always use the Node ID from logs AFTER the IP update

---

**Congratulations! You're now running a Metal validator on Akash Network Mainnet!** 🎉

Questions? Open an issue in this repository or join the community Discord servers.

