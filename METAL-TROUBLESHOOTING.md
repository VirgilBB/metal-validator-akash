# Metal Validator Troubleshooting Guide

**Last Updated:** 2025-12-20  
**Version:** v2.3

This guide covers common issues and their solutions when deploying Metal Blockchain validators on Akash Network.

---

## 🔍 Quick Diagnosis

### Step 1: Check Deployment Status

```bash
# In Akash Console, look for:
Status: active ✅                    # Pod is running
Provider: provider.example.com       # Note the provider
IP(s): X.X.X.X:9650                 # Check if IP is assigned
       X.X.X.X:9651                 # Both ports should show SAME IP
```

**Good Signs:**
- ✅ Status: active
- ✅ Same IP for both ports (e.g., 162.230.144.169)
- ✅ IP is NOT the provider's base IP

**Bad Signs:**
- ❌ Different IPs for 9650 and 9651
- ❌ No IP assigned
- ❌ IP is provider's base IP (e.g., 65.109.89.92)

---

### Step 2: Check Logs

Click "View logs" and look for these key lines:

```bash
# Good indicators:
✅ "Detected public IP: 162.230.144.169"
✅ "Bootstrap complete!"
✅ "Connected Peers: 20" (or more)
✅ "SUCCESS: Node is connected to X peer(s)"

# Bad indicators:
❌ "Could not detect public IP"
❌ "Connected Peers: 0"
❌ "WARNING: Node has 0 peers"
❌ "Connection refused"
❌ "Network: unreachable"
```

---

## 🐛 Common Issues & Solutions

### Issue #1: Node Shows "Not Connected" (RED) in Explorer

**Symptoms:**
- Deployment is active
- Logs show 0 peers
- Explorer shows RED "Not connected"
- Node has dedicated IP

**Root Cause:**
IP mismatch - node is advertising wrong IP to network

**Solution:**
Use the fixed template with explicit `--public-ip` flag (v2.3+)

```bash
# 1. Close broken deployment
# 2. Deploy fixed template (v2.3 or later)
# 3. Verify in logs:
✅ Detected public IP: X.X.X.X (from ifconfig.me)
✅ Will advertise IP: X.X.X.X
✅ Connected Peers: 20+
```

**Timeline:**
- 5-10 min: Peers should connect
- 15-30 min: Explorer updates to GREEN

---

### Issue #2: No IP Assigned (NodePort Only)

**Symptoms:**
```bash
Forwarded Ports: 9650:32664  ← Random ports
                 9651:31106
NO IP(s) section shown
```

**Root Cause:**
Provider doesn't support IP leases (MetalLB)

**Solution:**

**Option A: Redeploy with Better Provider (Recommended)**
```yaml
# Your deploy-*.yml should have:
placement:
  akash-providers:
    attributes:
      host: akash          # ✅ Required
      ip-lease: true       # ✅ Required
    pricing:
      metal-blockchain:
        amount: 3000        # ✅ Higher = better providers
```

**Option B: Use NodePort (Not Recommended)**
- Validator will work but with limitations
- Explorer may not recognize it
- Less reliable for other nodes to connect

**Recommended Providers (Known IP Lease Support):**
- provider.akash-palmito.org
- provider.hurricane.akash.pub
- provider.mainnet-1.ca.aksh.pw

---

### Issue #3: Provider Base IP Instead of Dedicated IP

**Symptoms:**
```bash
IP(s): 65.109.89.92:9650   ← Provider's base IP
       65.109.89.92:9651   ← Same for both
```

**Root Cause:**
Provider claims IP lease support but isn't configured correctly

**Solution:**
Redeploy with different provider

```bash
# 1. Note the provider name (e.g., provider.example.com)
# 2. Close deployment
# 3. Redeploy
# 4. Wait for bids
# 5. Choose a DIFFERENT provider from the list above
```

---

### Issue #4: Stuck at "Still bootstrapping..."

**Symptoms:**
```bash
Waiting for blockchain to bootstrap...
Still bootstrapping... (this can take several minutes)
Still bootstrapping... (this can take several minutes)
...
# Repeats for 15+ minutes
```

**Root Cause:**
Network connectivity issue or very slow provider

**Diagnosis:**
```bash
# Check if MetalGo is actually running:
# Look for: "Starting MetalGo node on TESTNET"

# Check if API is responding:
# Look for: "API is ready!"

# Check for errors:
# Look for: "error", "failed", "refused"
```

**Solutions:**

**If API not ready:**
- Provider is very slow
- Wait 10 more minutes
- If still stuck, close and redeploy

**If errors in logs:**
- Network issue
- Close and redeploy with different provider

**If API ready but bootstrap stuck:**
- Rare issue with MetalGo
- Close and redeploy

---

### Issue #5: "Too Many Open Files" Error

**Symptoms:**
```bash
ERROR: too many open files
ERROR: failed to open file descriptor
```

**Root Cause:**
File descriptor limit too low (should be 65536)

**Solution:**
This is already fixed in current templates (v2.0+)

```bash
# Current templates include:
ulimit -n 65536
echo "File descriptor limit set to: $(ulimit -n)"

# If you see this error, you're using an old template
# Update to latest version
```

---

### Issue #6: BLS Keys Not Extracted

**Symptoms:**
```bash
BLS Public Key: N/A
BLS Signature: N/A
```

**Root Cause:**
- Node not fully initialized
- API call failed
- Using old template

**Diagnosis:**
```bash
# Check if Node ID is present:
Node ID: NodeID-xxxxx...  ← Should have value

# If Node ID is present but BLS keys are N/A:
# API call timing issue

# If Node ID is also N/A:
# Node didn't start properly
```

**Solution:**

**If Node ID present:**
Wait 2-5 more minutes, keys should appear in periodic status updates

**If Node ID also N/A:**
```bash
# 1. Check logs for MetalGo startup
# 2. Check for errors
# 3. If no errors, wait 5 more minutes
# 4. If still N/A, close and redeploy
```

---

### Issue #7: Explorer Shows "Not Connected" But Logs Show 20+ Peers

**Symptoms:**
```bash
# Logs show:
✅ Connected Peers: 23
✅ SUCCESS: Node is connected to 23 peer(s)

# But explorer shows:
❌ RED "Not connected"
```

**Root Cause:**
Explorer indexer lag (NOT a real issue!)

**Solution:**
**DO NOTHING - This is normal!**

```bash
# Timeline:
✅ 0-10 min: Peers connect (logs show this)
⏱️  10-30 min: Explorer still updating
✅ 30-60 min: Explorer shows GREEN "Connected"

# If after 60 minutes still RED:
# Check if IP in Akash Console matches IP node is advertising
# If different, see Issue #1
```

---

### Issue #8: Connection Refused on Port 9651

**Symptoms:**
```bash
ERROR: connection refused on port 9651
ERROR: dial tcp X.X.X.X:9651: connection refused
```

**Root Cause:**
- Port not opened by provider
- MetalGo not binding to 0.0.0.0
- Firewall blocking traffic

**Diagnosis:**
```bash
# Check if MetalGo started with correct flags:
# Look for: --staking-port=9651
#          --staking-host=0.0.0.0

# Check if ports are exposed in SDL:
expose:
  - port: 9651
    as: 9651
    to:
      - global: true
        ip: metal_endpoint
```

**Solution:**
This is fixed in current templates (v2.0+)

If you see this error:
1. Verify you're using latest template
2. Check provider allows P2P traffic
3. Try different provider

---

### Issue #9: Deployment Fails Immediately

**Symptoms:**
```bash
Status: Error
Pod failed to start
```

**Common Causes:**

**A. Invalid SDL Syntax**
```bash
# Check for:
- Incorrect YAML indentation
- Missing required fields
- Invalid endpoint configuration

# Solution: Validate SDL at https://akash.network/sdl-validator
```

**B. Provider Doesn't Match Requirements**
```bash
# No providers bidding with:
attributes:
  host: akash
  ip-lease: true

# Solution: Lower pricing temporarily or wait longer
```

**C. Insufficient Balance**
```bash
# Not enough AKT in wallet

# Solution: Add funds to wallet
```

---

## 🔧 Advanced Diagnostics

### Checking MetalGo Directly

If you have shell access to the container:

```bash
# Check if MetalGo is running
ps aux | grep metalgo

# Check listening ports
netstat -tlnp | grep metalgo

# Check peer connections
curl -s -X POST -H 'Content-Type: application/json' \
  -d '{"jsonrpc":"2.0","method":"info.peers","params":{},"id":1}' \
  http://localhost:9650/ext/info | jq

# Check bootstrap status
curl -s -X POST -H 'Content-Type: application/json' \
  -d '{"jsonrpc":"2.0","method":"info.isBootstrapped","params":{"chain":"X"},"id":1}' \
  http://localhost:9650/ext/info | jq

# Check node ID
curl -s -X POST -H 'Content-Type: application/json' \
  -d '{"jsonrpc":"2.0","method":"info.getNodeID","params":{},"id":1}' \
  http://localhost:9650/ext/info | jq
```

### Checking IP Detection

```bash
# Manually check what IP is returned
curl -4 -s https://ifconfig.me
curl -4 -s https://api.ipify.org
curl -4 -s https://icanhazip.com

# Should all return the same IP
# Should match IP shown in Akash Console
```

---

## 📊 Health Checklist

Use this checklist to verify deployment health:

### Immediate (0-5 minutes)
- [ ] Deployment status: active
- [ ] Logs show: "Installing MetalGo..."
- [ ] Logs show: "Detected public IP: X.X.X.X"
- [ ] IP matches Akash Console IP
- [ ] Logs show: "Starting MetalGo..."

### Short-term (5-10 minutes)
- [ ] Logs show: "API is ready!"
- [ ] Logs show: "Bootstrap complete!"
- [ ] Logs show: "Connected Peers: X" (X > 0)
- [ ] Node ID extracted (NodeID-xxxxx)
- [ ] BLS keys extracted (0xabc...)

### Medium-term (10-30 minutes)
- [ ] Peer count stable at 20+ (testnet) or 100+ (mainnet)
- [ ] No errors in periodic status updates
- [ ] Node responds to API calls

### Long-term (30-60 minutes)
- [ ] Explorer shows GREEN "Connected"
- [ ] Uptime > 95%
- [ ] Peer count stable

---

## 🆘 Getting Help

### Before Asking for Help

Gather this information:

```bash
1. Template version: _____________ (check git commit)
2. Network: [testnet / mainnet]
3. Provider: _______________
4. Deployment status: _______________
5. IP assigned: _______________
6. Peer count: _______________
7. Logs: (paste relevant sections)
8. Error messages: (paste exact error)
```

### Where to Get Help

**1. Check Documentation First:**
- METAL-README.md - General info
- METAL-DEVELOPMENT.md - Dev guide
- METAL-PROGRESS.md - Known issues
- This file - Troubleshooting

**2. Search GitHub Issues:**
- https://github.com/VirgilBB/metal-validator-akash/issues

**3. Ask in Discord:**
- **Akash:** https://discord.gg/akash (#support)
- **Metal:** Metal Discord (#validators)

**4. Create GitHub Issue:**
Use this template:

```markdown
**Problem:** Brief description
**Template Version:** v2.3
**Network:** testnet / mainnet
**Provider:** provider.example.com
**IP Assigned:** Yes/No (if yes: X.X.X.X)
**Peer Count:** X
**Logs:**
```
(paste relevant logs)
```

**Expected Behavior:** What should happen
**Actual Behavior:** What actually happened
**Steps to Reproduce:** 1. 2. 3.
```

---

## 📝 Troubleshooting Template

Copy and fill this out when troubleshooting:

```markdown
## Deployment Information
- **Date/Time:** 2025-12-20 12:00 UTC
- **Template:** deploy-testnet.yml v2.3
- **Network:** testnet / mainnet
- **DSEQ:** _______________

## Provider Information
- **Provider:** _______________
- **IP Assigned:** Yes / No
- **IP Address:** _______________
- **Ports:** 9650:______ 9651:______

## Status
- **Deployment:** active / error / closed
- **Peer Count:** _______________
- **Bootstrap:** complete / in progress / stuck
- **Explorer:** connected / not connected / pending

## Logs (relevant sections)
```
(paste here)
```

## Errors
```
(paste here)
```

## Actions Taken
1. _______________
2. _______________
3. _______________

## Questions
1. _______________
2. _______________
```

---

## 🔄 Common Workflows

### "Start Over" Workflow

```bash
1. Close broken deployment in Akash Console
2. Verify latest template version (v2.3+)
3. Deploy fresh
4. Wait 10 minutes
5. Check logs for:
   ✅ Detected public IP
   ✅ Bootstrap complete
   ✅ Connected Peers: 20+
6. If still issues, try different provider
```

### "Change Provider" Workflow

```bash
1. Note current provider name
2. Close deployment
3. Deploy again
4. When bids appear, choose DIFFERENT provider
5. Accept bid from provider with:
   - Good reputation
   - IP lease support
   - Reasonable price
```

### "Verify Working" Workflow

```bash
1. Check Akash Console:
   ✅ Status: active
   ✅ IP assigned (same for both ports)

2. Check Logs:
   ✅ Public IP detected
   ✅ Bootstrap complete
   ✅ 20+ peers

3. Check Explorer (after 30 min):
   ✅ GREEN "Connected" status

4. Monitor for 24 hours:
   ✅ Peer count stable
   ✅ No errors
   ✅ Uptime > 95%
```

---

**Last Updated:** 2025-12-20  
**For Latest Updates:** Check METAL-PROGRESS.md  
**Report Issues:** https://github.com/VirgilBB/metal-validator-akash/issues

