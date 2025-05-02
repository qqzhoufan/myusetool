进入到yaml下载的目录'/opt/qbittorrent/'下

```cd /opt/qbittorrent```

执行docker compose命令运行容器

```docker compose up -d```

等待执行结束，可以使用docker ps查看容器是否正常运行

```docker ps```

访问你的ip：端口号即可正常访问qbittorrent应用,端口号默认为yaml文件中的8080

```ip:8080```

qbittorrent 默认的用户名是admin.密码需要执行下面的语句去qbittorrent的日志中查看

```docker logs qbittorrent```

如果不需要使用qbittorrent后，可以在目录'/opt/qbittorrent/'下用docker compose down 删除该容器

```docker compose down```