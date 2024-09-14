WITH cleaned_users AS (
    SELECT
        user_id,
        LOWER(user_name) AS user_name,
        email_address,
        PARSE_DATE('%Y-%m-%d', sign_up_date) AS sign_up_date,
        COALESCE(country, '{{ var("default_country") }}') AS country,
        CURRENT_TIMESTAMP() AS record_loaded_at
    FROM {{ ref('raw_users') }}
    WHERE email_address IS NOT NULL
    AND REGEXP_CONTAINS(email_address, r'^[\w\.-]+@[\w\.-]+\.\w+$')
)

SELECT DISTINCT *
FROM cleaned_users