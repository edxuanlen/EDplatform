### 服务调用 均衡负载--Ribbon

#### Ribbon 简介
Spring cloud Ribbon是一个基于HTTP和TCP的客户端负载均衡工具，它是基于Netflix的Riboon实现的。Ribbon是客户端负载均衡器，这有别于Nginx服务端负载均衡器。Ribbon本身提供了不同负载均衡策略使用不同的应用场景。

**PS: 客户端负载均衡和服务端负载均衡最大的不同在于服务清单所在的位置。客户端负载均衡中，客户端中都维护着自己要访问的服务段清单，而这些清单都来源于服务注册中心，但是服务端负载均衡的服务清单是无法自己来维护的。**

#### 负载均衡器分类

##### BaseLoadBalancer

BaseLoadBalancer类似Ribbon服务均衡器的基础实现类，在该类中定义了很多关于负载均衡器的基础内容。

##### DynamicServiceListLoadBalancer

DynamicServiceListLoadBalancer负载均衡器是对BaseLoadBalancer的扩展。

##### ZoneAwareLoadBalancer

ZoneAwareLoadBalancer负载均衡器是对DynamicServiceListLoadBalancer的扩展。

#### 负载均衡策略

IRule时负载均衡策略的接口，AbstractLoadBalancerRule是负载均衡策略的抽象类。下面是几个具体的实现类：

##### RandomRule

实现了从服务实例清单中随机选择一个服务实例的功能。

##### RoundRobinRule

实现了按照线性轮询的方式一次选择每个服务实例的功能。

##### RetryRule

实现了一个具备重试机制的实例选择功能。

##### WeightedResponseTimeRule

该策略是对RoundRobinRule的扩展，增加了根据实例的运行情况来计算权重，并根据权重来挑选实例，已达到更优的分配效果。

##### ClientConfigEnabledRoundRobinRule

该策略较为特殊，我们一般不直接使用它。可以通过继承该策略，默认的choose就实现了线性轮询机制，但是可以在子类中实现更高级的策略。

##### BestAvailableRule

该策略通过遍历负载均衡器中维护的所有实例，会过滤调故障的实例，并找出并发请求数最小的一个，所以该策略的特征是选择出最空闲的实例。

##### PredicateBaseRule

先通过子类中实现的Predicate逻辑来过滤一部分服务实例，然后再以线性轮询的方式从过滤后的实例清单中选出一个。至于如何过滤，需要我们在AbstractServerPredicate的子类中实现apply方法来确定具体的实现策略。

##### ZoneAvoidanceRule

是一个组合过滤条件，在其构造函数中，ZoneAvoidancePredicate为主过滤条件，AvailabilityPredicate为次过滤条件初始化了组合过滤条件的实例。

#### RestTemple

要使用ribbon实现负载均衡策略，restTemple是必不可少的，我们使用它实现对服务的消费访问和负载均衡。

##### GET

###### getForEntity

+ getForEntity（String url,Class responseType,Object... urlVariables）
    - 此方法有三个参数：其中url为请求地址，responseType为响应body的包装类型，urlVariables为url中的参数绑定。主要做法是：在url中使用占位符并配合urlVariables参数实现GET请求的参数绑定。
    - 如： 
    ```
    restTemplate.getForEntity("http://user-service/user?name={1}",User.class,"zhangsan");
    ```  
+ getForEntity(String url,Class responseType,Map urlVariables)
    - 此方法和上面的方法很像，只是参数类型不一样，使用了Map类型，所以在使用该方法绑定参数是需要在占位符中指定map中参数的key值。
    - 如： 
    ```
    params.put("name","zhangsan");
    params.put("age",2);
    responseEntity=restTemplate.getForEntity("http://user-service/user?name={name}?age={age}",User.class,params);
    ```
  
+ getForEntity(URI url,Class responseType)
    - 此方法用url对象替代了上面的url和urlVariables参数来指定访问地址和参数的绑定。
    - 如：
    ``` 
    UriComponents uriComponents=UriComponentsBuilder.fromUriString("http://user_service/user?name={name}").build().expand("zhangsan").encode();
    URI uri=uriComponents.toUri();
    ResponseEntity<User> responseEntity=restTemplate.getForEntity(uri,User.class,"zhangsan");
    ```

###### getForObject
    
此方法是和不需要关注除body外的其他内容时使用，因为之方法会直接返回响应体的body内容并进行对象封装，实现请求直接返回包装好的对象内容。

1. getForObject（String url,Class responseType,Object... urlVariables）
2. getForObject(String url,Class responseType,Map urlVariables)：
3. getForObject(URI url,Class responseType)

三种传参方式与getForEntity相同，不做重复描述。

##### POST

请求参数中和getForEntity大部分一致，只是多了一个参数request。request参数可以是个普通对象，也可以是一个HttpEntity对象。如果时一个普通对象，而非HttpEntity对象的时候，RestTemplate会将请求对象转换为一个HttpEntity对象来处理，其中Object就是request的类型，request内容会被事为完整的body来处理；而如果request是HttpEntity对象，那么就是被当作一个完成的HTTP请求对象来处理，这个request中不仅包含了body的内容，也包含了header的内容。

###### postForEntity

1. postForEntity（String url,Object request,Class responseType,Object... urlVariables）
2. postForEntity（String url,Object request,Class responseType,Map urlVariables）
3. postForEntity（URI url,Object request,Class responseType）

##### PUT

在RestTemplate中，对PUT请求可以通过put方法进行调用实现。　　  

1. put（String url,Object request,Object... urlVariables）
2. put（String url,Object request,Map urlVariables）
3. put（URI url,Object request)

##### DELETE

在RestTemplate中，对DELTTE请求可以通过delete方法进行调用实现。

1. put（String url,Object request,Object... urlVariables）
2. put（String url,Object request,Map urlVariables）
3. put（URI url,Object request)

#### pom.xml 配置

```xml
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-netflix-ribbon</artifactId>
</dependency>
```

#### 启动主类配置

```java
@EnableDiscoveryClient
@SpringBootApplication
public class RibbonApplicate{

    /**
     * 实例化ribbon使用的RestTemplate
     * @return
     */
    @Bean
    @LoadBalanced
    public RestTemplate rebbionRestTemplate(){
        return new RestTemplate();
    }
    
   public static void main (String[] args){
        SpringApplication.run(RibbonApplication.class,args);  
   }
}
```

#### 使用示例

```java
public class RibbonController{
     @autowired
    RestTemplate restTemplate;

    @Getmapping("/helloRibbon")
    public String helloRibbon(){
         //访问hello-service服务的hello接口
         return restTemplate.getForEntity("http://hello-service/hello",String.class).getBody();
      }  
}
```
