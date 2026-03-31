#!/bin/bash

# Install Tavily and Baidu search skills for OpenClaw
# This script automates the installation of external search capabilities
# as described in the DeerFlow + OpenClaw integration guide.

set -e

echo "Installing Tavily search skill..."
npx clawhub install openclaw-tavily-search

echo "Installing Baidu search skill..."
npx clawhub install baidu-search

echo "Search skills installed. Remember to configure API keys in ~/.openclaw/.env or as environment variables:"
echo "  BAIDU_API_KEY=your_key"
echo "  TAVILY_API_KEY=your_key"