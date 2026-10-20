{{ config(materialized='table') }}

with orders as (
    select * from {{ source('oliver_dw_source', 'orders') }}
),
orderline as (
    select * from {{ source('oliver_dw_source', 'orderline') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['o.order_id', 'ol.order_line_id']) }} as sales_key,
    o.order_id,
    ol.order_line_id,
    o.customer_id as customer_key,
    o.employee_id as employee_key,
    o.store_id as store_key,
    ol.product_id as product_key,
    date_trunc('day', o.order_date)::date as date_key,
    ol.quantity,
    ol.unit_price,
    (ol.quantity * ol.unit_price) as total_sales_amount
from orders o
join orderline ol on o.order_id = ol.order_id