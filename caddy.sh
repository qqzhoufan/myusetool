#!/bin/bash

# 启用严格错误检查（符合网页6、7规范）
set -eo pipefail

# 配置颜色输出（增强可读性，参考网页7）
RED='\033[31m'
GREEN='\033[32m'
YELLOW='\033[33m'
NC='\033[0m'

# 函数：错误处理（参考网页6、8）
error_exit() {
    echo -e "${RED}[错误] $1${NC}" >&2
    exit 1
}

# 函数：步骤提示（参考网页7规范）
step_info() {
    echo -e "${YELLOW}[步骤] $1${NC}"
}

# 检查root权限（参考网页6安全规范）
if [[ $EUID -ne 0 ]]; then
    error_exit "该脚本需要root权限，请使用sudo执行"
fi

# 阶段1：系统更新（参考网页2）
step_info "正在更新系统软件包..."
if ! sudo apt update && sudo apt upgrade -y; then
    error_exit "系统更新失败"
fi

# 阶段2：安装依赖项（参考网页1）
step_info "安装必要依赖..."
required_pkgs=(debian-keyring debian-archive-keyring apt-transport-https curl gpg)
if ! sudo apt install -y "${required_pkgs[@]}"; then
    error_exit "依赖安装失败"
fi

# 阶段3：配置Caddy仓库（参考网页2、6）
step_info "配置Caddy仓库..."
keyring_dir="/usr/share/keyrings"
sources_dir="/etc/apt/sources.list.d"

# 创建目录（参考网页6路径处理规范）
mkdir -p "$keyring_dir" || error_exit "无法创建密钥目录"

# 下载并导入GPG密钥（添加错误检查）
if ! curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | 
   gpg --dearmor -o "${keyring_dir}/caddy-stable-archive-keyring.gpg"; then
    error_exit "GPG密钥下载失败"
fi

# 添加APT源（参考网页2）
if ! curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | 
   tee "${sources_dir}/caddy-stable.list" >/dev/null; then
    error_exit "APT源配置失败"
fi

# 阶段4：安装Caddy（参考网页2、3）
step_info "更新软件源..."
sudo apt update || error_exit "软件源更新失败"

step_info "正在安装Caddy..."
if ! sudo apt install -y caddy; then
    error_exit "Caddy安装失败"
fi

# 阶段5：服务管理（参考网页6最佳实践）
step_info "启动Caddy服务..."
sudo systemctl restart caddy || error_exit "服务启动失败"
sudo systemctl enable --now caddy || error_exit "服务启用失败"

echo -e "${GREEN}[成功] Caddy安装配置完成${NC}"
