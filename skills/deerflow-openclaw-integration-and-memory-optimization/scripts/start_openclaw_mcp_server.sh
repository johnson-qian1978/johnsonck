#!/bin/bash

# Start OpenClaw as an MCP server for DeerFlow integration
# This enables DeerFlow (as MCP client) to invoke OpenClaw's IM channels
# via the Model Context Protocol (MCP).

set -e

DEFAULT_URL="ws://127.0.0.1:18789"

if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
  echo "Usage: $0 [websocket_url]"
  echo "Default URL: $DEFAULT_URL"
  exit 0
fi

URL=${1:-$DEFAULT_URL}

echo "Starting OpenClaw MCP server at $URL ..."
openclaw mcp serve --url "$URL"
