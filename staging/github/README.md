# Akash Network Multi-Revenue Project

A comprehensive project for establishing multiple revenue streams on the Akash Network through validator operations, provider services, and template marketplace.

## 🎯 Project Overview

This repository contains templates and documentation for deploying blockchain infrastructure on Akash Network, with a focus on Metal blockchain validator nodes.

## 📁 Repository Structure

```
├── metal-node/                    # Metal Validator Template
│   ├── deploy.yml                 # Mainnet deployment template
│   ├── deploy-testnet-cerebro.yml # Testnet deployment template
│   ├── README.md                 # Template documentation
│   ├── TUTORIAL.MTL.md           # Step-by-step deployment guide
│   ├── QUICK_START.MTL.md        # Quick start instructions
│   └── scripts/                  # Helper scripts
│       ├── extract-node-id.sh
│       └── start-metal-node.sh
└── README.md                     # This file - project overview
```

## 🚀 Quick Start

### Metal Validator Deployment

**Testnet Deployment:**
```bash
cd metal-node/
akash tx deployment create deploy-testnet-cerebro.yml --from your-wallet --yes
```

**Mainnet Deployment:**
```bash
cd metal-node/
akash tx deployment create deploy.yml --from your-wallet --yes
```

## 📋 What You Get

- ✅ **Automatic MetalGo Installation** - Downloads and installs MetalGo v1.12.0-hotfix
- ✅ **Staking Key Generation** - Automatically creates validator staking keys
- ✅ **Clean Data Extraction** - Node ID, Public Key, and Signature ready for Metal dashboard
- ✅ **Nginx Proxy** - Network connectivity and load balancing
- ✅ **Complete Documentation** - Step-by-step guides and troubleshooting

## 🎯 Project Goals

### Prong 1: Validator Operations ✅
- **Status**: COMPLETED - Active validator earning rewards
- **Validator**: akash.usa🚀 (akashvaloper163zp6lyavlg7r2cru8djmv6d8qnpvlm0nsnr6s)
- **Commission**: 6% (updated September 25, 2025)
- **Total Stake**: ~2,484 AKT

### Prong 2: Provider Operations ✅
- **Status**: OPERATIONAL - Provider processing leases
- **Name**: cerebro.ai
- **Domain**: provider.cerebro.host
- **Provider Address**: akash1fr0pf566qtwm3xp5z7tscnl0zxmq46d7xz22gd
- **Version**: provider-services v0.8.4

### Prong 3: Template Marketplace ✅
- **Status**: COMPLETED - Metal validator template ready
- **Templates**: Metal blockchain validator deployment
- **Documentation**: Complete user guides and troubleshooting
- **Revenue**: Template royalties and deployment fees

## 🔧 Technical Details

- **Network**: Metal Mainnet (ID: 381931) / Testnet (ID: 381932)
- **Container**: Ubuntu 22.04 with MetalGo v1.12.0-hotfix
- **Resources**: 2 CPU, 4GB RAM, 120GB storage
- **Ports**: 9650 (HTTP), 9651 (P2P)

## 📚 Documentation

- **metal-node/README.md** - Template documentation
- **metal-node/TUTORIAL.MTL.md** - Complete deployment guide
- **metal-node/QUICK_START.MTL.md** - Quick start instructions

## 🔗 Links

- [Metal Blockchain](https://metalblockchain.org/)
- [Akash Network](https://akash.network/)
- [Metal Validator Setup](https://metalblockchain.org/validators)

## 📈 Revenue Projections

### Conservative Estimates (Monthly)
- **Validator**: $100-300 (dependent on delegations and AKT price)
- **Provider**: €80-150 (premium bare metal)
- **Templates**: $50-200 (royalties and deployment fees)
- **Total**: $230-650/month

## 🎉 Success Metrics

- ✅ **Validator**: BONDED & ACTIVE - Earning rewards
- ✅ **Provider**: ONLINE - Processing leases
- ✅ **Templates**: COMPLETE - Ready for deployment

---

**Ready to deploy blockchain infrastructure on Akash Network!** 🚀
