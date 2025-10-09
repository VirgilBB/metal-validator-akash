# Metal Validator (.mtl) on Akash Network

A complete deployment template for running a Metal blockchain validator node on the Akash Network.

## 🚀 Quick Start

1. **Deploy the template** using the Akash console or CLI
2. **Wait for deployment** to complete (5-10 minutes)
3. **Copy the validator data** from the deployment logs
4. **Complete validator setup** on the Metal dashboard

## 📋 What You Get

The deployment automatically provides:

* ✅ **Node ID** - For validator registration (include full "NodeID-" prefix)
* ✅ **Public Key** - For proof of possession (hex format)
* ✅ **Signature** - For proof of possession (hex format)
* ✅ **Complete validator data** - Ready for Metal (.mtl) dashboard

## 🔧 Template Features

* **Automatic MetalGo installation** - Downloads and configures MetalGo v1.12.0-hotfix
* **Staking key generation** - Creates validator keys automatically
* **Clean data extraction** - Professional output with proper formatting
* **Nginx proxy** - Required for Metal node operation
* **File descriptor limits** - Prevents "too many open files" errors
* **Complete validator setup** - All required data extracted and displayed

## 📁 Files

* `deploy-testnet-cerebro.yml` - Testnet deployment template
* `deploy.yml` - Mainnet deployment template
* `TUTORIAL.md` - Step-by-step deployment guide
* `USER_JOURNEY.md` - Complete user guide
* `PROGRESS.md` - Development progress tracking
* `CHANGELOG.md` - Detailed changelog

## 🎯 Usage

### Testnet Deployment
```bash
# Deploy to Metal Tahoe Testnet
akash tx deployment create deploy-testnet-cerebro.yml --from your-wallet --yes
```

### Mainnet Deployment
```bash
# Deploy to Metal Mainnet
akash tx deployment create deploy.yml --from your-wallet --yes
```

## 📊 Expected Output

After deployment, you'll see clean validator data:

```
========================================
=== METAL TESTNET VALIDATOR SETUP DATA ===
========================================

Copy the following data to your Metal (.mtl) TESTNET dashboard:

Node ID:
NodeID-YourNodeIDHere

Proof of Possession (Public Key):
0x3059301306072a8648ce3d020106082a8648ce3d03010703420004...

Signature:
3045022100aceb51df23c56286126054f1c53b78befe78a7724881dcd6e9c67cf068d04ecd0221009c7af5e25f6206470f30054699c8dafad1702372740122392a7d631a9ba5a74b
```

## 🔧 Technical Details

### Resource Requirements
- **CPU**: 2 cores
- **Memory**: 4GB RAM
- **Storage**: 120GB
- **Network**: Ports 9650 (RPC) and 9651 (P2P)

### Network Configuration
- **Testnet**: Network ID 381932 (Metal Tahoe Testnet)
- **Mainnet**: Network ID 381931 (Metal Mainnet)
- **RPC URL**: https://tahoe.metalblockchain.org/ext/bc/C/rpc
- **Explorer**: https://tahoe.metalscan.io/

## 📚 Documentation

* **TUTORIAL.md** - Step-by-step deployment guide
* **USER_JOURNEY.md** - Complete user guide
* **PROGRESS.md** - Development progress tracking
* **CHANGELOG.md** - Detailed changelog

## 🎉 Success Criteria

### Template Success
- ✅ Node starts and syncs
- ✅ Node ID is extracted and available
- ✅ Staking keys are generated and displayed
- ✅ All validator data is accessible in logs
- ✅ Ports 9650/9651 are accessible
- ✅ User has complete validator setup data

### User Success
- ✅ User gets Node ID from template
- ✅ User completes validator setup on dashboard
- ✅ Validator appears on Metal network
- ✅ User earns staking rewards

## 🔗 Links

* [Metal Blockchain](https://metalblockchain.org/)
* [Akash Network](https://akash.network/)
* [Metal Validator Setup](https://metalblockchain.org/validators)

## 📝 License

MIT License - see LICENSE file for details.

## 🚀 Template Status: 100% COMPLETE

This template is fully functional and ready for production use. It successfully:

- ✅ Deploys MetalGo on Akash
- ✅ Connects to Metal network
- ✅ Generates staking keys
- ✅ Extracts validator data
- ✅ Provides complete setup information

**Ready to deploy and earn METAL staking rewards!** 🎉