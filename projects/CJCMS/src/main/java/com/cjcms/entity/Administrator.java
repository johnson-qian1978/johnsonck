package com.cjcms.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import java.time.LocalDateTime;

/**
 * 管理员实体类
 */
@Data
@TableName("CJ_ADM_ADMINISTRATOR")
public class Administrator {

    @TableId(value = "ADMIN_ID", type = IdType.ASSIGN_UUID)
    private String adminId;

    @TableField("USERNAME")
    private String username;

    @TableField("PASSWORD_HASH")
    private String passwordHash;

    @TableField("REAL_NAME")
    private String realName;

    @TableField("EMAIL")
    private String email;

    @TableField("MOBILE")
    private String mobile;

    @TableField("DEPARTMENT")
    private String department;

    @TableField("POSITION")
    private String position;

    @TableField("STATUS")
    private Integer status;

    @TableField("LOGIN_COUNT")
    private Long loginCount;

    @TableField("LAST_LOGIN_TIME")
    private LocalDateTime lastLoginTime;

    @TableField("LAST_LOGIN_IP")
    private String lastLoginIp;

    @TableField("PASSWORD_ERROR_COUNT")
    private Integer passwordErrorCount;

    @TableField("LOCK_TIME")
    private LocalDateTime lockTime;

    @TableField(value = "CREATE_TIME", fill = FieldFill.INSERT)
    private LocalDateTime createTime;

    @TableField(value = "UPDATE_TIME", fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updateTime;
    
    /**
     * 主题偏好
     */
    @TableField("THEME_PREF")
    private String themePref;
    
    /**
     * 主题更新时间
     */
    @TableField("THEME_UPDATE_TIME")
    private LocalDateTime themeUpdateTime;
}
