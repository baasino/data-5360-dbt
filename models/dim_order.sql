SELECT 
    order_id AS order_bk,
    order_timestamp AS order_date
FROM {{ source('postgres_ecoessentials', 'orders') }}