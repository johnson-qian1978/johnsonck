package com.cjcms.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.cjcms.entity.Menu;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * 菜单 Mapper
 */
@Mapper
public interface MenuMapper extends BaseMapper<Menu> {

    /**
     * 查询所有一级菜单
     */
    @Select("SELECT * FROM CJ_SYS_MENU WHERE PARENT_ID IS NULL AND STATUS = 1 ORDER BY ORDER_NUM")
    List<Menu> selectLevel1Menus();

    /**
     * 查询指定父菜单下的子菜单
     */
    @Select("SELECT * FROM CJ_SYS_MENU WHERE PARENT_ID = #{parentId} AND STATUS = 1 ORDER BY ORDER_NUM")
    List<Menu> selectChildMenus(String parentId);

    /**
     * 查询用户有权限的所有菜单
     */
    @Select("SELECT DISTINCT m.* FROM CJ_SYS_MENU m " +
            "INNER JOIN CJ_ADM_ROLE_MENU rm ON m.MENU_ID = rm.MENU_ID " +
            "INNER JOIN CJ_ADM_ADMIN_ROLE ar ON rm.ROLE_ID = ar.ROLE_ID " +
            "WHERE ar.ADMIN_ID = #{adminId} AND m.STATUS = 1 " +
            "ORDER BY m.ORDER_NUM")
    List<Menu> selectMenusByAdminId(String adminId);
}
