# CJCMS 项目快速启动指南

## ✅ 项目已创建完成！

项目位置：`D:\Projects\CJCMS`

## 📋 下一步操作

### 第一步：确认 MySQL 数据库

**方式 1：如果你已经安装了 MySQL**

1. 打开命令行，登录 MySQL：
```bash
mysql -u root -p
```

2. 执行初始化脚本：
```sql
source D:\Projects\CJCMS\database\init.sql
```

3. 修改配置文件 `D:\Projects\CJCMS\src\main\resources\application.properties` 中的数据库密码：
```properties
spring.datasource.password=你的 MySQL 密码
```

**方式 2：如果你还没有安装 MySQL**

你需要先安装 MySQL：
1. 访问 https://dev.mysql.com/downloads/mysql/
2. 下载并安装 MySQL 8.0
3. 记住设置的 root 密码
4. 然后按照方式 1 操作

### 第二步：确认 Java 环境

检查 Java 版本：
```bash
java -version
```

需要 JDK 11 或更高版本。如果没有安装：
- 下载地址：https://adoptium.net/
- 安装后配置 JAVA_HOME 环境变量

### 第三步：确认 Maven 环境

检查 Maven 版本：
```bash
mvn -version
```

如果没有安装 Maven：
- 下载地址：https://maven.apache.org/download.cgi
- 或使用项目自带的 Maven Wrapper（推荐）

### 第四步：运行项目

在项目目录下执行：

```bash
cd D:\Projects\CJCMS

# 编译项目
mvn clean compile

# 运行项目
mvn spring-boot:run
```

### 第五步：测试 API

项目启动成功后，打开浏览器或使用 Postman 访问：

- **获取所有文章**: http://localhost:8080/api/articles
- **搜索文章**: http://localhost:8080/api/articles/search?keyword=CJCMS

或使用 curl 测试：
```bash
curl http://localhost:8080/api/articles
```

## 🎯 项目特性

✅ **已完成的功能**：
- Spring Boot 2.7.18 框架
- MySQL 数据库连接配置
- JPA 数据持久层
- RESTful API 接口
- 文章增删改查功能
- 文章搜索功能
- 自动创建数据库表

📁 **项目文件**：
```
D:\Projects\CJCMS\
├── pom.xml                                    # Maven 配置
├── README.md                                  # 项目说明
├── database\
│   └── init.sql                              # 数据库初始化脚本
└── src\main\
    ├── java\com\cjcms\
    │   ├── CjcmsApplication.java             # 主启动类
    │   ├── controller\ArticleController.java # REST 控制器
    │   ├── model\Article.java                # 文章实体
    │   ├── repository\ArticleRepository.java # 数据访问层
    │   └── service\ArticleService.java       # 业务逻辑层
    └── resources\
        └── application.properties            # 应用配置文件
```

## 🔧 常见问题

### Q1: 端口 8080 被占用怎么办？
编辑 `application.properties`，修改端口：
```properties
server.port=8081
```

### Q2: 数据库连接失败？
1. 检查 MySQL 服务是否启动
2. 检查数据库用户名密码是否正确
3. 确认数据库 `cjcms` 已创建

### Q3: 中文乱码？
确保数据库使用 utf8mb4 编码：
```sql
ALTER DATABASE cjcms CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

## 📞 需要帮助？

如果遇到问题，请告诉我具体的错误信息！
