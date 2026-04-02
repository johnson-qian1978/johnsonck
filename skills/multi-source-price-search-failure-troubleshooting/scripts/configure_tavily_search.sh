#!/bin/bash

# Script to configure Tavily API key for OpenClaw/DeerFlow environments
# Usage: ./configure_tavily_search.sh <TAVILY_API_KEY>

set -e

if [ $# -ne 1 ]; then
  echo "Usage: $0 <TAVILY_API_KEY>"
  exit 1
fi

TAVILY_KEY="$1"
ENV_FILE=".env"

# Create .env if it doesn't exist
if [ ! -f "$ENV_FILE" ]; then
  touch "$ENV_FILE"
  echo "Created empty $ENV_FILE"
fi

# Remove existing TAVILY_API_KEY line if present
sed -i.bak '/^TAVILY_API_KEY=/d' "$ENV_FILE"

# Append new key
echo "TAVILY_API_KEY=$TAVILY_KEY" >> "$ENV_FILE"

# Ensure no duplicate lines
sort -u "$ENV_FILE" -o "$ENV_FILE"

# Restart services if running (optional)
if pgrep -f "openclaw-gateway" > /dev/null; then
  echo "Restarting OpenClaw Gateway..."
  pkill -f "openclaw-gateway"
  # Note: actual restart mechanism depends on deployment (systemd, docker, etc.)
fi

if pgrep -f "deerflow" > /dev/null; then
  echo "Restarting DeerFlow..."
  pkill -f "deerflow"
fi

echo "✅ Tavily API key configured in $ENV_FILE"
echo "Remember to start your services if they were stopped."
