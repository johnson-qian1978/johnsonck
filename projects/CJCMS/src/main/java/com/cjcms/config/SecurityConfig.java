package com.cjcms.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * Security 配置类
 */
@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public BCryptPasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    /**
     * Security 配置 - 禁用默认登录，使用自定义 REST API
     */
    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
            // 禁用 CSRF（我们使用 Token）
            .csrf(csrf -> csrf.disable())
            
            // 禁用默认的表单登录
            .formLogin(form -> form.disable())
            
            // 禁用 HTTP Basic 认证
            .httpBasic(basic -> basic.disable())
            
            // 配置帧选项 - 完全禁用 X-Frame-Options（允许 iframe 嵌入）
            .headers(headers -> headers
                .frameOptions(frame -> frame.disable())
            )
            
            // 配置请求授权
            .authorizeHttpRequests(auth -> auth
                // 静态资源允许匿名访问
                .requestMatchers("/", "/index.html", "/index.html?*", "/login.html", "/css/**", "/js/**", "/images/**", "/static/**", "/api/auth/login", "/api/auth/save-theme").permitAll()
                // 菜单和管理员 API 暂时允许匿名访问（开发阶段）
                .requestMatchers("/api/menu/**", "/api/admin/**").permitAll()
                // 其他所有请求需要认证
                .anyRequest().authenticated()
            )
            
            // 使用无状态会话（不使用 Session）
            .sessionManagement(session -> session
                .sessionCreationPolicy(SessionCreationPolicy.STATELESS)
            );
        
        return http.build();
    }

    /**
     * 跨域配置
     */
    @Configuration
    public static class CorsConfig implements WebMvcConfigurer {
        @Override
        public void addCorsMappings(CorsRegistry registry) {
            registry.addMapping("/**")
                    .allowedOriginPatterns("*")
                    .allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS")
                    .allowedHeaders("*")
                    .allowCredentials(true)
                    .maxAge(3600);
        }
        
        @Override
        public void addResourceHandlers(ResourceHandlerRegistry registry) {
            registry.addResourceHandler("/**")
                    .addResourceLocations("classpath:/static/")
                    .setCachePeriod(0); // 禁用缓存，确保每次都是最新文件
        }
        
        @Override
        public void addInterceptors(org.springframework.web.servlet.config.annotation.InterceptorRegistry registry) {
            registry.addInterceptor(new org.springframework.web.servlet.HandlerInterceptor() {
                @Override
                public boolean preHandle(jakarta.servlet.http.HttpServletRequest request, 
                                        jakarta.servlet.http.HttpServletResponse response, 
                                        Object handler) throws Exception {
                    // 移除 X-Frame-Options 限制，允许 iframe 嵌入
                    response.setHeader("X-Frame-Options", "SAMEORIGIN");
                    return true;
                }
            }).addPathPatterns("/**/*.html", "/**/*.htm");
        }
    }
}
