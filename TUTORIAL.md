# Metal Validator Deployment Tutorial

Complete step-by-step guide to deploy your Metal validator on Akash Network.

## 📋 Prerequisites

Before you begin, make sure you have:
- ✅ Akash wallet with AKT tokens (for deployment costs)
- ✅ Metal wallet (for staking and rewards)
- ✅ Akash CLI installed OR access to Akash Console

## 🚀 Deployment Options

### Option A: Akash Console (Easiest - No CLI Required)

1. **Go to Akash Console**
   - Visit: https://console.akash.network/
   - Connect your wallet (Keplr or Leap)

2. **Create Deployment**
   - Click "Deploy" button
   - Select "Upload SDL"
   - Choose `deploy.yml` (mainnet) or `deploy-testnet.yml` (testnet)

3. **Review and Accept Bid**
   - Wait for providers to bid (~30 seconds)
   - Select a provider (choose based on price and reputation)
   - Click "Accept Bid"

4. **Wait for Deployment**
   - Deployment takes 5-10 minutes
   - Click "Logs" to monitor progress

### Option B: Akash CLI

1. **Deploy**
   ```bash
   # For mainnet
   akash tx deployment create deploy.yml --from your-wallet --yes
   
   # For testnet
   akash tx deployment create deploy-testnet.yml --from your-wallet --yes
   ```

2. **Accept Bid**
   ```bash
   akash tx market lease create --dseq [DSEQ] --from your-wallet --yes
   ```

3. **Check Logs**
   ```bash
   akash provider lease-logs --dseq [DSEQ] --from your-wallet
   ```

## 📊 Monitor Your Deployment

### What to Look For

Watch your deployment logs for this section:

```
========================================
=== METAL VALIDATOR SETUP DATA ===
========================================

Copy the following data to your Metal dashboard:

Node ID:
NodeID-ABC123...

Proof of Possession (Public Key):
0x3059301306...

Signature:
0x3045022100...

========================================
=== DEPLOYMENT COMPLETE ===
========================================
```

### Copy Your Data

When you see the above output:
1. **Copy Node ID** - The full `NodeID-...` string
2. **Copy Public Key** - The `0x...` hex string
3. **Copy Signature** - The signature `0x...` hex string

## 🎯 Register Your Validator

### Step 1: Go to Metal Dashboard

**Mainnet:**
- Dashboard: https://metalblockchain.org/validators
- Explorer: https://metalscan.io/

**Testnet:**
- Dashboard: https://tahoe.metalscan.io/validators
- Faucet: https://faucet.metalblockchain.org/ (get test tokens)

### Step 2: Complete Registration Form

Fill in the following:
- **Node ID**: Paste from logs
- **Public Key**: Paste from logs  
- **Signature**: Paste from logs
- **Validator Name**: Choose a name
- **Staking Amount**: How much METAL to stake
- **Staking Duration**: How long to stake
- **Reward Address**: Where to receive rewards

### Step 3: Submit Transaction

- Review all details
- Sign the transaction with your Metal wallet
- Wait for confirmation (~5 seconds)

## ✅ Verify Your Validator

### Check Status

1. **On Metal Explorer:**
   - Go to Validators section
   - Search for your Node ID
   - Status should show "Active"

2. **Via API:**
   ```bash
   curl -X POST https://rpc.metalblockchain.org/ext/P \
     -H 'Content-Type: application/json' \
     -d '{"jsonrpc":"2.0","method":"platform.getCurrentValidators","params":{},"id":1}'
   ```

## 💰 Costs

### Akash Network
- **Estimated**: $60-100/month
- **Depends on**: Provider, resources, market conditions

### Metal Staking
- **Minimum**: Check Metal docs for current requirements
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

**Problem:** Validator showing as "Inactive"
- **Solution**:
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
1. Close existing deployment on Akash
2. Deploy new version
3. Update validator info on Metal dashboard with new Node ID

## 🔗 Useful Links

- [Metal Blockchain Docs](https://metalblockchain.org/)
- [Akash Network Docs](https://docs.akash.network/)
- [Akash Console](https://console.akash.network/)
- [Metal Discord](https://discord.gg/metalblockchain)
- [Akash Discord](https://discord.akash.network/)

## 💡 Tips

1. **Test First**: Deploy on testnet before mainnet
2. **Monitor Regularly**: Check your validator status daily
3. **Keep Backups**: Save your Node ID and wallet info securely
4. **Join Community**: Discord channels are great for support
5. **Track Costs**: Monitor your Akash spending

---

**Congratulations! You're now running a Metal validator on Akash Network!** 🎉

Questions? Open an issue in this repository or join the community Discord servers.

