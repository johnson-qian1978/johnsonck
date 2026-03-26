package com.cjcms.service;

import com.cjcms.entity.Menu;
import java.util.List;

/**
 * 菜单服务接口
 */
public interface MenuService {

    /**
     * 获取所有菜单树
     */
    List<Menu> getMenuTree();

    /**
     * 获取用户的菜单树
     */
    List<Menu> getUserMenuTree(String adminId);
}
