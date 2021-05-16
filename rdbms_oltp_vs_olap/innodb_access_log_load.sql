CREATE SCHEMA IF NOT EXISTS tda;

use tda;

DROP TABLE IF EXISTS access_log_innodb;

CREATE TABLE access_log_innodb (
    client_ip TEXT,
    identity TEXT,
    user_name TEXT,
    time_stamp TEXT,
    timezone TEXT,
    request TEXT,
    status TEXT,
    bytes INTEGER,
    ref TEXT,
    user_agent TEXT,
    unknown TEXT
);

LOAD DATA INFILE '/work/uncommitted/access.log'
INTO TABLE access_log_innodb
FIELDS TERMINATED BY ' '
ENCLOSED BY '"'
;
