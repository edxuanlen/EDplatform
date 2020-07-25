CREATE TABLE user_info(
  id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id VARCHAR(64) NOT NULL UNIQUE,
  username VARCHAR(32) NOT NULL,
  password VARCHAR(128) NOT NULL,
  signature VARCHAR(128) COMMENT '个性签名',
  phone VARCHAR(11),
  mail VARCHAR(140),
  birthday VARCHAR(20),
  sex TINYINT,
  school_name VARCHAR(64) COMMENT '学校名称',
  student_certification TINYINT DEFAULT 0 COMMENT '1为统一注册学生用户',
  school_number VARCHAR(64) COMMENT '统一注册时提交的学号',
  img_url VARCHAR(255) COMMENT '头像',
  last_login VARCHAR(20) COMMENT '最近一次登录时间',
  state TINYINT DEFAULT 1 COMMENT '账号状态，0为注销，1为激活',
  create_time DATETIME,
  update_time DATETIME
) ENGINE = InnoDB DEFAULT CHARSET = utf8;
CREATE TABLE black_user_list(
  id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id VARCHAR(64) NOT NULL UNIQUE,
  result VARCHAR(64),
  create_time DATETIME,
  update_time DATETIME
) ENGINE = InnoDB DEFAULT CHARSET = utf8;
CREATE TABLE relationship_user_list(
  id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  follow_user_id VARCHAR(64) NOT NULL,
  follower_user_id VARCHAR(64) NOT NULL,
  create_time DATETIME,
  update_time DATETIME
) ENGINE = InnoDB DEFAULT CHARSET = utf8;
CREATE TABLE blog_route(
  id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  blog_id BIGINT NOT NULL UNIQUE,
  user_id VARCHAR(64) NOT NULL,
  state TINYINT NOT NULL DEFAULT 1 COMMENT '1 公开，2 草稿，3 私密, 4 密码, 5 已删除',
  create_time DATETIME,
  update_time DATETIME
) ENGINE = InnoDB DEFAULT CHARSET = utf8;
CREATE TABLE blog_info(
  id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  blog_id BIGINT NOT NULL UNIQUE,
  blog_describe VARCHAR(64) COMMENT '摘要',
  blog_type TINYINT DEFAULT 1 COMMENT '1原创, 2转载',
  blog_content LONGTEXT COMMENT '文章内容',
  click_times BIGINT DEFAULT 0 COMMENT '点击次数',
  stars BIGINT COMMENT '收藏',
  state TINYINT NOT NULL DEFAULT 1 COMMENT '1 公开，2 草稿，3 私密, 4 密码, 5 已删除',
  create_time DATETIME,
  update_time DATETIME
) ENGINE = InnoDB DEFAULT CHARSET = utf8;
CREATE TABLE special_route(
  id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  special_id BIGINT NOT NULL,
  blog_id BIGINT NOT NULL,
  create_time DATETIME,
  update_time DATETIME
) ENGINE = InnoDB DEFAULT CHARSET = utf8;
CREATE TABLE special_info(
  id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  special_id BIGINT NOT NULL UNIQUE,
  special_describe VARCHAR(64) COMMENT '摘要',
  click_times BIGINT DEFAULT 0 COMMENT '点击次数',
  stars BIGINT COMMENT '收藏',
  state TINYINT NOT NULL DEFAULT 1 COMMENT '1 公开，2 草稿，3 私密, 4 密码, 5 已删除',
  create_time DATETIME,
  update_time DATETIME
) ENGINE = InnoDB DEFAULT CHARSET = utf8;
CREATE TABLE tag_info(
  id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  tag_id BIGINT NOT NULL UNIQUE,
  tag_name VARCHAR(32) NOT NULL,
  click_times BIGINT DEFAULT 0,
  create_time DATETIME,
  update_time DATETIME
) ENGINE = InnoDB DEFAULT CHARSET = utf8;
CREATE TABLE blog_tag_route(
  id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  blog_id BIGINT NOT NULL,
  tag_id BIGINT NOT NULL,
  create_time DATETIME,
  update_time DATETIME
) ENGINE = InnoDB DEFAULT CHARSET = utf8;
CREATE TABLE special_tag_route(
  id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  special_id BIGINT NOT NULL,
  tag_id BIGINT NOT NULL,
  create_time DATETIME,
  update_time DATETIME
) ENGINE = InnoDB DEFAULT CHARSET = utf8;
CREATE TABLE class_info(
  id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  class_id BIGINT NOT NULL UNIQUE,
  class_name VARCHAR(32) NOT NULL,
  click_times BIGINT DEFAULT 0,
  create_time DATETIME,
  update_time DATETIME
) ENGINE = InnoDB DEFAULT CHARSET = utf8;
CREATE TABLE blog_class_route(
  id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  blog_id BIGINT NOT NULL,
  class_id BIGINT NOT NULL,
  create_time DATETIME,
  update_time DATETIME
) ENGINE = InnoDB DEFAULT CHARSET = utf8;
CREATE TABLE special_class_route(
  id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  special_id BIGINT NOT NULL,
  class_id BIGINT NOT NULL,
  create_time DATETIME,
  update_time DATETIME
) ENGINE = InnoDB DEFAULT CHARSET = utf8;
CREATE TABLE user_star_blog_route(
  id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id VARCHAR(64) NOT NULL,
  blog_id BIGINT NOT NULL,
  create_time DATETIME,
  update_time DATETIME
) ENGINE = InnoDB DEFAULT CHARSET = utf8;
CREATE TABLE user_special_blog_route(
  id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id VARCHAR(64) NOT NULL,
  special_id BIGINT NOT NULL,
  create_time DATETIME,
  update_time DATETIME
) ENGINE = InnoDB DEFAULT CHARSET = utf8;
CREATE TABLE user_start_comment(
  id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id VARCHAR(64) NOT NULL,
  comment_id BIGINT NOT NULL,
  create_time DATETIME,
  update_time DATETIME
) ENGINE = InnoDB DEFAULT CHARSET = utf8;
CREATE TABLE blog_comment(
  id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  comment_id BIGINT NOT NULL UNIQUE,
  blog_id BIGINT NOT NULL,
  pid BIGINT DEFAULT NULL,
  user_id VARCHAR(64),
  comment_content TEXT NOT NULL,
  stars BIGINT COMMENT '点赞',
  create_time DATETIME,
  update_time DATETIME
) ENGINE = InnoDB DEFAULT CHARSET = utf8;
CREATE TABLE topic(
  id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  topic_id BIGINT NOT NULL UNIQUE,
  topic_describe VARCHAR(140) COMMENT '话题描述',
  topic_name VARCHAR(32) NOT NULL,
  user_id VARCHAR(64) NOT NULL,
  topic_participation BIGINT NOT NULL DEFAULT 0 COMMENT '话题热度',
  create_time DATETIME,
  update_time DATETIME
) ENGINE = InnoDB DEFAULT CHARSET = utf8;
CREATE TABLE topic_class_route(
  id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  topic_id BIGINT NOT NULL,
  class_id BIGINT NOT NULL,
  create_time DATETIME,
  update_time DATETIME
) ENGINE = InnoDB DEFAULT CHARSET = utf8;
CREATE TABLE topic_tag_route(
  id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  topic_id BIGINT NOT NULL,
  tag_id BIGINT NOT NULL,
  create_time DATETIME,
  update_time DATETIME
) ENGINE = InnoDB DEFAULT CHARSET = utf8;
CREATE TABLE group_info(
  id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  group_id BIGINT NOT NULL UNIQUE,
  group_name VARCHAR(64),
  group_describe VARCHAR(64),
  create_time DATETIME,
  update_time DATETIME
) ENGINE = InnoDB DEFAULT CHARSET = utf8;
CREATE TABLE user_group_route(
  id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  group_id BIGINT NOT NULL,
  user_id VARCHAR(64) NOT NULL,
  create_time DATETIME,
  update_time DATETIME
) ENGINE = InnoDB DEFAULT CHARSET = utf8;