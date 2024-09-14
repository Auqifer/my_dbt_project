WITH enriched_orders AS (
    SELECT
        o.order_id,
        o.user_id,
        o.product_id,
        o.order_date,
        o.quantity,
        o.price,
        o.quantity * o.price AS total_price,
        u.sign_up_date,
        DATE_DIFF(o.order_date, u.sign_up_date, DAY) AS days_since_signup
    FROM {{ ref('stg_orders') }} AS o
    LEFT JOIN {{ ref('stg_users') }} AS u
    ON o.user_id = u.user_id
    LEFT JOIN {{ ref('stg_products') }} AS p
    ON o.product_id = p.product_id
)
SELECT *
FROM enriched_orders
WHERE days_since_signup >= 0