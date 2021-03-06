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

### 实例

1.新建module

2.改pom

3.写application
```yaml
server:
  port: 9011

spring:
  application:
    name: cloud-nacos-test9001
  cloud:
    nacos:
      discovery:
        server-addr: 47.102.210.6:8848

management:
  endpoint:
    web:
      exposure:
        include: '*'
```
4.配置类
```java
@RestController
public class PaymentController {
    @Value("${server.port}")
    private String serverPort;

    @GetMapping(value = "/payment/nacos/{id}")
    public String getPayment(@PathVariable("id") Integer id){
        return "nacos registry, serverPort: " + serverPort + "id" + id;
    }
}
```
5.启动类
```java
@EnableDiscoveryClient
@SpringBootApplication
public class PaymentMain9001 {
    public static void main(String[] args) {
        SpringApplication.run(PaymentMain9001.class, args);
    }
}
```

### 配置中心

#### pom.xml

```xml
<dependency>
    <groupId>com.alibaba.cloud</groupId>
    <artifactId>spring-cloud-starter-alibaba-nacos-config</artifactId>
</dependency>
```

#### bootstrap.yml

```yml
spring:
  application:
    name: cloud-nacos-test10001

  cloud:
    nacos:
      config:
        # nacos addr
        server-addr: 47.102.210.6:8848
        file-extension: yml
        # 配置共享
        # refreshable-dataids:
        # shared-dataids:
  
  profiles:
    # 选择版本
    active: test

```


#### Nacos Server配置中心

dataId 命名为
```
${prefix}-${spring.profile.active}.${file-extension}
```

#### 应用

```java
@RestController
// RefreshScope 实现配置的自动更新
@RefreshScope
public class PaymentController {
    @Value("${server.port}")
    private String serverPort;

    @GetMapping(value = "/payment/nacos/{id}")
    public String getPayment(@PathVariable("id") Integer id){
        return "nacos registry, serverPort: " + serverPort + "id" + id;
    }
}
```