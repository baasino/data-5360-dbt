{{ config(materialized='table') }}

select
    product_id as product_key,
    product_id,
    product_name,
    description,
    unit_price as price
from {{ source('oliver_dw_source', 'product') }}