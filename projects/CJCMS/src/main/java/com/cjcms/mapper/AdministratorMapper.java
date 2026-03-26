package com.cjcms.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.cjcms.entity.Administrator;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

/**
 * 管理员 Mapper
 */
@Mapper
public interface AdministratorMapper extends BaseMapper<Administrator> {

    /**
     * 根据用户名查询管理员
     */
    @Select("SELECT * FROM CJ_ADM_ADMINISTRATOR WHERE USERNAME = #{username}")
    Administrator selectByUsername(String username);
}
