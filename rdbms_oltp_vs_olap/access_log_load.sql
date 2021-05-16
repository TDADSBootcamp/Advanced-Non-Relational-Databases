CREATE SCHEMA tda;

use tda;

DROP TABLE access_log;

CREATE TABLE access_log (
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


LOAD DATA INFILE '/work/uncommitted/access.log'
INTO TABLE access_log
FIELDS TERMINATED BY ' '
ENCLOSED BY '"'
;