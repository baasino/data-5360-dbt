{{ config(materialized='view') }}

with fact as (
    select * from {{ ref('fact_sales') }}
),
customer as (
    select * from {{ ref('oliver_dim_customer') }}
),
employee as (
    select * from {{ ref('oliver_dim_employee') }}
),
product as (
    select * from {{ ref('oliver_dim_product') }}
),
store as (
    select * from {{ ref('oliver_dim_store') }}
),
dim_date as (
    select * from {{ ref('oliver_dim_date') }}
)

select
    f.sales_key,
    f.order_id,
    f.date_key as sale_date,
    c.first_name || ' ' || c.last_name as customer_name,
    e.first_name || ' ' || e.last_name as employee_name,
    s.store_name,
    s.city as store_city,
    p.product_name,
    p.description as product_description,
    f.quantity,
    f.unit_price,
    f.total_sales_amount
from fact f
left join customer c on f.customer_key = c.customer_key
left join employee e on f.employee_key = e.employee_key
left join product p on f.product_key = p.product_key
left join store s on f.store_key = s.store_key
left join dim_date d on f.date_key = d.date_key