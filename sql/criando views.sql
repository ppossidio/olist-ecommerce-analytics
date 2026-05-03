### View de itens enriquecidos

CREATE OR REPLACE VIEW vw_order_items_enriched AS
SELECT
    oi.order_id,
    oi.order_item_id,
    oi.product_id,
    p.product_category_name,
    p.product_category_name_english,
    p.product_weight_g,
    p.product_volume_cm3,
    p.has_missing_product_dimension,
    oi.seller_id,
    s.seller_city,
    s.seller_state,
    o.customer_id,
    c.customer_unique_id,
    c.customer_city,
    c.customer_state,
    o.order_status,
    o.order_purchase_timestamp,
    o.order_purchase_date,
    o.order_year,
    o.order_month,
    o.order_year_month,
    o.delivery_time_days,
    o.delivery_delay_days,
    o.delivery_status,
    o.is_late,
    oi.shipping_limit_date,
    oi.price,
    oi.freight_value,
    oi.item_total_value,
    oi.item_count
FROM stg_order_items oi
INNER JOIN stg_orders o
    ON oi.order_id = o.order_id
INNER JOIN stg_products p
    ON oi.product_id = p.product_id
INNER JOIN stg_sellers s
    ON oi.seller_id = s.seller_id
INNER JOIN stg_customers c
    ON o.customer_id = c.customer_id;
    
### View de pagamentos por pedido

CREATE OR REPLACE VIEW vw_payments_by_order AS
SELECT
    order_id,
    COUNT(*) AS payment_rows,
    COUNT(DISTINCT payment_type) AS distinct_payment_types,
    MAX(payment_installments) AS max_installments,
    ROUND(SUM(payment_value), 2) AS total_payment_value,
    CASE
        WHEN COUNT(DISTINCT payment_type) > 1 THEN 'multiple'
        ELSE MAX(payment_type)
    END AS main_payment_type
FROM stg_payments
GROUP BY order_id;

### View de reviews por pedido

CREATE OR REPLACE VIEW vw_reviews_by_order AS
SELECT
    order_id,
    COUNT(*) AS review_rows,
    ROUND(AVG(review_score), 2) AS avg_review_score,
    MIN(review_score) AS min_review_score,
    MAX(review_score) AS max_review_score,
    MAX(has_review_comment) AS has_review_comment,
    ROUND(AVG(review_response_time_days), 2) AS avg_review_response_time_days
FROM stg_reviews
GROUP BY order_id;

### View de pedidos enriquecidos

CREATE OR REPLACE VIEW vw_orders_enriched AS
SELECT
    o.order_id,
    o.customer_id,
    c.customer_unique_id,
    c.customer_city,
    c.customer_state,
    o.order_status,
    o.order_purchase_timestamp,
    o.order_purchase_date,
    o.order_year,
    o.order_month,
    o.order_year_month,
    o.is_delivered,
    o.is_canceled,
    o.approval_time_hours,
    o.delivery_time_days,
    o.estimated_delivery_time_days,
    o.delivery_delay_days,
    o.delivery_status,
    o.is_late,
    p.payment_rows,
    p.distinct_payment_types,
    p.max_installments,
    p.total_payment_value,
    p.main_payment_type,
    r.review_rows,
    r.avg_review_score,
    r.min_review_score,
    r.max_review_score,
    r.has_review_comment,
    r.avg_review_response_time_days
FROM stg_orders o
INNER JOIN stg_customers c
    ON o.customer_id = c.customer_id
LEFT JOIN vw_payments_by_order p
    ON o.order_id = p.order_id
LEFT JOIN vw_reviews_by_order r
    ON o.order_id = r.order_id;
    

## Validando as views

SELECT 'vw_order_items_enriched' AS view_name, COUNT(*) AS rows_count 
FROM vw_order_items_enriched

UNION ALL

SELECT 'vw_payments_by_order', COUNT(*) 
FROM vw_payments_by_order

UNION ALL

SELECT 'vw_reviews_by_order', COUNT(*) 
FROM vw_reviews_by_order

UNION ALL

SELECT 'vw_orders_enriched', COUNT(*) 
FROM vw_orders_enriched;


## teste vendas por mes pela viwe

SELECT
    order_year_month,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(item_count) AS total_items,
    ROUND(SUM(price), 2) AS product_revenue,
    ROUND(SUM(freight_value), 2) AS freight_revenue,
    ROUND(SUM(item_total_value), 2) AS total_revenue
FROM vw_order_items_enriched
WHERE order_status = 'delivered'
GROUP BY order_year_month
ORDER BY order_year_month;