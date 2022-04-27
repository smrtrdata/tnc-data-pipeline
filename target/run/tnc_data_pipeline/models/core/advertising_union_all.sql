

  create or replace table `tnc-data-pipeline-347720`.`development`.`advertising_union_all`
  
  
  OPTIONS()
  as (
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
FROM `tnc-data-pipeline-347720`.`development`.`google_ads_campaigns`
  );
  