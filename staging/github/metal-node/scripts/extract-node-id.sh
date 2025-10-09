#!/bin/bash

# Extract Metal Node ID from logs or API
set -e

# Method 1: Try to get Node ID from API
get_node_id_from_api() {
    local rpc_url="http://localhost:${METAL_HTTP_PORT:-9650}"
    
    # Try API call
    local response=$(curl -s -X POST "$rpc_url/ext/info" \
        -H "Content-Type: application/json" \
        -d '{"jsonrpc":"2.0","id":1,"method":"info.getNodeID","params":{}}' 2>/dev/null)
    
    if echo "$response" | grep -q '"result"'; then
        local node_id=$(echo "$response" | grep -o '"result":"[^"]*"' | cut -d'"' -f4)
        if [ -n "$node_id" ]; then
            echo "NodeID-$node_id"
            return 0
        fi
    fi
    
    return 1
}

# Method 2: Try to get Node ID from logs
get_node_id_from_logs() {
    # Check if metalgo is running
    if pgrep -f metalgo > /dev/null; then
        # Try to get from journalctl if available
        if command -v journalctl > /dev/null; then
            local node_id=$(journalctl -u metalgo 2>/dev/null | grep "Set node's ID to" | tail -1 | grep -o "Set node's ID to [A-Za-z0-9]*" | cut -d' ' -f5)
            if [ -n "$node_id" ]; then
                echo "NodeID-$node_id"
                return 0
            fi
        fi
        
        # Try to get from log files
        if [ -f "/home/metal/.metalgo/logs/metalgo.log" ]; then
            local node_id=$(grep "Set node's ID to" /home/metal/.metalgo/logs/metalgo.log 2>/dev/null | tail -1 | grep -o "Set node's ID to [A-Za-z0-9]*" | cut -d' ' -f5)
            if [ -n "$node_id" ]; then
                echo "NodeID-$node_id"
                return 0
            fi
        fi
    fi
    
    return 1
}

# Method 3: Check if Node ID is already stored
get_stored_node_id() {
    if [ -f "/home/metal/.metalgo/node-id.env" ]; then
        source /home/metal/.metalgo/node-id.env
        if [ -n "$NODE_ID" ]; then
            echo "$NODE_ID"
            return 0
        fi
    fi
    
    return 1
}

# Main extraction logic
extract_node_id() {
    echo "🔍 Extracting Metal Node ID..."
    
    # Try stored Node ID first
    if get_stored_node_id; then
        return 0
    fi
    
    # Try API method
    if get_node_id_from_api; then
        return 0
    fi
    
    # Try logs method
    if get_node_id_from_logs; then
        return 0
    fi
    
    # If all methods fail, wait and retry
    echo "⏳ Node ID not found, waiting for node to start..."
    sleep 5
    
    # Retry API method
    if get_node_id_from_api; then
        return 0
    fi
    
    # Retry logs method
    if get_node_id_from_logs; then
        return 0
    fi
    
    echo "❌ Could not extract Node ID"
    return 1
}

# Run extraction
extract_node_id
