-- Simple insert test
INSERT INTO CJ_ADM_ADMINISTRATOR (ADMIN_ID, USERNAME, PASSWORD_HASH, REAL_NAME, EMAIL, DEPARTMENT, POSITION, STATUS) 
VALUES ('admin001', 'admin', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lqkkO9QS3TzCjH3rS', '超级管理员', 'admin@cjcms.com', '技术部', '系统管理员', 1);

COMMIT;

SELECT username, real_name FROM CJ_ADM_ADMINISTRATOR;
