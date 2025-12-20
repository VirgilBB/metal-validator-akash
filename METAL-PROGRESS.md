# Metal Validator Project - Progress Tracker

**Project:** Metal Blockchain Validator on Akash Network  
**Status:** 🟡 **FIXING IP CONNECTIVITY**  
**Last Updated:** 2025-12-20  
**Current Version:** v2.3-dev

---

## 🎯 Current Status

### ✅ What's Working

- [x] **MetalGo Installation** - Downloads and installs correctly
- [x] **Node Startup** - Starts without errors
- [x] **API Endpoints** - RPC (9650) and P2P (9651) exposed
- [x] **BLS Key Extraction** - nodePOP fields extracted correctly
- [x] **Node ID Generation** - Unique node IDs created
- [x] **Bootstrap Process** - X-Chain bootstraps successfully
- [x] **File Descriptor Limits** - Set to 65536 (prevents "too many open files")
- [x] **IP Lease Support** - Dedicated IPs from MetalLB pool
- [x] **Provider Filtering** - Only selects providers with `ip-lease: true`
- [x] **Mainnet Simplified** - Auto-bootstrap working (167 peers confirmed)
- [x] **Community Friendly** - Removed `signedBy` restriction

### 🟡 Currently Fixing

- [ ] **Testnet P2P Connectivity** - Last 3 validators showing RED status
  - **Issue:** Nodes not connecting to peers (0 peers)
  - **Root Cause:** NAT traversal doesn't work with Akash IP leases
  - **Fix Applied:** Restored explicit `--public-ip` flag with fallback detection
  - **Status:** Fix committed and pushed, awaiting retest
  - **Next:** Close broken deployment, deploy fixed template

### ❌ Known Issues

1. **Explorer Lag** - Can take 30-60 minutes to show "Connected" status
   - Not a real issue - if node has 20+ peers, it's working
   - Explorer indexer just needs time to update

---

## 📋 Completed Milestones

### [2025-12-20] IP Detection Fix (v2.3)
- ✅ Identified NAT traversal incompatibility with Akash IP leases
- ✅ Restored explicit `--public-ip` flag with multi-service fallback
- ✅ Updated both testnet and mainnet templates
- ✅ Synced all template locations (local + GitHub)
- ✅ Created comprehensive development documentation
- 🟡 Awaiting deployment test

### [2025-10-22] Mainnet Breakthrough (v2.2)
- ✅ Simplified mainnet config to match testnet
- ✅ Changed `--network-id=381931` to `--network-id=mainnet`
- ✅ Removed hardcoded bootstrap nodes (let MetalGo auto-configure)
- ✅ Achieved 167 peers on multiple mainnet deployments
- ✅ Works even without dedicated IP (though IP lease preferred)

### [2025-10-17] Provider IP Lease Support (v2.1)
- ✅ Added `ip-lease: true` attribute to provider filtering
- ✅ Added `host: akash` requirement
- ✅ Increased pricing to 3000 uakt for capable providers
- ✅ Fixed SDL syntax error (moved `ip` field inside `to` array)

### [2025-10-10] BLS Key Extraction Breakthrough (v2.0)
- ✅ Fixed BLS key extraction using `nodePOP.publicKey`
- ✅ Fixed BLS signature using `nodePOP.proofOfPossession`
- ✅ Successfully validated on Metal Tahoe testnet dashboard
- ✅ Production deployment confirmed working

### [2025-10-09] Initial Template Creation (v1.0)
- ✅ Created base Metal validator deployment template
- ✅ Implemented MetalGo v1.12.0-hotfix installation
- ✅ Configured network connectivity for testnet
- ✅ Automated staking key generation
- ✅ Implemented Node ID extraction

---

## 🎯 Next Steps (Priority Order)

### Immediate (Today)

1. **Test IP Detection Fix**
   - [ ] Close broken testnet deployment (DSEQ: 24717410)
   - [ ] Deploy fixed template from GitHub
   - [ ] Verify IP detection in logs: `✅ Detected public IP: X.X.X.X`
   - [ ] Confirm 20+ peers connected
   - [ ] Wait for explorer to show GREEN status

2. **Document Results**
   - [ ] Update METAL-CHANGELOG.md with fix results
   - [ ] Update METAL-README.md version number
   - [ ] Create METAL-TROUBLESHOOTING.md if not exists

### Short Term (This Week)

3. **Stability Testing**
   - [ ] Deploy testnet validator for 24+ hours
   - [ ] Monitor peer count stability
   - [ ] Verify uptime percentage
   - [ ] Check for any errors/warnings in logs

4. **Mainnet Validation**
   - [ ] Deploy mainnet validator with fixed template
   - [ ] Verify 100+ peers connected
   - [ ] Monitor for 24+ hours
   - [ ] Compare with testnet performance

5. **Documentation Completion**
   - [x] Create METAL-DEVELOPMENT.md
   - [x] Create METAL-PROGRESS.md (this file)
   - [ ] Create METAL-TROUBLESHOOTING.md
   - [ ] Update all documentation with v2.3 changes
   - [ ] Create deployment video/guide

### Medium Term (This Month)

6. **Community Release**
   - [ ] Create detailed quick-start guide
   - [ ] Make YouTube deployment tutorial
   - [ ] Submit to awesome-akash repository
   - [ ] Announce in Akash Discord
   - [ ] Announce in Metal Discord
   - [ ] Create Twitter thread

7. **Feature Enhancements**
   - [ ] Add monitoring/metrics endpoint
   - [ ] Add automatic update script
   - [ ] Add health check notifications
   - [ ] Add multi-region deployment support

8. **Testing & Validation**
   - [ ] Test on 3+ different Akash providers
   - [ ] Validate on both testnet and mainnet
   - [ ] Get community feedback
   - [ ] Fix any reported issues

---

## 📊 Success Metrics

### Current Performance

| Metric | Target | Testnet | Mainnet | Status |
|--------|--------|---------|---------|--------|
| Bootstrap Time | < 10 min | ~5 min | ~7 min | ✅ |
| Peer Count | 20+ (testnet), 100+ (mainnet) | 0 (broken) | 167 | 🟡/✅ |
| Uptime | > 95% | TBD | TBD | 🟡 |
| Explorer Status | "Connected" | RED | TBD | 🟡 |
| IP Lease Success | 100% | 100% | 100% | ✅ |
| Community Deployments | 10+ | 0 | 0 | ❌ |

### Key Performance Indicators (KPIs)

- **Deployment Success Rate:** 🎯 Target: 95%+
  - Current: 50% (IP issue affecting testnet)
  
- **Time to First Peer:** 🎯 Target: < 5 minutes
  - Current: 5-7 minutes ✅
  
- **Average Peer Count:** 🎯 Target: 20+ (testnet), 150+ (mainnet)
  - Testnet: 0 (broken) 🟡
  - Mainnet: 167 ✅
  
- **Explorer Recognition Time:** 🎯 Target: < 30 minutes
  - Current: 15-30 minutes ✅

---

## 🐛 Issue Tracking

### Critical Issues (P0)

#### Issue #1: Testnet Validators Not Connecting
- **Severity:** 🔴 CRITICAL
- **Status:** 🔧 FIX IN PROGRESS
- **Affected:** Testnet deployments
- **Impact:** Validators show RED status, 0 peers
- **Root Cause:** NAT traversal doesn't work with Akash IP leases
- **Fix:** Restore explicit `--public-ip` flag
- **Committed:** 2025-12-20
- **Testing:** Pending redeployment
- **ETA:** Today

### High Priority Issues (P1)

- None currently identified

### Medium Priority Issues (P2)

#### Issue #2: Explorer Update Lag
- **Severity:** 🟡 MEDIUM
- **Status:** ✅ DOCUMENTED
- **Affected:** All deployments
- **Impact:** Takes 30-60 min for explorer to show "Connected"
- **Workaround:** Check peer count in logs (not explorer)
- **Notes:** Not a real issue - explorer indexer is just slow

### Low Priority Issues (P3)

- None currently identified

---

## 🔄 Change History

### v2.3-dev (2025-12-20) - IP Detection Fix
```
Changes:
- Restored explicit --public-ip flag with fallback detection
- Added multi-service IP detection (ifconfig.me, ipify, icanhazip)
- Updated both testnet and mainnet templates
- Created METAL-DEVELOPMENT.md and METAL-PROGRESS.md

Files Changed:
- deploy-testnet.yml
- deploy-mainnet.yml
- METAL-DEVELOPMENT.md (new)
- METAL-PROGRESS.md (new)

Commits:
- 0b91352 🔧 FIX: Restore explicit --public-ip flag with fallback detection
- 137263f 🔧 FIX: Restore explicit --public-ip flag (fixes red validators)
```

### v2.2 (2025-10-22) - Mainnet Simplified
```
Changes:
- Simplified mainnet to use --network-id=mainnet
- Removed hardcoded bootstrap nodes
- Achieved 167 peers on mainnet

Files Changed:
- deploy-mainnet.yml
- METAL-CHANGELOG.md

Result: ✅ SUCCESS - Mainnet working perfectly
```

### v2.1 (2025-10-17) - IP Lease Support
```
Changes:
- Added ip-lease: true provider filtering
- Fixed SDL syntax for IP endpoints
- Removed signedBy restriction

Files Changed:
- deploy-testnet.yml
- deploy-mainnet.yml

Result: ✅ Improved provider selection
```

### v2.0 (2025-10-10) - BLS Key Fix
```
Changes:
- Fixed BLS key extraction using nodePOP fields
- Validated on Metal dashboard

Files Changed:
- deploy-testnet.yml
- deploy-mainnet.yml

Result: ✅ SUCCESS - Keys working correctly
```

---

## 📈 Roadmap

### Q4 2025
- [x] Create functional testnet template
- [x] Create functional mainnet template
- [x] Fix BLS key extraction
- [x] Add IP lease support
- [ ] Achieve stable testnet deployment
- [ ] Community beta release

### Q1 2026
- [ ] 10+ community deployments
- [ ] Add monitoring features
- [ ] Create video tutorials
- [ ] Submit to awesome-akash
- [ ] Official Metal documentation

### Q2 2026
- [ ] Auto-update functionality
- [ ] Multi-region support
- [ ] Performance optimizations
- [ ] 100+ community deployments

---

## 🤝 Contributors

### Core Team
- **VirgilBB** - Template development, testing, documentation

### Community Contributors
- (Open for contributions!)

### Special Thanks
- Akash Network community
- Metal Blockchain team
- Akash provider operators

---

## 📞 Contact & Support

### Report Issues
- **GitHub:** https://github.com/VirgilBB/metal-validator-akash/issues
- **Akash Discord:** #support channel
- **Metal Discord:** #validators channel

### Get Help
1. Check METAL-TROUBLESHOOTING.md
2. Review METAL-CHANGELOG.md
3. Search GitHub issues
4. Ask in Discord

---

## 📝 Notes for Future Development

### Lessons Learned

1. **NAT Traversal vs Direct IP**
   - NAT traversal (STUN) doesn't work well with Akash IP leases
   - Explicit `--public-ip` flag is more reliable
   - Always validate IP detection in logs

2. **Provider Selection**
   - Not all providers support IP leases
   - `ip-lease: true` attribute is CRITICAL
   - Higher pricing (3000 uakt) attracts better providers

3. **Bootstrap Configuration**
   - Hardcoded bootstrap nodes can become stale
   - Let MetalGo auto-configure when possible
   - Use `--network-id=mainnet` instead of numeric IDs

4. **Testing Strategy**
   - Always test on testnet first
   - Wait for 20+ peers before declaring success
   - Explorer lag is normal (30-60 min)
   - Check logs, not explorer, for immediate status

### Future Improvements

- [ ] Add automated health checks
- [ ] Implement log aggregation
- [ ] Add Prometheus metrics
- [ ] Create deployment CI/CD
- [ ] Add automated testing
- [ ] Implement blue/green deployments

---

**Status:** 🟡 Active Development - IP Fix Testing in Progress  
**Next Review:** After successful testnet deployment  
**Target Stable Release:** Q4 2025

