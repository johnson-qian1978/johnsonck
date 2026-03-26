package com.cjcms.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.cjcms.entity.Administrator;
import com.cjcms.mapper.AdministratorMapper;
import com.cjcms.service.AdministratorService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * 管理员服务实现
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class AdministratorServiceImpl implements AdministratorService {

    private final AdministratorMapper administratorMapper;
    private final BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    @Override
    public Administrator getByUsername(String username) {
        return administratorMapper.selectByUsername(username);
    }

    @Override
    public Administrator getById(String id) {
        return administratorMapper.selectById(id);
    }

    @Override
    public Administrator validateLogin(String username, String password) {
        Administrator admin = getByUsername(username);
        
        if (admin == null) {
            log.warn("用户不存在：{}", username);
            return null;
        }

        if (admin.getStatus() != 1) {
            log.warn("用户已被禁用：{}", username);
            return null;
        }

        // 验证密码（数据库中的密码是 BCrypt 加密的）
        if (!passwordEncoder.matches(password, admin.getPasswordHash())) {
            log.warn("密码错误：{}", username);
            return null;
        }

        log.info("登录成功：{}", username);
        return admin;
    }

    @Override
    public void updateLoginInfo(String adminId, String ip) {
        Administrator admin = administratorMapper.selectById(adminId);
        if (admin != null) {
            admin.setLoginCount(admin.getLoginCount() != null ? admin.getLoginCount() + 1 : 1);
            admin.setLastLoginTime(LocalDateTime.now());
            admin.setLastLoginIp(ip);
            administratorMapper.updateById(admin);
        }
    }

    @Override
    public List<Map<String, Object>> getAdministratorList(
            String roleId,
            String sortBy,
            LocalDateTime lastLoginAfter,
            String keyword) {
        
        log.info("查询管理员列表 - roleId: {}, sortBy: {}, lastLoginAfter: {}, keyword: {}", 
                 roleId, sortBy, lastLoginAfter, keyword);
        
        // 构建查询条件
        LambdaQueryWrapper<Administrator> wrapper = new LambdaQueryWrapper<>();
        
        // 按最后登录时间过滤
        if (lastLoginAfter != null) {
            wrapper.ge(Administrator::getLastLoginTime, lastLoginAfter);
        }
        
        // 按关键词过滤
        if (keyword != null && !keyword.isEmpty()) {
            wrapper.and(w -> w
                .like(Administrator::getUsername, keyword)
                .or()
                .like(Administrator::getRealName, keyword)
            );
        }
        
        // 查询数据
        List<Administrator> admins = administratorMapper.selectList(wrapper);
        
        // 转换为 Map 列表
        return admins.stream()
            .map(admin -> {
                Map<String, Object> map = new HashMap<>();
                map.put("id", admin.getAdminId());
                map.put("username", admin.getUsername());
                map.put("realName", admin.getRealName());
                map.put("email", admin.getEmail());
                map.put("mobile", admin.getMobile());
                map.put("status", admin.getStatus());
                map.put("loginCount", admin.getLoginCount());
                map.put("lastLoginTime", admin.getLastLoginTime());
                map.put("lastLoginIp", admin.getLastLoginIp());
                map.put("createTime", admin.getCreateTime());
                return map;
            })
            .collect(Collectors.toList());
    }
}
