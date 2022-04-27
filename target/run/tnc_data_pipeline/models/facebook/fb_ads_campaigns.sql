

  create or replace table `tnc-data-pipeline-347720`.`development`.`fb_ads_campaigns`
  
  
  OPTIONS()
  as (
    SELECT
account
,date_start date
,campaign_id
,campaign_name campaign
,campaign_advertising_channel_type
,channel
,platform
,sum(spend) cost
,sum(impressions) impressions
,sum(inline_link_clicks) clicks
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
  );
  