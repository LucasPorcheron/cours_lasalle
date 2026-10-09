-- Fichier: transformations/silver.sql
-- Nettoyage de bronze_products -> silver_products
CREATE OR REPLACE TABLE `lasalle-big-data.examen_lucas.silver_products` AS
SELECT
  SAFE_CAST(product_id AS INT64)                 AS product_id,  -- changement de type :texte -> entier
  name,                                                          -- déjà propre
  INITCAP(category)                        AS category,    -- uniformise la casse
  SAFE_CAST(NULLIF(cost, 'NULL') AS FLOAT64)     AS cout,        -- remplace le texte 'NULL' par un vrai NULL, puis texte -> nombre
  retail_price,                                                  -- déjà en FLOAT
  is_active,                                                     -- déjà en BOOLEAN
  SAFE_CAST(added_date AS DATE)                  AS added_date   -- changement de type texte -> date
FROM `lasalle-big-data.examen_lucas.bronze_products`;