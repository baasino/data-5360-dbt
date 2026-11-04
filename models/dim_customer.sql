WITH combined_users AS (
    SELECT * FROM {{ ref('stg_sales_users') }}
    UNION ALL
    SELECT * FROM {{ ref('stg_marketing_users') }}
)
SELECT 
    {{ dbt_utils.generate_surrogate_key(['first_name', 'last_name', 'email']) }} as customer_sk,
    first_name,
    last_name,
    email
FROM combined_users
GROUP BY 1, 2, 3, 4