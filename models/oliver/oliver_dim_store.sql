{{ config(materialized='table') }}

select
    store_id as store_key,
    store_id,
    store_name,
    street as address,
    city,
    state
from {{ source('oliver_dw_source', 'store') }}