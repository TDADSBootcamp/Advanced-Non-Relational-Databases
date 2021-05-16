Compare performance of
default [MariaDB](https://mariadb.org/) engine [InnoDB](https://en.wikipedia.org/wiki/InnoDB)
with analytics specialist [ColumnStore](https://mariadb.com/kb/en/mariadb-columnstore/) engine.

[MariaDB](https://en.wikipedia.org/wiki/MariaDB) is a fork of the MySQL RDBMS, following its acquisition by Oracle.

# Get the Dataset

We will use the 3.3Gb access log dataset [from the optimisation session](https://github.com/TDADSBootcamp/Advanced-Bigger-Data).
Get the access log dataset from earlier session, and place the decompressed data at `uncommitted/access.log`.

# Setup MariaDB

[run_mariadb.sh](run_mariadb.sh) will start up a Docker container based on the latest MariaDB image with the columnstore plugin installed.

It will start the container attempt to grant user privileges. If unsuccessful (probably because the server is not yet ready for connections), it will pause for a few seconds and retry, in a loop.

# Connect to MariaDB

- The startup script will print a command to enter a bash shell within the container. Run it.
- You have the contents of this directory mounted at `/work`.
- You can explore the container, or run `mariadb` to start a SQL client connected to the database.

# Setup and query the InnoDB Table

Enter a bash shell on the container, if not already there.

- `mariadb -vvv < work/rdbms_oltp_vs_olap/innodb_access_log_load.sql` will load the dataset into an InnoDB table labelled `access_log_innodb` in a database `tda`. This operation may take a minute or so.
- `time mariadb --database tda < /work/rdbms_oltp_vs_olap/innodb_top_10_query.sql` will issue the top 10 clients by bytes query against the InnoDB table. This operation may take a couple of minutes.

# Setup and query the ColumnStore Table

Enter a bash shell on the container, if not already there.

- `mariadb -vvv < work/rdbms_oltp_vs_olap/columnstore_access_log_load.sql` will load the dataset into an InnoDB table labelled `access_log_columnstore` in a database `tda`. This operation may take a minute or so.
- `time mariadb --database tda < /work/rdbms_oltp_vs_olap/columnstore_top_10_query.sql` will issue the top 10 clients by bytes query against the ColumnStore table. This operation should take less than 10 seconds.

# Questions

- which was faster to run the query?
- why do you think that was?

# Cleanup

When you're finished with the server, use `docker ls` to find its name and `docker kill` it.






