WITH certifications AS (
    SELECT * FROM {{ ref('stg_employee_certifications') }}
),

dim_employee AS (
    SELECT * FROM {{ ref('oliver_dim_employee') }}
),

dim_date AS (
    SELECT * FROM {{ ref('oliver_dim_date') }}
),

fact AS (
    SELECT
        d.date_key,
        e.employee_key,
        c.certification_name,
        c.certification_cost
    FROM certifications c
    -- Join to Employee Dim using the natural key
    LEFT JOIN dim_employee e 
        ON c.employee_id = e.employee_id
    -- Join to Date Dim using the awarded date 
    -- (Adjust 'date_id' below if your date dim uses a different column name for the actual date)
    LEFT JOIN dim_date d 
        ON c.certification_awarded_date = d.date_id
)

SELECT * FROM fact