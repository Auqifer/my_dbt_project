WITH product_sales AS (
    SELECT
        p.product_id,
        p.product_name,
        p.category,
        SUM(o.quantity) AS total_quantity_sold,
        SUM(o.total_price) AS total_revenue_generated,
        AVG(o.price) AS average_price
    FROM {{ ref('int_orders_enhanced') }} AS o
    JOIN {{ ref('stg_products') }} AS p
    ON o.product_id = p.product_id
    GROUP BY p.product_id, p.product_name, p.category
)
SELECT * FROM product_sales