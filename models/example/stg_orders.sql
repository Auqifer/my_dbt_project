WITH cleaned_orders AS (
    SELECT
        order_id,
        user_id,
        product_id,
        PARSE_DATE('%Y-%m-%d', order_date) AS order_date,
        CAST(REGEXP_REPLACE(CAST(quantity AS STRING), r'[^0-9]', '') AS INT64) AS quantity,
        CAST(REGEXP_REPLACE(CAST(price AS STRING), r'[^0-9.]', '') AS FLOAT64) AS price
    FROM {{ ref('raw_orders') }}
    WHERE CAST(REGEXP_REPLACE(CAST(quantity AS STRING), r'[^0-9]', '') AS INT64) > 0
    AND CAST(REGEXP_REPLACE(CAST(price AS STRING), r'[^0-9.]', '') AS FLOAT64) > 0
)

SELECT *
FROM cleaned_orders