## Nacos
- 版本:1.2.0
### 部署
- 下载Nacos镜像

```
docker pull nacos/nacos-server:1.2.0
```

- 启动Nacos

```
docker run --env MODE=standalone --name nacos -d -p 8848:8848 nacos/nacos-server
```

- 访问Nacos

访问地址：http://ip:8848/nacos