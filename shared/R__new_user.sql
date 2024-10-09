-- V1.0__create_random_user_and_grant_access.sql

-- Ensure the extension for UUID is available
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- Generate a random string and create a new user
DO $$
DECLARE
    random_string TEXT;
    user_name TEXT;
BEGIN
    -- Generate a random string
    random_string := substring(md5(random()::text) from 1 for 8);  -- Get an 8-character random string

    -- Form the new user name
    user_name := random_string || 'user';

    -- Create the new user with a random name
    EXECUTE format('CREATE USER %I WITH PASSWORD %L', user_name, 'some_secure_password');

    -- Grant access to the current database
    EXECUTE format('GRANT CONNECT ON DATABASE %I TO %I', current_database(), user_name);

    -- Optionally grant additional privileges
    EXECUTE format('GRANT USAGE ON SCHEMA public TO %I', user_name);
    EXECUTE format('GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO %I', user_name);

    RAISE NOTICE 'User created: %', user_name;
END $$;
