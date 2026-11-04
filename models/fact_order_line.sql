WITH order_data AS (
    SELECT 
        oi.order_id,
        oi.product_id,
        o.customer_id,
        o.order_timestamp AS order_date,
        oi.quantity,
        oi.price_after_discount AS line_price,
        (oi.quantity * oi.price_after_discount) AS total_amount
    FROM {{ source('postgres_ecoessentials', 'order_items') }} oi
    JOIN {{ source('postgres_ecoessentials', 'orders') }} o 
      ON oi.order_id = o.order_id
)

SELECT 
    {{ dbt_utils.generate_surrogate_key(['od.order_id', 'od.product_id']) }} AS order_line_sk,
    c.customer_sk,
    od.product_id AS product_bk,
    od.order_id AS order_bk,
    od.order_date,
    od.quantity,
    od.line_price,
    od.total_amount
FROM order_data od
LEFT JOIN {{ ref('stg_sales_users') }} su 
  ON od.customer_id = su.source_user_id
LEFT JOIN {{ ref('dim_customer') }} c 
  ON su.email = c.email 
  AND su.first_name = c.first_name 
  AND su.last_name = c.last_name