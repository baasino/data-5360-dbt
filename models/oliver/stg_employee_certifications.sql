WITH source AS (
    SELECT * FROM {{ source('oliver_dw_source', 'EMPLOYEE_CERTIFICATIONS') }}
),

staged AS (
    SELECT
        employee_id,
        PARSE_JSON(certification_json):certification_name::VARCHAR AS certification_name,
        PARSE_JSON(certification_json):certification_cost::NUMBER AS certification_cost,
        PARSE_JSON(certification_json):certification_awarded_date::DATE AS certification_awarded_date
    FROM source
)

SELECT * FROM staged