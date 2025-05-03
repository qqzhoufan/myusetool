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


wirte_wait() {
          while read -t 0.001 -n 10000 discard; do :; done
          read -n 1 -s -r -p "按任意键退出..."
}


# 二级菜单下载需要的docker文件
docker_compose_nav() {
  base_url="https://raw.githubusercontent.com/qqzhoufan/myusetool/main/docker-compose"
  file_name="docker-compose.yaml"
  target="/opt/qb/docker-compose.yaml"
  clear
      echo -e "${Font_Blue}===============================${Font_Suffix}"
      echo -e "${Font_Blue}     请选择需要下载的项目          ${Font_Suffix}"
      echo -e "${Font_Blue}===============================${Font_Suffix}"
      echo -e "1. 下载qbittorrent"
      echo -e "0. 返回主菜单"
      echo -e "${Font_Blue}===============================${Font_Suffix}"
      read -p "请输入数字选择: " sub_choice
      
      case $sub_choice in
      1)
          mkdir "/opt/qbittorrent"
          if ! curl -L -o "$target" "$url/qbittorrent/$file_name"; then
              echo "curl失败，尝试wget..."
              wget -O "$target" "$url/qbittorrent/$file_name"
          fi
          wirte_wait
        ;;
      0)
        return
        ;;
      *)
        echo "无效的选择！"
        ;;
      esac
}

# 二级菜单：DD系统选择
dd_system_menu() {
    clear
    echo -e "${Font_Blue}===============================${Font_Suffix}"
    echo -e "${Font_Blue}     请选择重装系统下载方式       ${Font_Suffix}"
    echo -e "${Font_Blue}===============================${Font_Suffix}"
    echo -e "1. 使用curl下载DD"
    echo -e "2. 使用wget下载DD"
    echo -e "0. 返回主菜单"
    echo -e "${Font_Blue}===============================${Font_Suffix}"
    read -p "请输入数字选择: " sub_choice

    case $sub_choice in
        1)
            curl -so OsMutation.sh https://raw.githubusercontent.com/LloydAsp/OsMutation/main/OsMutation.sh && chmod u+x OsMutation.sh && ./OsMutation.sh
            ;;
        2)
            wget -qO OsMutation.sh https://raw.githubusercontent.com/LloydAsp/OsMutation/main/OsMutation.sh && chmod u+x OsMutation.sh && ./OsMutation.sh
            ;;
        0)
            return
            ;;
        *)
            echo "无效的选择！"
            ;;
    esac
}

# 脚本二级菜单：安装自己需要的脚本
tools_system_use() {
	clear
	echo -e "${Font_Blue}===============================${Font_Suffix}"
    echo -e "${Font_Blue}     请选择你需要安装的工具       ${Font_Suffix}"
    echo -e "${Font_Blue}===============================${Font_Suffix}"
    echo -e "1. 安装docker以及docker-compose"
    echo -e "2. 安装caddy反代工具"
    echo -e "3. 安装s-ui面板工具"
    echo -e "0. 返回主菜单"
    echo -e "${Font_Blue}===============================${Font_Suffix}"
    read -p "请输入数字选择: " sub_choice
	
	case $sub_choice in
        1)
            curl -fsSL https://get.docker.com -o get-docker.sh && chmod +x get-docker.sh && ./get-docker.sh
            wirte_wait
            ;;
        2)
            curl -Ls https://raw.githubusercontent.com/qqzhoufan/myusetool/main/caddy.sh -o caddy.sh && chmod +x caddy.sh && ./caddy.sh
            wirte_wait
            ;;
		    3)
            curl -Ls https://raw.githubusercontent.com/alireza0/s-ui/master/install.sh -o install.sh && chmod +x install.sh && ./install.sh
            wirte_wait
            ;;
        0)
            return
            ;;
        *)
            echo "无效的选择！"
            ;;
    esac
}

# ip测试脚本
ip_test() {
	clear
	echo -e "${Font_Blue}===============================${Font_Suffix}"
    echo -e "${Font_Blue}     请选择你使用的ip测试工具       ${Font_Suffix}"
    echo -e "${Font_Blue}===============================${Font_Suffix}"
#    echo -e "1. NS论坛酒神NodeQuality测试脚本（时间较长）"
    echo -e "1. 融合怪测试（大约7-10分钟）"
    echo -e "0. 返回主菜单"
    echo -e "${Font_Blue}===============================${Font_Suffix}"
    read -p "请输入数字选择: " sub_choice
	
	case $sub_choice in
#        1)
 #           bash <(curl -sL https://run.NodeQuality.com)
#            wirte_wait
 #           ;;
        1)
            curl -L https://gitlab.com/spiritysdx/za/-/raw/main/ecs.sh -o ecs.sh && chmod +x ecs.sh && bash ecs.sh
            wirte_wait
            ;;
        0)
            return
            ;;
        *)
            echo "无效的选择！"
            ;;
    esac
}

# 主菜单循环
while true; do
    clear
    echo -e "${Font_Blue}===============================${Font_Suffix}"
    echo -e "\033[1;36m咸鱼自用工具箱\033[0m"
    echo -e "\033[1;36m搜集的装机脚本\033[0m"  # 2C表示右移2字符位
    echo -e "${Font_Blue}===============================${Font_Suffix}"
    echo -e "1. 安装自己需要的脚本（比如docker）"
    echo -e "2. 选择你需要使用的ip测试工具"
    echo -e "3. NS论坛酒神DD系统（选择下载方式）"
    echo -e "4. 下载需要的docker-compose文件"
    echo -e "0. 退出"
    echo -e "${Font_Blue}===============================${Font_Suffix}"
    read -p "请输入数字选择操作: " choice

    case $choice in
        1)
            tools_system_use
            ;;
        2)
            ip_test
            ;;
        3)
            dd_system_menu
            ;;
        4)
            docker_compose_nav
            ;;
        0)
            echo "退出程序! "
            exit 0
            ;;
        *)
            echo "无效的选择！"
            sleep 1
            ;;
    esac
done
