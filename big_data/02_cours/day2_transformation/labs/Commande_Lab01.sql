#DAY 2 LAB 1
#LAB 1 Fondation de l'architecture Medallion
#Etape 2

#Partie Orders
CREATE OR REPLACE TABLE `thelook_lucas.bronze_orders` AS
SELECT 
    *
FROM `bigquery-public-data.thelook_ecommerce.orders` ;

#Partie Order_itemse
CREATE OR REPLACE TABLE `thelook_lucas.bronze_order_items` AS
SELECT 
    *
FROM `bigquery-public-data.thelook_ecommerce.order_items` ;

#Etape 3 

CREATE OR REPLACE TABLE `thelook_lucas.bronze_raw_orders_items` AS
SELECT 
    o.order_id,
    o.user_id,
    o.created_at,
    o.status,
    oi.id AS order_item_id,
    oi.product_id,
    oi.sale_price
FROM `bigquery-public-data.thelook_ecommerce.order_items` AS oi
JOIN `thelook_lucas.bronze_orders` AS o ON o.order_id = oi.order_id ;



#PARTIE 1
CREATE OR REPLACE TABLE `thelook_lucas.silver_clean_orders_items` AS
SELECT 
    order_id,
    DATE (created_at) AS date_propre,
    status, 
    order_item_id,
    product_id,
    COALESCE(sale_price,0) AS sale_price

  #FAIRE DES alias
FROM `thelook_lucas.bronze_raw_orders_items` 
WHERE status = 'Complete' OR status = 'Shipped' AND sale_price > 1 ;

#PARTIE 2
CREATE OR REPLACE VIEW `thelook_lucas.silver_v_high_value_items` AS
SELECT
    date_propre,
    status,
    order_item_id,
    product_id
FROM `lasalle-big-data.thelook_lucas.silver_clean_orders_items` 
WHERE sale_price > 100 ;

#Afficher la vue 
SELECT * FROM `thelook_lucas.silver_v_high_value_items` ;

#PARTIE 3
CREATE OR REPLACE TABLE `thelook_lucas.gold_daily_revenue` AS
SELECT
    SUM(sale_price) AS total_revenue,
    COUNT(order_item_id) AS items_sold,
    date_propre
FROM `thelook_lucas.silver_clean_orders_items` 
GROUP BY date_propre 
ORDER BY date_propre DESC;

#Afficher la table




