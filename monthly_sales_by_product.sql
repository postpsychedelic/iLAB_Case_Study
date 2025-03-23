WITH orders_with_month AS (
    SELECT 
        t1.order_id,
        t1.customer_id,
        t1.product_id,
        EXTRACT(YEAR FROM t1.order_date) AS order_year,
        EXTRACT(MONTH FROM t1.order_date) AS order_month,
        t1.total_amount
    FROM 
        {{ ref('orders') }} t1
),

product_sales AS (
    SELECT
        t2.order_year,
        t2.order_month,
        t2.product_id,
        COUNT(t2.order_id) AS total_orders,
        SUM(t2.total_amount) AS total_sales
    FROM
        orders_with_month t2
    GROUP BY
        t2.order_year,
        t2.order_month,
        t2.product_id
)

SELECT
    t3.order_year,
    t3.order_month,
    t3.product_id,
    t3.total_orders,
    t3.total_sales,
    t4.product_category,
    t4.product_price
FROM
    product_sales t3
JOIN
    {{ ref('products') }} t4 ON t3.product_id = t4.product_id
ORDER BY
    t3.order_year,
    t3.order_month,
    t3.product_id;
