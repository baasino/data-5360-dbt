SELECT 
    campaign_id AS campaign_bk,
    campaign_name,
    campaign_discount
FROM {{ source('postgres_ecoessentials', 'campaigns') }}