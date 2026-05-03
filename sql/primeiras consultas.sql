#### Validar chaves primárias

SELECT 
    'stg_customers' AS table_name,
    COUNT(*) AS total_rows,
    COUNT(DISTINCT customer_id) AS distinct_keys,
    COUNT(*) - COUNT(DISTINCT customer_id) AS duplicated_keys
FROM stg_customers

UNION ALL

SELECT 
    'stg_sellers',
    COUNT(*),
    COUNT(DISTINCT seller_id),
    COUNT(*) - COUNT(DISTINCT seller_id)
FROM stg_sellers

UNION ALL

SELECT 
    'stg_products',
    COUNT(*),
    COUNT(DISTINCT product_id),
    COUNT(*) - COUNT(DISTINCT product_id)
FROM stg_products

UNION ALL

SELECT 
    'stg_geolocation',
    COUNT(*),
    COUNT(DISTINCT geolocation_zip_code_prefix),
    COUNT(*) - COUNT(DISTINCT geolocation_zip_code_prefix)
FROM stg_geolocation

UNION ALL

SELECT 
    'stg_orders',
    COUNT(*),
    COUNT(DISTINCT order_id),
    COUNT(*) - COUNT(DISTINCT order_id)
FROM stg_orders;

#### Validar chaves compostas

SELECT 
    'stg_customers' AS table_name,
    COUNT(*) AS total_rows,
    COUNT(DISTINCT customer_id) AS distinct_keys,
    COUNT(*) - COUNT(DISTINCT customer_id) AS duplicated_keys
FROM stg_customers

UNION ALL

SELECT 
    'stg_sellers',
    COUNT(*),
    COUNT(DISTINCT seller_id),
    COUNT(*) - COUNT(DISTINCT seller_id)
FROM stg_sellers

UNION ALL

SELECT 
    'stg_products',
    COUNT(*),
    COUNT(DISTINCT product_id),
    COUNT(*) - COUNT(DISTINCT product_id)
FROM stg_products

UNION ALL

SELECT 
    'stg_geolocation',
    COUNT(*),
    COUNT(DISTINCT geolocation_zip_code_prefix),
    COUNT(*) - COUNT(DISTINCT geolocation_zip_code_prefix)
FROM stg_geolocation

UNION ALL

SELECT 
    'stg_orders',
    COUNT(*),
    COUNT(DISTINCT order_id),
    COUNT(*) - COUNT(DISTINCT order_id)
FROM stg_orders;

### Pedidos sem cliente correspondente

SELECT 
    COUNT(*) AS orders_without_customer
FROM stg_orders o
LEFT JOIN stg_customers c
    ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

### Itens sem pedido correspondente

SELECT
	COUNT(*) AS items_without_order
FROM stg_order_items oi
LEFT JOIN stg_orders o
	ON 	o.order_id = oi.order_id
WHERE o.order_id IS NULL;

### Itens sem produto correspondente

SELECT
	COUNT(*) AS items_without_product
FROM stg_order_items oi
LEFT JOIN stg_products p
	ON 	p.product_id = oi.product_id
WHERE p.product_id IS NULL;

### Itens sem vendedor correspondente

SELECT
	COUNT(*) AS items_without_seller
FROM stg_order_items oi
LEFT JOIN stg_sellers s
	ON 	s.seller_id = oi.seller_id
WHERE s.seller_id IS NULL;

### Pagamentos sem pedido correspondente

SELECT
	COUNT(*) AS payments_without_order
FROM stg_payments p
LEFT JOIN stg_orders o
	ON p.order_id = o.order_id
WHERE p.order_id IS NULL;

### Reviews sem pedido correspondente

SELECT
	COUNT(*) AS reviews_without_order
FROM stg_reviews r
LEFT JOIN stg_orders o
	ON r.order_id = o.order_id
WHERE r.order_id IS NULL;

### Distribuição de pedidos por status

SELECT
	order_status,
    COUNT(*) AS total_orders,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS percentage
FROM stg_orders
GROUP BY order_status
ORDER BY total_orders DESC;

### Receita geral dos itens

SELECT
    COUNT(*) AS total_items,
    COUNT(DISTINCT order_id) AS total_orders_with_items,
    ROUND(SUM(price), 2) AS product_revenue,
    ROUND(SUM(freight_value), 2) AS freight_revenue,
    ROUND(SUM(item_total_value), 2) AS total_item_value
FROM stg_order_items;
	
## Receita apenas de pedidos entregues

SELECT
    COUNT(*) AS total_items,
    COUNT(DISTINCT oi.order_id) AS delivered_orders_with_items,
    ROUND(SUM(oi.price), 2) AS delivered_product_revenue,
    ROUND(SUM(oi.freight_value), 2) AS delivered_freight_revenue,
    ROUND(SUM(oi.item_total_value), 2) AS delivered_total_item_value
FROM stg_order_items oi
INNER JOIN stg_orders o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'delivered';

### Total pago com base em payments

SELECT
    COUNT(*) AS total_payment_rows,
    COUNT(DISTINCT order_id) AS total_orders_with_payment,
    ROUND(SUM(payment_value), 2) AS total_payment_value
FROM stg_payments;

### Comparar valor dos itens com valor pago

WITH items_by_order AS (
    SELECT
        order_id,
        ROUND(SUM(item_total_value), 2) AS order_items_total
    FROM stg_order_items
    GROUP BY order_id
),

payments_by_order AS (
    SELECT
        order_id,
        ROUND(SUM(payment_value), 2) AS order_payment_total
    FROM stg_payments
    GROUP BY order_id
)

SELECT
    COUNT(*) AS total_orders_compared,
    ROUND(SUM(i.order_items_total), 2) AS total_items_value,
    ROUND(SUM(p.order_payment_total), 2) AS total_payment_value,
    ROUND(SUM(p.order_payment_total - i.order_items_total), 2) AS total_difference
FROM items_by_order i
INNER JOIN payments_by_order p
    ON i.order_id = p.order_id;
    
### Receita por mês

SELECT
    o.order_year_month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price), 2) AS product_revenue,
    ROUND(SUM(oi.freight_value), 2) AS freight_revenue,
    ROUND(SUM(oi.item_total_value), 2) AS total_revenue
FROM stg_order_items oi
INNER JOIN stg_orders o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'delivered'
GROUP BY o.order_year_month
ORDER BY o.order_year_month;

### Top categorias por receita

SELECT
    p.product_category_name_english,
    COUNT(DISTINCT oi.order_id) AS total_orders,
    COUNT(*) AS total_items,
    ROUND(SUM(oi.price), 2) AS product_revenue,
    ROUND(SUM(oi.freight_value), 2) AS freight_revenue,
    ROUND(SUM(oi.item_total_value), 2) AS total_revenue
FROM stg_order_items oi
INNER JOIN stg_orders o
    ON oi.order_id = o.order_id
INNER JOIN stg_products p
    ON oi.product_id = p.product_id
WHERE o.order_status = 'delivered'
GROUP BY p.product_category_name_english
ORDER BY product_revenue DESC
LIMIT 10;