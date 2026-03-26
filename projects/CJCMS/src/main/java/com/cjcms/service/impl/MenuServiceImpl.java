package com.cjcms.service.impl;

import com.cjcms.entity.Menu;
import com.cjcms.mapper.MenuMapper;
import com.cjcms.service.MenuService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

/**
 * 菜单服务实现
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class MenuServiceImpl implements MenuService {

    private final MenuMapper menuMapper;

    @Override
    public List<Menu> getMenuTree() {
        log.info("Loading menu tree...");
        
        // 查询所有一级菜单
        List<Menu> level1Menus = menuMapper.selectLevel1Menus();
        log.info("Found {} level-1 menus", level1Menus.size());
        
        // 为每个一级菜单加载子菜单
        for (Menu menu : level1Menus) {
            List<Menu> children = menuMapper.selectChildMenus(menu.getMenuId());
            menu.setChildren(children);
            log.debug("Menu '{}' has {} children", menu.getMenuName(), children.size());
        }
        
        return level1Menus;
    }

    @Override
    public List<Menu> getUserMenuTree(String adminId) {
        // TODO: 根据用户权限过滤菜单
        // 暂时返回所有菜单
        return getMenuTree();
    }
}
