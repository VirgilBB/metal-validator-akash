#!/bin/bash

# Metal Blockchain Node - Port Verification Script
# Verifies all critical ports are properly configured and accessible

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🔍 Metal Blockchain Node - Port Verification${NC}"
echo "=============================================="
echo ""

# Function to check if port is accessible
check_port() {
    local host=$1
    local port=$2
    local name=$3
    local critical=$4
    
    echo -n "Checking $name (port $port)... "
    
    if timeout 5 bash -c "</dev/tcp/$host/$port" 2>/dev/null; then
        echo -e "${GREEN}✅ OPEN${NC}"
        return 0
    else
        if [ "$critical" = "true" ]; then
            echo -e "${RED}❌ CLOSED (CRITICAL)${NC}"
            return 1
        else
            echo -e "${YELLOW}⚠️  CLOSED (Optional)${NC}"
            return 0
        fi
    fi
}

# Function to test RPC endpoint
test_rpc() {
    local host=$1
    local port=$2
    
    echo -n "Testing RPC endpoint... "
    
    local response=$(curl -s -X POST "http://$host:$port/rpc" \
        -H "Content-Type: application/json" \
        -d '{"jsonrpc":"2.0","method":"info.getNodeID","params":{},"id":1}' \
        --connect-timeout 5 2>/dev/null)
    
    if echo "$response" | grep -q "result"; then
        echo -e "${GREEN}✅ RPC WORKING${NC}"
        return 0
    else
        echo -e "${RED}❌ RPC FAILED${NC}"
        return 1
    fi
}

# Function to test HTTP proxy
test_proxy() {
    local host=$1
    
    echo -n "Testing HTTP proxy... "
    
    local response=$(curl -s "http://$host/health" --connect-timeout 5 2>/dev/null)
    
    if echo "$response" | grep -q "healthy"; then
        echo -e "${GREEN}✅ PROXY WORKING${NC}"
        return 0
    else
        echo -e "${RED}❌ PROXY FAILED${NC}"
        return 1
    fi
}

# Get deployment URL from user or environment
if [ -z "$NODE_URL" ]; then
    read -p "🌐 Enter your Metal node URL (e.g., https://abc123.akash.network): " NODE_URL
fi

# Extract hostname from URL
HOST=$(echo "$NODE_URL" | sed 's|https\?://||' | sed 's|/.*||')

echo -e "${BLUE}🔍 Verifying ports for: $HOST${NC}"
echo ""

# Check critical ports
echo -e "${YELLOW}📋 Critical Ports (Must be open):${NC}"
check_port "$HOST" 9650 "RPC/HTTP API" true
check_port "$HOST" 9651 "P2P Network" true
check_port "$HOST" 80 "HTTP Proxy" true

echo ""
echo -e "${YELLOW}📋 Optional Ports:${NC}"
check_port "$HOST" 443 "HTTPS Proxy" false

echo ""
echo -e "${YELLOW}📋 Service Tests:${NC}"

# Test RPC functionality
test_rpc "$HOST" 9650

# Test HTTP proxy
test_proxy "$HOST"

echo ""
echo -e "${BLUE}📊 Port Configuration Summary:${NC}"

# Check if all critical ports are open
CRITICAL_PORTS_OK=true

if ! check_port "$HOST" 9650 "RPC" true >/dev/null 2>&1; then
    CRITICAL_PORTS_OK=false
fi

if ! check_port "$HOST" 9651 "P2P" true >/dev/null 2>&1; then
    CRITICAL_PORTS_OK=false
fi

if ! check_port "$HOST" 80 "HTTP" true >/dev/null 2>&1; then
    CRITICAL_PORTS_OK=false
fi

if [ "$CRITICAL_PORTS_OK" = true ]; then
    echo -e "${GREEN}✅ All critical ports are accessible${NC}"
    echo -e "${GREEN}🎉 Your Metal node should be able to participate in the network!${NC}"
else
    echo -e "${RED}❌ Some critical ports are not accessible${NC}"
    echo -e "${RED}🚨 Your Metal node may not be able to join the network or earn staking rewards${NC}"
    echo ""
    echo -e "${YELLOW}🔧 Troubleshooting steps:${NC}"
    echo "1. Check your Akash deployment status"
    echo "2. Verify the SDL configuration includes all required ports"
    echo "3. Ensure the Metal node container is running"
    echo "4. Check the deployment logs for errors"
    echo ""
    echo -e "${BLUE}📋 Required SDL configuration:${NC}"
    echo "```yaml"
    echo "expose:"
    echo "  - port: 9650"
    echo "    as: 9650"
    echo "    to:"
    echo "      - global: true"
    echo "    proto: tcp"
    echo "  - port: 9651"
    echo "    as: 9651"
    echo "    to:"
    echo "      - global: true"
    echo "    proto: tcp"
    echo "  - port: 80"
    echo "    as: 80"
    echo "    to:"
    echo "      - global: true"
    echo "    proto: tcp"
    echo "```"
fi

echo ""
echo -e "${BLUE}💡 Next steps:${NC}"
echo "1. If all ports are open, your node should start syncing"
echo "2. Monitor the node logs for sync progress"
echo "3. Check validator status once synced"
echo "4. Verify staking rewards are accumulating"
