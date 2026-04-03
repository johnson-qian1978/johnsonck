#!/bin/bash
# 停止所有 Docker 容器（用于释放内存，如 DeerFlow）

echo "[信息] 正在停止所有 Docker 容器..."

# 停止所有运行中的容器
docker stop $(docker ps -q) 2>/dev/null

if [ $? -eq 0 ]; then
    echo "[成功] 所有容器已停止。"
else
    echo "[警告] 未检测到运行中的容器，或 Docker 服务未启动。"
fi

# 可选：禁用 Docker 开机自启（Linux）
# sudo systemctl disable docker
