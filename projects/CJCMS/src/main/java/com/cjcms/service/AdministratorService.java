package com.cjcms.service;

import com.cjcms.entity.Administrator;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

/**
 * 管理员服务接口
 */
public interface AdministratorService {

    /**
     * 根据用户名查询管理员
     */
    Administrator getByUsername(String username);

    /**
     * 根据 ID 查询管理员
     */
    Administrator getById(String id);

    /**
     * 验证登录
     */
    Administrator validateLogin(String username, String password);

    /**
     * 更新登录信息
     */
    void updateLoginInfo(String adminId, String ip);

    /**
     * 获取管理员列表
     */
    List<Map<String, Object>> getAdministratorList(
            String roleId,
            String sortBy,
            LocalDateTime lastLoginAfter,
            String keyword);
}
