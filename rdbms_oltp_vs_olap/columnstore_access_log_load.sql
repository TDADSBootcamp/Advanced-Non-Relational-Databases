CREATE SCHEMA IF NOT EXISTS tda;

use tda;

DROP TABLE IF EXISTS access_log_columnstore;

CREATE TABLE access_log_columnstore (
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
) ENGINE=ColumnStore;


LOAD DATA INFILE '/work/uncommitted/access.log' IGNORE
INTO TABLE access_log_columnstore
FIELDS TERMINATED BY ' '
ENCLOSED BY '"'
;
