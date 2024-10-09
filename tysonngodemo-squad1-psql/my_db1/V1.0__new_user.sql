-- V1.0__create_new_user.sql

-- Create a new user in PostgreSQL
CREATE USER new_user_1 WITH PASSWORD 'your_secure_password';

-- Optionally, grant privileges to the new user
GRANT CONNECT ON DATABASE my_db1 TO new_user_1;
