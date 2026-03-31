#!/bin/bash

# Verify the authenticity of DeerFlow + OpenClaw integration claims
# Checks for existence of plugins and configuration paths that are often
# falsely reported in online tutorials.

set -e

echo "Checking for deerflow2-bridge plugin..."
if openclaw plugins list 2>/dev/null | grep -q "deerflow2-bridge"; then
  echo "✅ deerflow2-bridge plugin exists"
else
  echo "❌ deerflow2-bridge plugin does NOT exist (likely AI hallucination)"
fi

echo "\nChecking system.executor.engine config..."
if openclaw config get system.executor.engine >/dev/null 2>&1; then
  echo "✅ system.executor.engine config exists"
else
  echo "❌ system.executor.engine config does NOT exist (likely AI hallucination)"
fi

echo "\nChecking MCP gateway config..."
if openclaw config get gateway.mcp.enabled >/dev/null 2>&1; then
  echo "✅ gateway.mcp.enabled config exists"
else
  echo "⚠️ gateway.mcp.enabled config not found (may need manual setup)"
fi