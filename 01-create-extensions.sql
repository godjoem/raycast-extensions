-- Per pg_partman's official documentation, it's best to create a dedicated schema.
CREATE SCHEMA partman;

-- Now create the extension and tell it to use the new schema.
CREATE EXTENSION pg_partman WITH SCHEMA partman;

CREATE EXTENSION pg_cron;
