CREATE DATABASE IF NOT EXISTS assignment_db;
CREATE SCHEMA IF NOT EXISTS assignment_db.features;

CREATE OR REPLACE TABLE assignment_db.features.raw_orders AS
SELECT *
FROM SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.ORDERS;

-- SELECT * FROM assignment_db.features.raw_orders
-- LIMIT 10;

-- DESCRIBE TABLE assignment_db.features.raw_orders;

-- SELECT
--   COUNT(*) AS total_orders,
--   MIN(O_TOTALPRICE) AS min_price,
--   MAX(O_TOTALPRICE) AS max_price,
--   AVG(O_TOTALPRICE) AS avg_price,
--   MEDIAN(O_TOTALPRICE) AS median_price
-- FROM assignment_db.features.raw_orders;

CREATE OR REPLACE TABLE assignment_db.features.engineered_orders AS
SELECT
  O_ORDERKEY,
  O_CUSTKEY,
  O_TOTALPRICE,
  O_ORDERDATE,
  EXTRACT(MONTH FROM O_ORDERDATE) AS MONTH,
  EXTRACT(DAYOFWEEK FROM O_ORDERDATE) AS DAY_OF_WEEK,
  CASE WHEN O_TOTALPRICE > 100000 THEN 1 ELSE 0 END AS IS_LARGE_ORDER,
  (O_TOTALPRICE - AVG(O_TOTALPRICE) OVER()) / NULLIF(STDDEV_POP(O_TOTALPRICE) OVER(),0) AS TOTALPRICE_ZSCORE
FROM assignment_db.features.raw_orders;

SELECT COUNT(*) AS total_rows FROM assignment_db.features.engineered_orders;
SELECT IS_LARGE_ORDER, COUNT(*) FROM assignment_db.features.engineered_orders GROUP BY IS_LARGE_ORDER;
SELECT O_ORDERKEY, O_TOTALPRICE, MONTH, DAY_OF_WEEK, IS_LARGE_ORDER, TOTALPRICE_ZSCORE
FROM assignment_db.features.engineered_orders
LIMIT 20;

CREATE OR REPLACE TABLE assignment_db.features.order_features AS
SELECT *
FROM assignment_db.features.engineered_orders;

SHOW TABLES IN SCHEMA assignment_db.features;

CREATE OR REPLACE TABLE assignment_db.features.predictions_rule AS
SELECT
  O_ORDERKEY,
  O_TOTALPRICE,
  MONTH,
  DAY_OF_WEEK,
  IS_LARGE_ORDER AS TRUE_LABEL,
  CASE WHEN O_TOTALPRICE > 100000 THEN 1 ELSE 0 END AS PREDICTION_THRESHOLD_ONLY,
  CASE WHEN TOTALPRICE_ZSCORE > 1 OR O_TOTALPRICE > 90000 THEN 1 ELSE 0 END AS PREDICTION_HEURISTIC
FROM assignment_db.features.order_features;



  
FROM eval
GROUP BY model;

SELECT * FROM assignment_db.features.predictions_rule LIMIT 20;

SELECT *
FROM assignment_db.features.order_features
LIMIT 20;


