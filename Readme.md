## SpringCloud

### 新建工程
1.New project

2.聚合总父工程名字

3.Maven版本

4.工程名字

5.字符编码

6.注解生效激活


### 服务发现Eureka

1.简介
>Spring Cloud 封装了 Netflix 公司开发的 Eureka 模块来实现服务注册和发现(请对比Zookeeper)。
 Eureka 采用了 C-S 的设计架构。Eureka Server 作为服务注册功能的服务器，它是服务注册中心。
 而系统中的其他微服务，使用 Eureka 的客户端连接到 Eureka Server并维持心跳连接。这样系统的维护人员就可以通过 Eureka Server 来监控系统中各个微服务是否正常运行。SpringCloud 的一些其他模块（比如Zuul）就可以通过 Eureka Server 来发现系统中的其他微服务，并执行相关的逻辑。

- 包含两个组件Eureka Server和Eureka Client
- 三大角色
    - Eureka Server 提供服务注册和发现
    - Service Provider服务提供方将自身服务注册到Eureka，从而使服务消费方能够找到
    - Service Consumer服务消费方从Eureka获取注册服务列表，从而能够消费服务 

### 服务调用 负载均衡--Ribbon

[Ribbon README](Ribbon/Ribbon.md)


## 数据库
- 版本:MYSQL 5.7

### 数据字典

| COLUMN_NAME           | COLUMN_TYPE  | COLUMN_COMMENT                           |
| :---------------------: | :------------: | :----------------------------------------: |
| blog_id               | bigint(20)   | 博客唯一id                           |
| class_id              | bigint(20)   | 分类唯一id                           |
| comment_id            | bigint(20)   | 评论唯一id                           |
| pid                   | bigint(20)   | 评论的上级评论id                  |
| stars                 | bigint(20)   | 点赞                                   |
| click_times           | bigint(20)   | 点击次数                             |
| tag_id                | bigint(20)   | 标签唯一id                           |
| group_id              | bigint(20)   | 群众唯一id                           |
| special_id            | bigint(20)   | 专栏唯一id                           |
| topic_id              | bigint(20)   | 专题唯一id                           |
| topic_participation   | bigint(20)   | 话题热度                             |
| create_time           | datetime     | 数据创建时间                       |
| update_time           | datetime     | 数据变更时间                       |
| blog_content          | longtext     | 文章内容                             |
| comment_content       | text         | 评论内容                             |
| blog_type             | tinyint(4)   | 1原创, 2转载                         |
| state                 | tinyint(4)   | 1 公开，2 草稿，3 私密, 4 密码, 5 已删除 |
| sex                   | tinyint(4)   | 性别                                   |
| student_certification | tinyint(4)   | 1为统一注册学生用户             |
| phone                 | varchar(11)  | 手机号                                |
| password              | varchar(128) | 密码                                   |
| signature             | varchar(128) | 个性签名                             |
| topic_describe        | varchar(140) | 话题描述                             |
| mail                  | varchar(140) | 邮箱                                   |
| birthday              | varchar(20)  | 生日                                   |
| last_login            | varchar(20)  | 最近一次登录时间                 |
| img_url               | varchar(255) | 头像                                   |
| class_name            | varchar(32)  | 分类名称                             |
| tag_name              | varchar(32)  | 标签名称                             |
| topic_name            | varchar(32)  | 话题名称                             |
| username              | varchar(32)  | 用户名                                |
| user_id               | varchar(64)  | 用户唯一id                           |
| result                | varchar(64)  | 留空备用                             |
| blog_describe         | varchar(64)  | 摘要                                   |
| group_name            | varchar(64)  | 组名                                   |
| group_describe        | varchar(64)  | 群组描述                             |
| follow_user_id        | varchar(64)  | 关注id                                 |
| follower_user_id      | varchar(64)  | 被关注id                              |
| special_describe      | varchar(64)  | 摘要                                   |
| school_name           | varchar(64)  | 学校名称                             |
| school_number         | varchar(64)  | 统一注册时提交的学号           |

### 数据表

#### user_info 用户信息表

id(PRIMARYKEY), user_id(UNIQUE), username, password, signature 个人签名, phone, mail, 
birthday, sex, student_certification 学生认证账号, school_name 学校, school_number 学号  create_time, update_time
last_login 最近登录时间，img_url头像
```mysql
create table user_info(
    id bigint not null auto_increment primary key ,
    user_id varchar(64) not null unique ,
    username varchar(32) not null,
    password varchar(128) not null,
    signature varchar(128) comment '个性签名',
    phone varchar(11),
    mail varchar(140),
    birthday varchar(20),
    sex tinyint,
    school_name varchar(64) comment '学校名称',
    student_certification tinyint default 0 comment '1为统一注册学生用户',
    school_number varchar(64) comment '统一注册时提交的学号',
    img_url varchar(255) comment '头像',
    last_login varchar(20) comment '最近一次登录时间',
    state tinyint default 1 comment '账号状态，0为注销，1为激活',
    create_time datetime,
    update_time datetime
) ENGINE=InnoDB DEFAULT CHARSET = utf8;
```

#### black_user_list 黑名单

id, user_id, create_time, update_time, result（留空备用）

```mysql
create table black_user_list(
    id bigint not null auto_increment primary key ,
    user_id varchar(64) not null unique ,
    result varchar(64),
    create_time datetime,
    update_time datetime
) ENGINE=InnoDB DEFAULT CHARSET = utf8;
```
#### relationship_user_list 用户关系表

id(PRIMARYKEY), follow_user_id, follower_user_id, create_time, update_time
```mysql
create table relationship_user_list(
    id bigint not null auto_increment primary key ,
    follow_user_id varchar(64) not null ,
    follower_user_id varchar(64) not null ,
    create_time datetime ,
    update_time datetime
) ENGINE=InnoDB DEFAULT CHARSET = utf8;
```
#### blog_route 博文路由

id(PRIMARYKEY), blog_id(UNIQUE), user_id, create_time, update_time

```mysql
create table blog_route(
    id bigint not null auto_increment primary key,
    blog_id bigint not null UNIQUE,
    user_id varchar(64) not null,
    state tinyint not null default 1 comment '1 公开，2 草稿，3 私密, 4 密码, 5 已删除',
    create_time datetime,
    update_time datetime
) ENGINE=InnoDB DEFAULT CHARSET = utf8;
```

#### blog_info 博文信息

id(PRIMARYKEY), blog_id(UNIQUE)，blog_describe 描述，blog_tag 标签，blog_class
 分类，blog_content 博文内容, click_times 点击次数, stars 收藏, create_time, update_time

```mysql
create table blog_info(
    id bigint not null auto_increment primary key,
    blog_id bigint not null UNIQUE,
    blog_describe varchar(64) comment '摘要',
    blog_type tinyint  default 1 comment '1原创, 2转载',
    blog_content longtext comment '文章内容',
    click_times bigint default 0 comment '点击次数',
    stars bigint comment '收藏',
    state tinyint not null default 1 comment '1 公开，2 草稿，3 私密, 4 密码, 5 已删除',
    create_time datetime,
    update_time datetime
) ENGINE=InnoDB DEFAULT CHARSET = utf8;
```

#### special_route 专题路由

id, special_id, blog_id, create_time, update_time

```mysql
create table special_route(
    id bigint not null auto_increment primary key,
    special_id bigint not null,
    blog_id bigint not null,
    create_time datetime,
    update_time datetime
) ENGINE=InnoDB DEFAULT CHARSET = utf8;
```

#### special_info 专题内容

id, special_id, special_describe, special_tag, special_class,
stars, create_time, update_time

```mysql
create table special_info(
    id bigint not null auto_increment primary key,
    special_id bigint not null UNIQUE ,
    special_describe varchar(64) comment '摘要',
    click_times bigint default 0 comment '点击次数',
    stars bigint comment '收藏',
    state tinyint not null default 1 comment '1 公开，2 草稿，3 私密, 4 密码, 5 已删除',
    create_time datetime,
    update_time datetime
) ENGINE=InnoDB DEFAULT CHARSET = utf8;
```

#### tag_info 标签

id, tag_id, tag_name, click_times, create_time, update_time

```mysql
create table tag_info(
    id bigint not null auto_increment primary key,
    tag_id bigint not null UNIQUE ,
    tag_name varchar(32) not null,
    click_times bigint default 0,
    create_time datetime,
    update_time datetime
) ENGINE=InnoDB DEFAULT CHARSET = utf8;
```

#### blog_tag_route 博客标签路由

id, blog_id, tag_id, create_time, update_time

```mysql
create table blog_tag_route(
    id bigint not null auto_increment primary key,
    blog_id bigint not null,
    tag_id bigint not null,
    create_time datetime,
    update_time datetime
) ENGINE=InnoDB DEFAULT CHARSET = utf8;
```

#### special_tag_route 专题标签路由

id, special_id, tag_id, create_time, update_time

```mysql
create table special_tag_route(
    id bigint not null auto_increment primary key,
    special_id bigint not null,
    tag_id bigint not null,
    create_time datetime,
    update_time datetime
) ENGINE=InnoDB DEFAULT CHARSET = utf8;
```

#### class_info 分类

```mysql
create table class_info(
    id bigint not null auto_increment primary key,
    class_id bigint not null UNIQUE ,
    class_name varchar(32) not null,
    click_times bigint default 0,
    create_time datetime,
    update_time datetime
) ENGINE=InnoDB DEFAULT CHARSET = utf8;
```

#### blog_class_route 博客分类路由

id, blog_id, class_id, create_time, update_time

```mysql
create table blog_class_route(
    id bigint not null auto_increment primary key,
    blog_id bigint not null,
    class_id bigint not null,
    create_time datetime,
    update_time datetime
) ENGINE=InnoDB DEFAULT CHARSET = utf8;
```

#### special_class_route 专题分类路由

id, special_id, class_id, create_time, update_time

```mysql
create table special_class_route(
    id bigint not null auto_increment primary key,
    special_id bigint not null,
    class_id bigint not null,
    create_time datetime,
    update_time datetime
) ENGINE=InnoDB DEFAULT CHARSET = utf8;
```

#### user_star_blog_route 收藏博客

id, user_id, blog_id, create_time, update_time

```mysql
create table user_star_blog_route(
    id bigint not null auto_increment primary key,
    user_id varchar(64) not null ,
    blog_id bigint not null,
    create_time datetime,
    update_time datetime
) ENGINE=InnoDB DEFAULT CHARSET = utf8;
```

#### user_star_special_route 收藏专栏

id, user_id, special_id, create_time, update_time

```mysql
create table user_special_blog_route(
    id bigint not null auto_increment primary key,
    user_id varchar(64) not null ,
    special_id bigint not null,
    create_time datetime,
    update_time datetime
) ENGINE=InnoDB DEFAULT CHARSET = utf8;
```

#### user_star_comment 点赞评论

id, user_id, comment_id, create

```mysql

create table user_start_comment(
    id bigint not null auto_increment primary key,
    user_id varchar(64) not null ,
    comment_id bigint not null,
    create_time datetime,
    update_time datetime
) ENGINE=InnoDB DEFAULT CHARSET = utf8;
```


### blog_comment 评论

id(PRIMARYKEY), comment_id(UNIQUE), pid, blog_id, user_id, comment_content, stars 赞同, create_time, update_time

```mysql
create table blog_comment(
    id bigint not null auto_increment primary key,
    comment_id bigint not null UNIQUE ,
    blog_id bigint not null ,
    pid bigint default null,
    user_id varchar(64),
    comment_content text not null ,
    stars bigint comment '点赞',
    create_time datetime,
    update_time datetime

) ENGINE=InnoDB DEFAULT CHARSET = utf8;
```

#### topic 社区话题

id(PRIMARYKEY), topic_id(UNIQUE), topic_name, topic_describe, user_id 创建人, topic_class 话题分类, topic_participation 话题参与度, create_time, update_time

```mysql
create table topic(
    id bigint not null auto_increment primary key,
    topic_id bigint not null unique,
    topic_describe varchar(140) comment '话题描述',
    topic_name varchar(32) not null ,
    user_id varchar(64) not null ,
    topic_participation bigint not null default 0 comment '话题热度',
    create_time datetime,
    update_time datetime
) ENGINE=InnoDB DEFAULT CHARSET = utf8;
```

#### topic_class_route 话题分类路由

id, topic_id, class_id, create_time, update_time

```mysql
create table topic_class_route(
    id bigint not null auto_increment primary key,
    topic_id bigint not null,
    class_id bigint not null,
    create_time datetime,
    update_time datetime
) ENGINE=InnoDB DEFAULT CHARSET = utf8;
```

#### topic_tag_route 话题标签路由
id, topic_id, tag_id, create_time, update_time

```mysql
create table topic_tag_route(
    id bigint not null auto_increment primary key,
    topic_id bigint not null,
    tag_id bigint not null,
    create_time datetime,
    update_time datetime
) ENGINE=InnoDB DEFAULT CHARSET = utf8;
```

### group_info 群组

id(PRIMARYKEY), group_id(UNIQUE), group_name,  group_describe, create_time, update_time

```mysql
create table group_info(
    id bigint not null auto_increment primary key,
    group_id bigint not null unique,
    group_name varchar(64),
    group_describe varchar(64),
    create_time datetime,
    update_time datetime
) ENGINE=InnoDB DEFAULT CHARSET = utf8;
```

### user_group_route 

id(PRIMARYKEY), group_id, user_id, create_time, update_time

```sql
create table user_group_route(
    id bigint not null auto_increment primary key,
    group_id bigint not null,
    user_id varchar(64) not null,
    create_time datetime,
    update_time datetime
) ENGINE=InnoDB DEFAULT CHARSET = utf8;
```



