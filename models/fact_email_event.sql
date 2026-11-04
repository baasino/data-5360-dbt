SELECT 
    e.emaileventid AS event_id,
    c.customer_sk,
    e.campaignid AS campaign_bk,
    e.eventtype AS event_type, 
    e.eventtimestamp AS event_date
FROM {{ source('gdrive_ecoessentials', 'email_events') }} e
LEFT JOIN {{ ref('stg_marketing_users') }} mu 
  ON e.subscriberid = mu.source_user_id
LEFT JOIN {{ ref('dim_customer') }} c 
  ON mu.email = c.email 
  AND mu.first_name = c.first_name 
  AND mu.last_name = c.last_name