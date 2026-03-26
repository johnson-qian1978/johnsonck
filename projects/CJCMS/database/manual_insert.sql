INSERT INTO CJ_ADM_ADMINISTRATOR (ADMIN_ID, USERNAME, PASSWORD_HASH, REAL_NAME, EMAIL, DEPARTMENT, POSITION, STATUS) 
VALUES ('test001', 'testadmin', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lqkkO9QS3TzCjH3rS', 'Test Admin', 'test@test.com', 'IT', 'Admin', 1);

COMMIT;

SELECT username, real_name FROM cj_adm_administrator;
