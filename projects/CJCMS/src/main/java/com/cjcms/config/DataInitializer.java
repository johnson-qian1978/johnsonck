package com.cjcms.config;

import com.cjcms.entity.Administrator;
import com.cjcms.mapper.AdministratorMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;

/**
 * 数据初始化器 - 应用启动时自动插入测试数据
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class DataInitializer implements CommandLineRunner {

    private final AdministratorMapper administratorMapper;
    private final BCryptPasswordEncoder passwordEncoder;

    @Override
    public void run(String... args) throws Exception {
        try {
            // 检查是否已有管理员
            log.info("Checking for existing admin user...");
            Administrator existing = administratorMapper.selectByUsername("admin");
            
            if (existing == null) {
                log.info("Creating default admin user...");
                
                Administrator admin = new Administrator();
                admin.setAdminId("admin001");
                admin.setUsername("admin");
                admin.setPasswordHash(passwordEncoder.encode("admin123"));
                admin.setRealName("超级管理员");
                admin.setEmail("admin@cjcms.com");
                admin.setDepartment("技术部");
                admin.setPosition("系统管理员");
                admin.setStatus(1);
                admin.setLoginCount(0L);
                admin.setCreateTime(java.time.LocalDateTime.now());
                admin.setUpdateTime(java.time.LocalDateTime.now());
                
                administratorMapper.insert(admin);
                
                log.info("✅ Default admin user created successfully!");
                log.info("Username: admin");
                log.info("Password: admin123");
            } else {
                log.info("Admin user already exists: {}", existing.getRealName());
            }
        } catch (Exception e) {
            log.error("❌ Failed to create admin user: {}", e.getMessage(), e);
            // 不抛出异常，让应用继续启动
        }
    }
}
