# CJCMS - 内容管理系统

基于 Spring Boot + Oracle 的内容管理系统

## 📋 项目信息

- **项目名称**: CJCMS
- **技术栈**: Spring Boot 2.7.18 + Oracle 12c/19c + JPA
- **Java 版本**: JDK 11+
- **端口**: 8080
- **项目位置**: E:\CJCMS

## 🚀 快速开始

### 1. 数据库配置

#### 方式一：使用提供的 SQL 脚本初始化

```bash
# 使用 SQL*Plus 登录 Oracle
sqlplus / as sysdba

# 创建用户（如果还没有）
CREATE USER cjcms IDENTIFIED BY cjcms123;
GRANT CONNECT, RESOURCE, UNLIMITED TABLESPACE TO cjcms;

# 切换到 cjcms 用户
CONN cjcms/cjcms123

# 执行初始化脚本
@E:\CJCMS\database\init_oracle.sql
```

#### 方式二：手动创建表结构

使用 SQL Developer 或其他工具连接到 Oracle，执行 `database/init_oracle.sql` 脚本。

### 2. 修改数据库配置

编辑 `src/main/resources/application.properties` 文件：

```properties
# 修改为你的 Oracle 连接信息
spring.datasource.url=jdbc:oracle:thin:@localhost:1521/ORCL
spring.datasource.username=cjcms
spring.datasource.password=你的密码
```

**注意**：
- `ORCL` 是你的 Oracle 服务名，请根据实际情况修改
- 如果你的 Oracle 使用不同的端口（默认 1521），请相应修改

### 3. 构建和运行项目

```bash
# 进入项目目录
cd E:\CJCMS

# 使用 Maven 构建
mvn clean install

# 运行项目
mvn spring-boot:run

# 或者使用 jar 包运行
java -jar target/cjcms-1.0.0.jar
```

### 4. 访问应用

启动成功后，访问：
- **API 地址**: http://localhost:8080/api/articles

## 📡 API 接口

### 文章管理

| 方法 | 路径 | 描述 |
|------|------|------|
| GET | /api/articles | 获取所有文章 |
| GET | /api/articles/{id} | 根据 ID 获取文章 |
| POST | /api/articles | 创建文章 |
| PUT | /api/articles/{id} | 更新文章 |
| DELETE | /api/articles/{id} | 删除文章 |
| GET | /api/articles/status/{status} | 按状态查询文章 |
| GET | /api/articles/search?keyword=xxx | 搜索文章 |

### 示例请求

#### 创建文章
```bash
curl -X POST http://localhost:8080/api/articles \
  -H "Content-Type: application/json" \
  -d '{
    "title": "测试文章",
    "summary": "这是一篇测试文章",
    "content": "文章内容...",
    "author": "张三",
    "category": "测试分类",
    "status": 1
  }'
```

#### 获取所有文章
```bash
curl http://localhost:8080/api/articles
```

#### 搜索文章
```bash
curl "http://localhost:8080/api/articles/search?keyword=Spring"
```

## 📁 项目结构

```
E:\CJCMS\
├── src/
│   ├── main/
│   │   ├── java/com/cjcms/
│   │   │   ├── CjcmsApplication.java      # 主启动类
│   │   │   ├── controller/                 # 控制器层
│   │   │   ├── model/                      # 实体类
│   │   │   ├── repository/                 # 数据访问层
│   │   │   └── service/                    # 服务层
│   │   └── resources/
│   │       └── application.properties      # 配置文件
│   └── test/java/com/cjcms/               # 测试代码
├── database/
│   └── init_oracle.sql                    # Oracle 初始化脚本
├── pom.xml                                # Maven 配置
├── README.md                              # 项目说明
└── run.bat                                # Windows 启动脚本
```

## 🔧 开发工具推荐

- **IDE**: IntelliJ IDEA / Eclipse
- **数据库管理**: Oracle SQL Developer / PLSQL Developer
- **API 测试**: Postman / curl
- **构建工具**: Maven 3.6+

## 📝 Oracle 配置注意事项

1. **Oracle 驱动**：项目已配置 Oracle JDBC 驱动（ojdbc8），Maven 会自动下载
2. **序列配置**：Oracle 需要使用序列来生成主键，已创建 `ARTICLE_SEQ` 序列
3. **表名大写**：Oracle 默认表名是大写的，实体类中已配置 `@Table(name = "ARTICLES")`
4. **CLOB 类型**：Oracle 的长文本使用 CLOB 类型，已在实体类中配置
5. **Schema 配置**：如果使用了特定 schema，请在 `application.properties` 中配置：
   ```properties
   spring.jpa.properties.hibernate.default_schema=CJCMS
   ```

## 🔍 常见问题

### Q1: 找不到 Oracle 驱动？
确保 pom.xml 中有 Oracle 依赖：
```xml
<dependency>
    <groupId>com.oracle.database.jdbc</groupId>
    <artifactId>ojdbc8</artifactId>
    <version>21.9.0.0</version>
</dependency>
```

### Q2: 连接被拒绝？
检查：
1. Oracle 服务是否启动
2. 监听器是否启动（lsnrctl status）
3. 用户名密码是否正确
4. 服务名是否正确

### Q3: 表不存在？
确保：
1. 已执行 `init_oracle.sql` 脚本
2. 使用的用户有访问表的权限
3. 表名是大写的（ARTICLES）

### Q4: 中文乱码？
确保 Oracle 数据库字符集支持中文：
```sql
SELECT * FROM NLS_DATABASE_PARAMETERS WHERE PARAMETER LIKE '%CHARACTERSET%';
```

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

## 📄 许可证

MIT License
