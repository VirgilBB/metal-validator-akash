# Metal Validator on Akash Network

A complete deployment template for running a Metal blockchain validator node on the Akash Network.

## 🚀 Quick Start

1. **Deploy the template** using the Akash console or CLI
2. **Wait for deployment** to complete (5-10 minutes)
3. **Copy the validator data** from the deployment logs
4. **Complete validator setup** on the Metal dashboard

## 📋 What You Get

The deployment automatically provides:
- ✅ **Node ID** - For validator registration
- ✅ **Private Key** - For staking operations
- ✅ **Certificate** - For proof of possession
- ✅ **Public Key** - Extracted from certificate
- ✅ **Signature** - For proof of possession

## 🔧 Template Features

- **Automatic MetalGo installation** - Downloads and configures MetalGo
- **Staking key generation** - Creates validator keys automatically
- **File descriptor limits** - Prevents "too many open files" errors
- **Nginx proxy** - Required for Metal node operation
- **Complete data extraction** - All validator data displayed in logs

## 📁 Files

- `templates/metal-node-operator/deploy.yml` - Main deployment template
- `templates/metal-node-operator/*.md` - Documentation and guides

## 🎯 Usage

1. Use the `deploy.yml` template in your Akash deployment
2. Monitor the deployment logs for the validator data
3. Copy the displayed data to your Metal dashboard
4. Complete the validator registration process

## 📚 Documentation

See the `templates/metal-node-operator/` directory for detailed guides:
- Complete deployment process
- User workflow
- Port configuration
- Troubleshooting

## 🔗 Links

- [Metal Blockchain](https://metalblockchain.org/)
- [Akash Network](https://akash.network/)
- [Metal Validator Setup](https://metalblockchain.org/guides/validator-setup)

## 📝 License

MIT License - see LICENSE file for details.