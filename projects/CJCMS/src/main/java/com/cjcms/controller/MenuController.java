package com.cjcms.controller;

import com.cjcms.entity.Menu;
import com.cjcms.service.MenuService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 菜单控制器
 */
@Slf4j
@RestController
@RequestMapping("/api/menu")
@RequiredArgsConstructor
public class MenuController {

    private final MenuService menuService;
    
    private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(MenuController.class);

    /**
     * 获取菜单树
     */
    @GetMapping("/tree")
    public Map<String, Object> getMenuTree() {
        Map<String, Object> result = new HashMap<>();
        
        try {
            List<Menu> menus = menuService.getMenuTree();
            
            result.put("code", 200);
            result.put("message", "success");
            result.put("data", menus);
            
        } catch (Exception e) {
            log.error("获取菜单失败", e);
            result.put("code", 500);
            result.put("message", "系统错误：" + e.getMessage());
        }

        return result;
    }
}
