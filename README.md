# Metal Validator on Akash

Deploy a Metal blockchain validator node on Akash Network in minutes.

## 🚀 Quick Deploy

**Option 1: Akash Console (Easiest)**
1. Go to [Akash Console](https://console.akash.network/)
2. Click "Deploy" → "From Template"
3. Upload `deploy.yml` (for mainnet) or `deploy-testnet.yml` (for testnet)
4. Click "Deploy"
5. Wait 5-10 minutes for setup to complete

**Option 2: Akash CLI**
```bash
akash tx deployment create deploy.yml --from your-wallet --yes
```

> 📖 **Need more help?** Check out **[TUTORIAL.md](TUTORIAL.md)** for a complete step-by-step guide.

## 📋 What Happens Next

After deployment, check your logs. You'll see:

```
=== METAL VALIDATOR SETUP DATA ===

Node ID: NodeID-ABC123...

Public Key: 0x3059301306...

Signature: 0x3045022100...
```

**Copy all three values** and head to the Metal dashboard to complete your validator registration.

## 📁 Files

- **deploy.yml** - Mainnet deployment (Network ID: 381931)
- **deploy-testnet.yml** - Testnet deployment (Network ID: 381932)
- **TUTORIAL.md** - Complete step-by-step deployment guide

## 💰 Cost

Approximately **$60-100/month** on Akash Network

(Cheaper alternative: [Hetzner dedicated server](https://www.hetzner.com/) at €14.49/month)

## ℹ️ Requirements

- Akash wallet with AKT tokens
- Metal wallet for staking rewards
- 5-10 minutes for deployment

## 🔗 Resources

- [Metal Blockchain](https://metalblockchain.org/)
- [Akash Network](https://akash.network/)
- [Metal Validator Dashboard](https://metalblockchain.org/validators)

## 💡 Need Help?

- **Issues?** Open an issue in this repo
- **Questions?** Join [Akash Discord](https://discord.akash.network/)

---

**That's it! Deploy, copy your data, register on Metal dashboard, and start earning rewards.** 🎉

