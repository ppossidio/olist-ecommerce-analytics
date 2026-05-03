CREATE TABLE stg_customers (
    customer_id VARCHAR(50) NOT NULL,
    customer_unique_id VARCHAR(50) NOT NULL,
    customer_zip_code_prefix INT,
    customer_city VARCHAR(100),
    customer_state CHAR(2),
    PRIMARY KEY (customer_id)
);

CREATE TABLE stg_sellers (
    seller_id VARCHAR(50) NOT NULL,
    seller_zip_code_prefix INT,
    seller_city VARCHAR(100),
    seller_state CHAR(2),
    PRIMARY KEY (seller_id)
);

CREATE TABLE stg_geolocation (
    geolocation_zip_code_prefix INT NOT NULL,
    geolocation_lat DECIMAL(12,8),
    geolocation_lng DECIMAL(12,8),
    geolocation_city VARCHAR(100),
    geolocation_state CHAR(2),
    PRIMARY KEY (geolocation_zip_code_prefix)
);

CREATE TABLE stg_products (
    product_id VARCHAR(50) NOT NULL,
    product_category_name VARCHAR(100),
    product_name_length DECIMAL(10,2),
    product_description_length DECIMAL(10,2),
    product_photos_qty DECIMAL(10,2),
    product_weight_g DECIMAL(10,2),
    product_length_cm DECIMAL(10,2),
    product_height_cm DECIMAL(10,2),
    product_width_cm DECIMAL(10,2),
    product_category_name_english VARCHAR(150),
    product_volume_cm3 DECIMAL(15,2),
    has_missing_product_dimension BOOLEAN,
    PRIMARY KEY (product_id)
);

CREATE TABLE stg_orders (
    order_id VARCHAR(50) NOT NULL,
    customer_id VARCHAR(50) NOT NULL,
    order_status VARCHAR(30),
    order_purchase_timestamp DATETIME,
    order_approved_at DATETIME,
    order_delivered_carrier_date DATETIME,
    order_delivered_customer_date DATETIME,
    order_estimated_delivery_date DATETIME,
    order_purchase_date DATE,
    order_year INT,
    order_month INT,
    order_year_month VARCHAR(7),
    is_delivered BOOLEAN,
    is_canceled BOOLEAN,
    approval_time_hours DECIMAL(10,2),
    delivery_time_days DECIMAL(10,2),
    estimated_delivery_time_days DECIMAL(10,2),
    delivery_delay_days DECIMAL(10,2),
    delivery_status VARCHAR(30),
    is_late DECIMAL(3,1),
    PRIMARY KEY (order_id),
    CONSTRAINT fk_orders_customers
        FOREIGN KEY (customer_id)
        REFERENCES stg_customers(customer_id)
);

CREATE TABLE stg_order_items (
    order_id VARCHAR(50) NOT NULL,
    order_item_id INT NOT NULL,
    product_id VARCHAR(50) NOT NULL,
    seller_id VARCHAR(50) NOT NULL,
    shipping_limit_date DATETIME,
    price DECIMAL(12,2),
    freight_value DECIMAL(12,2),
    item_total_value DECIMAL(12,2),
    item_count INT,
    PRIMARY KEY (order_id, order_item_id),
    CONSTRAINT fk_items_orders
        FOREIGN KEY (order_id)
        REFERENCES stg_orders(order_id),
    CONSTRAINT fk_items_products
        FOREIGN KEY (product_id)
        REFERENCES stg_products(product_id),
    CONSTRAINT fk_items_sellers
        FOREIGN KEY (seller_id)
        REFERENCES stg_sellers(seller_id)
);

CREATE TABLE stg_payments (
    order_id VARCHAR(50) NOT NULL,
    payment_sequential INT NOT NULL,
    payment_type VARCHAR(30),
    payment_installments INT,
    payment_value DECIMAL(12,2),
    payment_installment_group VARCHAR(30),
    PRIMARY KEY (order_id, payment_sequential),
    CONSTRAINT fk_payments_orders
        FOREIGN KEY (order_id)
        REFERENCES stg_orders(order_id)
);

CREATE TABLE stg_reviews (
    review_key INT NOT NULL,
    review_id VARCHAR(50),
    order_id VARCHAR(50) NOT NULL,
    review_score INT,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date DATETIME,
    review_answer_timestamp DATETIME,
    has_review_comment BOOLEAN,
    review_response_time_days DECIMAL(10,2),
    PRIMARY KEY (review_key),
    CONSTRAINT fk_reviews_orders
        FOREIGN KEY (order_id)
        REFERENCES stg_orders(order_id)
);