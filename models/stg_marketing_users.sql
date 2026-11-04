SELECT DISTINCT
    subscriberid AS source_user_id,
    'marketing' AS source_system,
    subscriberfirstname AS first_name,
    subscriberlastname AS last_name,
    subscriberemail AS email
FROM {{ source('gdrive_ecoessentials', 'marketing_users') }}