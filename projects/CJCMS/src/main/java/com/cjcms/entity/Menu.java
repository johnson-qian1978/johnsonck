package com.cjcms.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import java.time.LocalDateTime;
import java.util.List;

/**
 * 菜单实体类
 */
@Data
@TableName("CJ_SYS_MENU")
public class Menu {

    /**
     * 菜单 ID
     */
    @TableId(value = "MENU_ID", type = IdType.ASSIGN_UUID)
    private String menuId;

    /**
     * 父菜单 ID
     */
    @TableField("PARENT_ID")
    private String parentId;

    /**
     * 菜单名称
     */
    @TableField("MENU_NAME")
    private String menuName;

    /**
     * 菜单编码
     */
    @TableField("MENU_CODE")
    private String menuCode;

    /**
     * 菜单类型：1-目录，2-菜单，3-按钮，4-API
     */
    @TableField("MENU_TYPE")
    private Integer menuType;

    /**
     * 路由路径
     */
    @TableField("ROUTE_PATH")
    private String routePath;

    /**
     * 组件路径
     */
    @TableField("COMPONENT_PATH")
    private String componentPath;

    /**
     * 图标
     */
    @TableField("ICON")
    private String icon;

    /**
     * 排序号
     */
    @TableField("ORDER_NUM")
    private Integer orderNum;

    /**
     * 是否可见：0-否，1-是
     */
    @TableField("IS_VISIBLE")
    private Integer isVisible;

    /**
     * 权限标识
     */
    @TableField("PERMISSION_CODE")
    private String permissionCode;

    /**
     * 状态：0-禁用，1-启用
     */
    @TableField("STATUS")
    private Integer status;

    /**
     * 创建时间
     */
    @TableField(value = "CREATE_TIME", fill = FieldFill.INSERT)
    private LocalDateTime createTime;

    /**
     * 子菜单（非数据库字段）
     */
    @TableField(exist = false)
    private List<Menu> children;
    
    // Manual getters and setters
    public String getMenuId() { return menuId; }
    public void setMenuId(String menuId) { this.menuId = menuId; }
    public String getParentId() { return parentId; }
    public void setParentId(String parentId) { this.parentId = parentId; }
    public String getMenuName() { return menuName; }
    public void setMenuName(String menuName) { this.menuName = menuName; }
    public String getMenuCode() { return menuCode; }
    public void setMenuCode(String menuCode) { this.menuCode = menuCode; }
    public Integer getMenuType() { return menuType; }
    public void setMenuType(Integer menuType) { this.menuType = menuType; }
    public String getRoutePath() { return routePath; }
    public void setRoutePath(String routePath) { this.routePath = routePath; }
    public String getComponentPath() { return componentPath; }
    public void setComponentPath(String componentPath) { this.componentPath = componentPath; }
    public String getIcon() { return icon; }
    public void setIcon(String icon) { this.icon = icon; }
    public Integer getOrderNum() { return orderNum; }
    public void setOrderNum(Integer orderNum) { this.orderNum = orderNum; }
    public Integer getIsVisible() { return isVisible; }
    public void setIsVisible(Integer isVisible) { this.isVisible = isVisible; }
    public String getPermissionCode() { return permissionCode; }
    public void setPermissionCode(String permissionCode) { this.permissionCode = permissionCode; }
    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }
    public LocalDateTime getCreateTime() { return createTime; }
    public void setCreateTime(LocalDateTime createTime) { this.createTime = createTime; }
    public List<Menu> getChildren() { return children; }
    public void setChildren(List<Menu> children) { this.children = children; }
}
