
-- Fichier: transformations/gold.sql
-- Agrégation par catégorie : silver_products -> gold_category_metrics
CREATE OR REPLACE TABLE `lasalle-big-data.examen_lucas.gold_category_metrics` AS
SELECT
  category,
  COUNT(*) AS total_products, -- nombre total de produits
  ROUND(AVG(retail_price), 2) AS prix_moyen, -- prix de vente moyen, arrondi à 2 décimales
  ROUND(AVG(retail_price - cout), 2) AS marge_moyenne -- marge unitaire moyenne,  arrondi à 2 décimales
FROM `lasalle-big-data.examen_lucas.silver_products`
GROUP BY category
ORDER BY marge_moyenne DESC; -- catégories les plus rentables en premier