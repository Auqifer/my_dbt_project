WITH customer_orders AS (
    SELECT
        user_id,
        COUNT(order_id) AS total_orders,
        SUM(quantity) AS total_quantity,
        SUM(total_price) AS total_revenue,
        AVG(total_price) AS average_order_value
    FROM {{ ref('int_orders_enhanced') }}
    GROUP BY user_id
)
SELECT * FROM customer_orders