package com.cjcms.controller;

import com.cjcms.entity.Administrator;
import com.cjcms.mapper.AdministratorMapper;
import com.cjcms.service.AdministratorService;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

/**
 * 认证控制器
 */
@Slf4j
@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
public class AuthController {

    private final AdministratorService administratorService;
    private final AdministratorMapper administratorMapper;
    
    private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(AuthController.class);

    @Data
    public static class LoginRequest {
        private String username;
        private String password;
        
        // Manual getters and setters
        public String getUsername() { return username; }
        public void setUsername(String username) { this.username = username; }
        public String getPassword() { return password; }
        public void setPassword(String password) { this.password = password; }
    }

    @Data
    public static class LoginResponse {
        private String token;
        private Administrator user;
    }

    /**
     * 登录接口
     */
    @PostMapping("/login")
    public Map<String, Object> login(@RequestBody LoginRequest request, HttpServletRequest httpRequest) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            // 验证登录
            Administrator admin = administratorService.validateLogin(
                request.getUsername(), 
                request.getPassword()
            );

            if (admin == null) {
                result.put("code", 401);
                result.put("message", "用户名或密码错误");
                return result;
            }

            // 更新登录信息
            String ip = httpRequest.getRemoteAddr();
            administratorService.updateLoginInfo(admin.getAdminId(), ip);

            // TODO: 生成 JWT Token（简化版本，实际应该使用 JWT）
            String token = "mock-jwt-token-" + admin.getAdminId();

            // 返回结果
            result.put("code", 200);
            result.put("message", "登录成功");
            
            Map<String, Object> data = new HashMap<>();
            data.put("token", token);
            data.put("user", admin);
            // 添加主题偏好
            data.put("theme", admin.getThemePref() != null ? admin.getThemePref() : "theme1");
            result.put("data", data);

            log.info("用户登录成功：{}", admin.getUsername());

        } catch (Exception e) {
            log.error("登录失败", e);
            result.put("code", 500);
            result.put("message", "系统错误：" + e.getMessage());
        }

        return result;
    }

    /**
     * 登出接口
     */
    @PostMapping("/logout")
    public Map<String, Object> logout() {
        Map<String, Object> result = new HashMap<>();
        result.put("code", 200);
        result.put("message", "登出成功");
        return result;
    }

    /**
     * 获取当前用户信息
     */
    @GetMapping("/current")
    public Map<String, Object> getCurrentUser() {
        Map<String, Object> result = new HashMap<>();
        // TODO: 从 Token 中解析用户信息
        result.put("code", 200);
        result.put("message", "success");
        return result;
    }

    /**
     * 保存用户主题偏好
     */
    @PostMapping("/save-theme")
    public Map<String, Object> saveTheme(@RequestBody Map<String, String> request) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            String theme = request.get("theme");
            String username = request.get("username");
            
            if (username == null || theme == null) {
                result.put("code", 400);
                result.put("message", "参数错误");
                return result;
            }
            
            // 查询用户
            Administrator admin = administratorService.getByUsername(username);
            if (admin == null) {
                result.put("code", 404);
                result.put("message", "用户不存在");
                return result;
            }
            
            // 更新主题偏好
            admin.setThemePref(theme);
            admin.setThemeUpdateTime(java.time.LocalDateTime.now());
            
            // 保存到数据库（需要添加 update 方法）
            administratorMapper.updateById(admin);
            
            log.info("用户 {} 保存主题偏好：{}", username, theme);
            
            result.put("code", 200);
            result.put("message", "主题已保存");
            
        } catch (Exception e) {
            log.error("保存主题失败", e);
            result.put("code", 500);
            result.put("message", "保存失败：" + e.getMessage());
        }
        
        return result;
    }
}
