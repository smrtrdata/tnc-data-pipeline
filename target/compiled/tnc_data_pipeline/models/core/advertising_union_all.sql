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
,cost as fb_cost
,impressions as fb_impressions
,clicks as fb_clicks
,0 as google_ads_cost
,0 as google_ads_impressions
,0 as google_ads_clicks
FROM `tnc-data-pipeline-347720`.`development`.`fb_ads_campaigns`


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
,cost as google_ads_cost
,impressions as google_ads_impressions
,clicks as google_ads_clicks
,0 as fb_cost
,0 as fb_impressions
,0 as fb_clicks
FROM `tnc-data-pipeline-347720`.`development`.`google_ads_campaigns`