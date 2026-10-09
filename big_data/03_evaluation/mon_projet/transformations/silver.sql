-- Fichier: transformations/silver.sql
-- Nettoyage de bronze_products -> silver_products

CREATE OR REPLACE TABLE `lasalle-big-data.examen_lucas.silver_products` AS
SELECT
  SAFE_CAST(product_id AS INT64)                 AS product_id,
  name,
  category,
  SAFE_CAST(NULLIF(cost, 'NULL') AS FLOAT64)     AS cout,
  retail_price,
  is_active,
  SAFE_CAST(added_date AS DATE)                  AS added_date
FROM `lasalle-big-data.examen_lucas.bronze_products`;