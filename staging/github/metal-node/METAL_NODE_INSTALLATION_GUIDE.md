# Metal Blockchain Node Installation Guide

## Official Metal Node Setup Instructions

### Hardware Requirements
- **CPU**: Equivalent of 8 AWS vCPU
- **RAM**: 16 GiB
- **Storage**: 250 GiB
- **OS**: Ubuntu 18.04/20.04 or MacOS >= Catalina
- **Network**: sustained 5Mbps up/down bandwidth

### Network Requirements
- **Port 9651**: Must be accessible from Internet (P2P network)
- **Port 9650**: RPC/HTTP API (can be local or global)
- **Static IP**: Recommended for cloud providers
- **Dynamic IP**: Requires port forwarding for home connections

---

## Installation Methods

### Method 1: Automated Install Script (Recommended)

```bash
# Download and run the installer
wget -nd -m https://raw.githubusercontent.com/MetalBlockchain/metal-docs/master/scripts/metalgo-installer.sh
chmod 755 metalgo-installer.sh
./metalgo-installer.sh
```

**Script prompts for:**
1. **Connection type**: Dynamic IP (home) or Static IP (cloud)
2. **Public IP**: Auto-detected or manual entry
3. **RPC access**: Local only or any network interface

**Post-installation:**
- Node runs as systemd service
- Configuration: `~/.metalgo/configs/node.json`
- C-Chain config: `~/.metalgo/configs/chains/C/config.json`

### Method 2: Manual Installation

**Download pre-built binary:**
```bash
# For Linux AMD64
wget https://github.com/MetalBlockchain/metalgo/releases/download/v1.1.1/metalgo-linux-amd64-v1.1.1.tar.gz
tar -xvf metalgo-linux-amd64-v1.1.1.tar.gz
```

**Run the node:**
```bash
./metalgo-<VERSION>-linux/metalgo
```

---

## Node ID Generation Process

### How Node ID is Created
1. **First run**: MetalGo generates a unique Node ID
2. **Stored in**: `~/.metalgo/` directory
3. **Retrieved via**: `sudo journalctl -u metalgo | grep "NodeID"`
4. **Format**: `NodeID-<generated_string>`

### Example Node ID Generation
```bash
# Check node logs for Node ID
sudo journalctl -u metalgo | grep "NodeID"

# Output example:
# Jan 05 10:38:38 ip-172-31-30-64 metalgo[2142]: INFO [01-05|10:38:38] metalgo/node/node.go#428: Set node's ID to 6seStrauyCnVV7NEVwRbfaT9B6EnXEzfY

# Full Node ID: NodeID-6seStrauyCnVV7NEVwRbfaT9B6EnXEzfY
```

---

## Validator Setup Process

### Step 1: Node Bootstrap
- Node must fully sync with network
- All chains (X, P, C) must be bootstrapped
- Check status: `curl -X POST --data '{"jsonrpc":"2.0","id":1,"method":"info.isBootstrapped","params":{"chain":"X"}}' -H 'content-type:application/json;' 127.0.0.1:9650/ext/info`

### Step 2: Get Node ID and Staking Keys
```bash
# Method 1: From logs (Akash deployment)
# Look for these sections in deployment logs:
# === STAKING KEYS ===
# Private Key: <staker.key content>
# Certificate: <staker.crt content>
# === NODE ID ===
# NodeID-<your_node_id>

# Method 2: From API (if accessible)
curl -X POST --data '{
    "jsonrpc":"2.0",
    "id":1,
    "method":"info.getNodeID",
    "params":{}
}' -H 'content-type:application/json;' 127.0.0.1:9650/ext/info

# Method 3: From local installation logs
sudo journalctl -u metalgo | grep "NodeID"
```

### Step 3: Validator Registration
- Use Metal dashboard: https://metalblockchain.org/validate
- Enter Node ID: `NodeID-<your_node_id>`
- **Required Data for Complete Setup:**
  - Node ID (from logs or API)
  - Staking Private Key (from `/root/.metalgo/staking/staker.key`)
  - Staking Certificate (from `/root/.metalgo/staking/staker.crt`)
- Configure staking parameters:
  - Validator name
  - Staking amount (minimum 2000 METAL)
  - Staking duration
  - Delegation fee
  - Reward address
- Submit validator transaction

---

## Key Files and Directories

### Node Data Directory: `~/.metalgo/`
- **Node ID**: Stored in database
- **Blockchain data**: Full node database
- **Configuration**: `configs/node.json`
- **Staking keys**: `staking/staker.key`, `staking/staker.crt`

### Critical Files to Backup
- **Staking keys**: `~/.metalgo/staking/staker.key`
- **Staking certificate**: `~/.metalgo/staking/staker.crt`
- **Node ID**: Can be retrieved from logs

---

## Docker Container Considerations

### Challenges for Containerized Deployment
1. **Node ID generation**: Happens on first run
2. **Persistent storage**: Node ID and blockchain data must persist
3. **Network configuration**: Ports 9650, 9651 must be exposed
4. **Service management**: No systemd in containers

### Containerized Approach
1. **Use official installer script** inside container
2. **Mount persistent volumes** for `~/.metalgo/`
3. **Expose required ports** (9650, 9651)
4. **Handle service startup** without systemd

---

## Network Configuration for Akash

### Required Ports
- **9650**: RPC/HTTP API (expose globally)
- **9651**: P2P Network (expose globally)
- **80**: HTTP proxy (expose globally)

### Environment Variables
```bash
METAL_NETWORK_ID=381931
METAL_PUBLIC_IP=AKASH_CLUSTER_PUBLIC_HOSTNAME
METAL_HTTP_HOST=0.0.0.0
METAL_HTTP_PORT=9650
METAL_P2P_PORT=9651
```

---

## Troubleshooting

### Node Not Syncing
- Check port 9651 is accessible
- Verify network connectivity
- Check firewall settings
- Monitor logs: `sudo journalctl -u metalgo -f`

### RPC Not Accessible
- Check port 9650 is open
- Verify `--http-host=` configuration
- Test with: `curl 127.0.0.1:9650/ext/info`

### Node ID Not Found
- Wait for node to fully start
- Check logs: `sudo journalctl -u metalgo | grep "NodeID"`
- Ensure node is bootstrapped

---

## Security Considerations

### RPC Access
- **Local only**: More secure, requires SSH tunnel
- **Any network**: Less secure, requires firewall
- **Recommended**: Use Nginx proxy with authentication

### Staking Keys
- **Backup**: Store `staker.key` and `staker.crt` securely
- **Location**: `~/.metalgo/staking/`
- **Recovery**: Can restore node on different machine

### Network Security
- **Firewall**: Restrict access to known IPs
- **Rate limiting**: Use Nginx for RPC protection
- **Monitoring**: Track unusual activity

---

## Next Steps for Akash Template

### Template Requirements
1. **✅ Automated installation**: Use installer script in container
2. **✅ Node ID extraction**: Parse logs for Node ID
3. **✅ Staking key extraction**: Display private key and certificate in logs
4. **✅ Persistent storage**: Mount `~/.metalgo/` directory
5. **✅ Port configuration**: Expose 9650, 9651, 80
6. **✅ Health checks**: Monitor node status and sync
7. **✅ Complete validator data**: All required information for Metal dashboard

### Implementation Strategy
1. **✅ Base image**: Ubuntu with MetalGo installer
2. **✅ Installation**: Run installer script on startup
3. **✅ Configuration**: Use environment variables with dynamic IP detection
4. **✅ Monitoring**: Parse logs for Node ID, staking keys, and status
5. **✅ Integration**: Display all validator data in logs for Metal dashboard setup
6. **✅ Complete Setup**: Template provides Node ID, private key, and certificate
