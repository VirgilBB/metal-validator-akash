#!/bin/bash

# Start MetalGo node
echo "🚀 Starting MetalGo node..."

# Set environment variables
export METAL_NETWORK_ID=${METAL_NETWORK_ID:-381931}
export METAL_PUBLIC_IP=${METAL_PUBLIC_IP:-$(curl -s ifconfig.me)}
export METAL_HTTP_HOST=${METAL_HTTP_HOST:-0.0.0.0}
export METAL_HTTP_PORT=${METAL_HTTP_PORT:-9650}
export METAL_P2P_PORT=${METAL_P2P_PORT:-9651}
export METAL_STAKING_ENABLED=${METAL_STAKING_ENABLED:-true}

# Create data directory
mkdir -p /home/metalgo/.metalgo

# Start MetalGo
exec metalgo \
    --network-id=$METAL_NETWORK_ID \
    --public-ip=$METAL_PUBLIC_IP \
    --http-host=$METAL_HTTP_HOST \
    --http-port=$METAL_HTTP_PORT \
    --p2p-port=$METAL_P2P_PORT \
    --staking-enabled=$METAL_STAKING_ENABLED \
    --log-level=info