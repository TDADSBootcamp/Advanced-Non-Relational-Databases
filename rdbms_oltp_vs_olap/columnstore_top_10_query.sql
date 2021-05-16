SELECT
    client_ip,
    SUM(bytes) total_bytes
FROM
    access_log_columnstore
GROUP BY
    client_ip
ORDER BY
    total_bytes DESC
LIMIT 10;