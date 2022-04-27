
SELECT
account
,date
,campaign_id
,campaign
,campaign_advertising_channel_type
,channel
,platform
,cost
,impressions
,clicks
FROM {{ ref('fb_ads_campaigns') }}


UNION ALL




SELECT
account
,date
,campaign_id
,campaign
,campaign_advertising_channel_type
,channel
,platform
,cost
,impressions
,clicks
FROM {{ ref('google_ads_campaigns') }}
