{{ config(materialized='table') }}

with date_spine as (
  select
    dateadd(day, seq4(), '2020-01-01'::date) as date_day
  from table(generator(rowcount => 3650))
)
select
    date_day as date_key,
    date_day as date_actual,
    year(date_day) as year,
    month(date_day) as month,
    monthname(date_day) as month_name,
    day(date_day) as day_of_month,
    dayofweek(date_day) as day_of_week,
    dayname(date_day) as day_name
from date_spine