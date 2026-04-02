#!/usr/bin/env python3
import json
import sys
import subprocess

def update_baidu_api_key(config_path, new_key):
    """Update the BAIDU_API_KEY in openclaw.json and restart the gateway."""
    try:
        with open(config_path, 'r', encoding='utf-8') as f:
            config = json.load(f)
        
        if 'plugins' not in config:
            print("Error: 'plugins' section not found in config.")
            return False
        
        if 'baidu-search' not in config['plugins']:
            print("Warning: 'baidu-search' plugin not found. Adding it.")
            config['plugins']['baidu-search'] = {"enabled": True, "config": {}}
        
        config['plugins']['baidu-search']['config']['api_key'] = new_key
        
        with open(config_path, 'w', encoding='utf-8') as f:
            json.dump(config, f, indent=2, ensure_ascii=False)
        
        print(f"Successfully updated BAIDU_API_KEY in {config_path}")
        
        # Restart OpenClaw Gateway
        print("Restarting OpenClaw Gateway...")
        result = subprocess.run(["pkill", "-f", "openclaw-gateway"], capture_output=True)
        if result.returncode == 0:
            print("Gateway process killed. Please start it again manually or via systemd.")
        else:
            print("Note: Could not kill gateway (may not be running). Remember to restart it.")
        
        return True
    except Exception as e:
        print(f"Error updating config: {e}", file=sys.stderr)
        return False

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python update_baidu_key.py <openclaw.json> <NEW_BAIDU_API_KEY>")
        sys.exit(1)
    
    config_file = sys.argv[1]
    new_key = sys.argv[2]
    
    if update_baidu_api_key(config_file, new_key):
        print("✅ BAIDU_API_KEY updated successfully.")
    else:
        sys.exit(1)