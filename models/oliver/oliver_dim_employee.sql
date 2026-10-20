{{ config(materialized='table') }}

select
    employee_id as employee_key,
    employee_id,
    first_name,
    last_name,
    position,
    email,
    phone_number as phone,
    hire_date
from {{ source('oliver_dw_source', 'employee') }}