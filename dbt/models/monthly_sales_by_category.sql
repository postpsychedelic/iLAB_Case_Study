-- models/monthly_sales_by_category.sql

WITH category_performance AS (
    SELECT
        a1.order_year,
        a1.order_month,
        a2.product_category,
        COUNT(a1.product_id) AS total_orders,  
        SUM(a1.total_sales) AS total_sales  
    FROM
        {{ ref('monthly_sales_by_product') }} a1
    JOIN
        {{ ref('products') }} a2 ON a1.product_id = a2.product_id 
    GROUP BY
        a1.order_year,
        a1.order_month,
        a2.product_category  
)

SELECT
    a3.order_year,
    a3.order_month,
    a3.product_category,
    a3.total_orders,
    a3.total_sales
FROM
    category_performance a3
ORDER BY
    a3.order_year,
    a3.order_month,
a3.product_category;