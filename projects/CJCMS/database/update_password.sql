-- 更新管理员密码为 BCrypt 加密的 admin123
-- BCrypt hash for "admin123":
UPDATE CJ_ADM_ADMINISTRATOR 
SET PASSWORD_HASH = '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lqkkO9QS3TzCjH3rS' 
WHERE USERNAME = 'admin';

COMMIT;

-- 验证
SELECT username, real_name, substr(password_hash, 1, 20) as password_prefix FROM cj_adm_administrator WHERE username='admin';
