{{ config(materialized='table') }}

select
    customer_id as customer_key,
    customer_id,
    first_name,
    last_name,
    email,
    phone_number as phone
from {{ source('oliver_dw_source', 'customer') }}