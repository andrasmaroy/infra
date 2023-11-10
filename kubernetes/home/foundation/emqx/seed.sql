CREATE EXTENSION IF NOT EXISTS pgcrypto;

DO $$ BEGIN
    CREATE TYPE ACTION AS ENUM('publish','subscribe','all');
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;
DO $$ BEGIN
    CREATE TYPE PERMISSION AS ENUM('allow','deny');
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

CREATE TABLE IF NOT EXISTS mqtt_acl (
  id SERIAL PRIMARY KEY,
  ipaddress CHARACTER VARYING(60) NOT NULL DEFAULT '',
  username CHARACTER VARYING(255) NOT NULL DEFAULT '',
  clientid CHARACTER VARYING(255) NOT NULL DEFAULT '',
  action ACTION,
  permission PERMISSION,
  topic CHARACTER VARYING(255) NOT NULL,
  qos smallint,
  retain smallint
);

CREATE INDEX IF NOT EXISTS mqtt_acl_username_idx ON mqtt_acl(username);

CREATE TABLE IF NOT EXISTS mqtt_user (
    id serial PRIMARY KEY,
    username text NOT NULL UNIQUE,
    password_hash  text NOT NULL,
    salt text NOT NULL,
    is_superuser boolean DEFAULT false,
    created timestamp with time zone DEFAULT NOW()
);

CREATE OR REPLACE FUNCTION password_hash_tg() RETURNS trigger AS $$
BEGIN
    IF tg_op = 'INSERT' OR tg_op = 'UPDATE' THEN
        NEW.salt = gen_salt('md5');
        NEW.password_hash = encode(digest(NEW.salt || NEW.password_hash, 'sha256'),'hex');
        RETURN NEW;
    END IF;
END;
$$ LANGUAGE plpgsql;

BEGIN;
    DELETE FROM mqtt_user;
    CREATE OR REPLACE TRIGGER insert_user
    BEFORE INSERT OR UPDATE ON mqtt_user
    FOR EACH ROW
    WHEN ( NEW.salt IS NULL )
    EXECUTE PROCEDURE password_hash_tg();

    \COPY mqtt_user(username,password_hash,is_superuser) FROM '/user.csv' CSV HEADER;

    DROP TRIGGER IF EXISTS insert_user ON mqtt_user;
END;

BEGIN;
    DELETE FROM mqtt_acl;
    \COPY mqtt_acl(username,action,permission,topic) FROM '/acl.csv' CSV HEADER;
END;
