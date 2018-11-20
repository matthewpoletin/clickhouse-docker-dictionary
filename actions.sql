-- Create database
DROP DATABASE IF EXISTS test;
CREATE DATABASE IF NOT EXISTS test;

-- Create first table
DROP TABLE IF EXISTS test.first;
CREATE TABLE IF NOT EXISTS test.first
(
  id        UInt64,
  timestamp DateTime,
  name      String
)
  ENGINE = MergeTree()
    PARTITION BY toYYYYMMDDhhmmss(timestamp)
    ORDER BY (timestamp)
    SETTINGS index_granularity = 8192;

-- Insert values in first table
INSERT INTO test.first (id, timestamp, name)
VALUES (1, 1, 'A'),
       (2, 2, 'B');

-- Dictionary Join SELECT
SELECT id, timestamp, name, dictGetString('second', 'second_name', toUInt64(id)) code
FROM test.first ALL
       LEFT JOIN system.dictionaries.second USING (id);
