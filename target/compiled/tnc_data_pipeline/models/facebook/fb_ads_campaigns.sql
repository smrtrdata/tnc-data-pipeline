SELECT
account
,date
,campaign_id
,campaign
,campaign_advertising_channel_type
,channel
,platform
,sum(cost) cost
,sum(impressions) impressions
,sum(clicks) clicks
FROM `tnc-data-pipeline-347720`.`development`.`fb_ads_insights`

##where lv = _sdc_sequence
GROUP BY 
account
,date
,campaign_id
,campaign
,channel
,platform
,campaign_advertising_channel_type