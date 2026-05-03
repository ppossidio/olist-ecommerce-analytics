CREATE OR REPLACE VIEW dim_customers AS
SELECT
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state
FROM stg_customers;

CREATE OR REPLACE VIEW dim_sellers AS
SELECT
    seller_id,
    seller_zip_code_prefix,
    seller_city,
    seller_state
FROM stg_sellers;

CREATE OR REPLACE VIEW dim_products AS
SELECT
    product_id,
    product_category_name,
    product_category_name_english,
    product_name_length,
    product_description_length,
    product_photos_qty,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm,
    product_volume_cm3,
    has_missing_product_dimension
FROM stg_products;

CREATE OR REPLACE VIEW fact_orders AS
SELECT
    order_id,
    customer_id,
    order_status,
    order_purchase_timestamp,
    order_approved_at,
    order_delivered_carrier_date,
    order_delivered_customer_date,
    order_estimated_delivery_date,
    order_purchase_date,
    order_year,
    order_month,
    order_year_month,
    is_delivered,
    is_canceled,
    approval_time_hours,
    delivery_time_days,
    estimated_delivery_time_days,
    delivery_delay_days,
    delivery_status,
    is_late
FROM stg_orders;

CREATE OR REPLACE VIEW fact_order_items AS
SELECT
    order_id,
    order_item_id,
    product_id,
    seller_id,
    shipping_limit_date,
    price,
    freight_value,
    item_total_value,
    item_count
FROM stg_order_items;

CREATE OR REPLACE VIEW fact_payments_by_order AS
SELECT
    order_id,
    payment_rows,
    distinct_payment_types,
    max_installments,
    total_payment_value,
    main_payment_type
FROM vw_payments_by_order;

CREATE OR REPLACE VIEW fact_reviews_by_order AS
SELECT
    order_id,
    review_rows,
    avg_review_score,
    min_review_score,
    max_review_score,
    has_review_comment,
    avg_review_response_time_days
FROM vw_reviews_by_order;

## validando

SELECT 'dim_customers' AS table_name, COUNT(*) AS rows_count FROM dim_customers
UNION ALL
SELECT 'dim_sellers', COUNT(*) FROM dim_sellers
UNION ALL
SELECT 'dim_products', COUNT(*) FROM dim_products
UNION ALL
SELECT 'fact_orders', COUNT(*) FROM fact_orders
UNION ALL
SELECT 'fact_order_items', COUNT(*) FROM fact_order_items
UNION ALL
SELECT 'fact_payments_by_order', COUNT(*) FROM fact_payments_by_order
UNION ALL
SELECT 'fact_reviews_by_order', COUNT(*) FROM fact_reviews_by_order;
