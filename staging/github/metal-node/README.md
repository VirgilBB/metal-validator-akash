# Metal Validator Node for Akash Network

A complete deployment template for running Metal blockchain validator nodes on Akash Network.

## 🚀 Quick Start

### Prerequisites
- Akash CLI installed and configured
- Wallet with sufficient AKT for deployment

### Deployment

**Testnet Deployment:**
```bash
akash tx deployment create deploy-testnet-cerebro.yml --from your-wallet --yes
```

**Mainnet Deployment:**
```bash
akash tx deployment create deploy.yml --from your-wallet --yes
```

## 📋 What You Get

- ✅ **Automatic MetalGo Installation** - Downloads and installs MetalGo v1.12.0-hotfix
- ✅ **Staking Key Generation** - Automatically creates validator staking keys
- ✅ **Clean Data Extraction** - Node ID, Public Key, and Signature ready for Metal dashboard
- ✅ **Nginx Proxy** - Network connectivity and load balancing
- ✅ **Complete Documentation** - Step-by-step guides and troubleshooting

## 📁 Files

- `deploy.yml` - Mainnet deployment template
- `deploy-testnet-cerebro.yml` - Testnet deployment template
- `TUTORIAL.MTL.md` - Step-by-step deployment guide
- `QUICK_START.MTL.md` - Quick start instructions
- `scripts/` - Helper scripts for deployment

## 🎯 Expected Output

After deployment, you'll see:
```
=== METAL VALIDATOR SETUP DATA ===
Node ID: NodeID-XXXXXXXXXXXX
Proof of Possession (Public Key): 0xXXXXXXXXXXXX
Signature: XXXXXXXXXXXX
```

## 📚 Documentation

- **TUTORIAL.MTL.md** - Complete deployment guide
- **QUICK_START.MTL.md** - Quick start instructions
- **README.MTL.md** - Detailed template information

## 🔧 Technical Details

- **Network**: Metal Mainnet (ID: 381931) / Testnet (ID: 381932)
- **Container**: Ubuntu 22.04 with MetalGo v1.12.0-hotfix
- **Resources**: 1 CPU, 1GB RAM, 10GB storage
- **Ports**: 9650 (HTTP), 9651 (P2P)

## 🎉 Success Criteria

- ✅ MetalGo node running successfully
- ✅ Staking keys generated automatically
- ✅ Clean validator data extraction
- ✅ Ready for Metal dashboard registration

---

**Ready to deploy your Metal validator on Akash Network!** 🚀
