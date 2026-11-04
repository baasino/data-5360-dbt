SELECT 
    product_id AS product_bk,
    product_name,
    product_type AS category,
    price
FROM {{ source('postgres_ecoessentials', 'products') }}