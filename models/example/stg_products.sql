WITH cleaned_products AS (
    SELECT
        product_id,
        LOWER(TRIM(product_name)) AS product_name,
        LOWER(TRIM(category)) AS category,
        price,
        ROW_NUMBER() OVER (PARTITION BY product_id ORDER BY product_id) AS row_num
    FROM {{ ref('raw_products') }}
)

-- Select only one row per product_id (row_num = 1 ensures we only take the first occurrence)
SELECT product_id, product_name, category, price
FROM cleaned_products
WHERE row_num = 1