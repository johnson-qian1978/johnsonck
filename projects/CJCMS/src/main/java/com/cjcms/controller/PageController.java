package com.cjcms.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

/**
 * 页面控制器 - 用于返回静态页面
 */
@Controller
public class PageController {

    /**
     * 仪表盘页面
     */
    @GetMapping("/dashboard")
    public String dashboard() {
        return "redirect:/dashboard.html";
    }

    /**
     * 登录页面
     */
    @GetMapping("/")
    public String login() {
        return "redirect:/login.html";
    }
}
