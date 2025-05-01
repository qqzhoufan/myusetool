#!/bin/bash

Font_Black="\033[30m"
Font_Red="\033[31m"
Font_Green="\033[32m"
Font_Yellow="\033[33m"
Font_Blue="\033[34m"
Font_Purple="\033[35m"
Font_SkyBlue="\033[36m"
Font_White="\033[37m"
Font_Suffix="\033[0m"

clear

echo -e "${Font_Blue}===============================${Font_Suffix}"
echo -e "${Font_Blue}           咸鱼自用工具箱         ${Font_Suffix}"
echo -e "${Font_Blue}        	搜集的装机脚本         ${Font_Suffix}"
echo -e "${Font_Blue}===============================${Font_Suffix}"
echo -e "${Font_Blue}1. 一键安装docker以及docker compose${Font_Suffix}"
echo -e "${Font_Blue}2. 安装s-ui脚本${Font_Suffix}"
echo -e "${Font_Blue}3. NS论坛酒神NodeQuality测试脚本${Font_Suffix}"
echo -e "${Font_Blue}4. NS论坛酒神DD系统01${Font_Suffix}"
echo -e "${Font_Blue}5. NS论坛酒神DD系统02${Font_Suffix}"
echo -e "${Font_Blue}0. 退出${Font_Suffix}"
echo -e "${Font_Blue}==============================${Font_Suffix}"
read -p "请输入数字选择操作: " choice

case $choice in
    1)
        curl -fsSL https://get.docker.com -o get-docker.sh && chmod +x get-docker.sh && ./get-docker.sh
        ;;
    2)
        curl -Ls https://raw.githubusercontent.com/alireza0/s-ui/master/install.sh -o install.sh && chmod +x install.sh && ./install.sh
        ;;
    3)
        curl -sL https://run.NodeQuality.com
        ;;
	4)
        curl -so OsMutation.sh https://raw.githubusercontent.com/LloydAsp/OsMutation/main/OsMutation.sh && chmod u+x OsMutation.sh && ./OsMutation.sh
        ;;
	5)
        wget -qO OsMutation.sh https://raw.githubusercontent.com/LloydAsp/OsMutation/main/OsMutation.sh && chmod u+x OsMutation.sh && ./OsMutation.sh
        ;;
    0)
        echo "退出程序! "
        exit 0
        ;;
    *)
        echo "无效的选择！"
        exit 1
        ;;
esac
