SELECT 
    customer_id AS source_user_id,
    'sales' AS source_system,
    customer_first_name AS first_name,
    customer_last_name AS last_name,
    customer_email AS email
FROM {{ source('postgres_ecoessentials', 'users') }}