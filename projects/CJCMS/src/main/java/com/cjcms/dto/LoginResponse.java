package com.cjcms.dto;

/**
 * 登录响应 DTO
 */
public class LoginResponse {

    private boolean success;
    private String message;
    private String token;
    private UserInfo user;

    public LoginResponse() {
    }

    public LoginResponse(boolean success, String message, String token, UserInfo user) {
        this.success = success;
        this.message = message;
        this.token = token;
        this.user = user;
    }

    public static LoginResponse success(String token, UserInfo user) {
        return new LoginResponse(true, "登录成功", token, user);
    }

    public static LoginResponse error(String message) {
        return new LoginResponse(false, message, null, null);
    }

    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public UserInfo getUser() {
        return user;
    }

    public void setUser(UserInfo user) {
        this.user = user;
    }

    /**
     * 用户信息内部类
     */
    public static class UserInfo {
        private Long id;
        private String username;
        private String realName;
        private String email;

        public UserInfo() {
        }

        public UserInfo(Long id, String username, String realName, String email) {
            this.id = id;
            this.username = username;
            this.realName = realName;
            this.email = email;
        }

        public Long getId() {
            return id;
        }

        public void setId(Long id) {
            this.id = id;
        }

        public String getUsername() {
            return username;
        }

        public void setUsername(String username) {
            this.username = username;
        }

        public String getRealName() {
            return realName;
        }

        public void setRealName(String realName) {
            this.realName = realName;
        }

        public String getEmail() {
            return email;
        }

        public void setEmail(String email) {
            this.email = email;
        }
    }
}
