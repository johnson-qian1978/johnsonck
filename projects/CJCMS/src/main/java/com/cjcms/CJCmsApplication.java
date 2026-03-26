package com.cjcms;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * 长江 CMS 启动类
 * @author CJCMS
 */
@SpringBootApplication
@MapperScan("com.cjcms.mapper")
public class CJCmsApplication {

    public static void main(String[] args) {
        SpringApplication.run(CJCmsApplication.class, args);
        System.out.println("========================================");
        System.out.println("   长江 CMS 系统启动成功！");
        System.out.println("   访问地址：http://localhost:8080");
        System.out.println("========================================");
    }
}
