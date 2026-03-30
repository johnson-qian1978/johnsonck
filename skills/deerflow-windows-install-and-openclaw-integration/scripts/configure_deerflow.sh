#!/bin/bash

git clone https://github.com/bytedance/deer-flow.git
cd deer-flow
cp config.example.yaml config.yaml

# Note: User must manually edit config.yaml to set model API details
# Example:
# models:
#   - name: glm-5
#     use: langchain_openai:ChatOpenAI
#     model: glm-5
#     api_key: $GITCODE_API_KEY
#     base_url: https://api-ai.gitcode.com/v1

echo "Please edit config.yaml before proceeding."
