

  create or replace table `tnc-data-pipeline-347720`.`development`.`google_ads_campaigns`
  
  
  OPTIONS()
  as (
    





SELECT
date
,campaign_id
,campaign_name
,campaign_advertising_channel_type
,channel
,platform
,sum(cost) cost
,sum(impressions) impressions
,sum(clicks) clicks
FROM
( 

	SELECT  
	"google_ads_thenursecoaches" as account
	,'Paid' as channel
	,'Adwords' as platform
	,date
	,campaign_id
	,campaign_name
	,campaign_advertising_channel_type
	,cost_micros/1000000 cost
	,impressions
	,clicks
	,_sdc_sequence
	,first_value(_sdc_sequence) OVER (PARTITION BY campaign_id, date ORDER BY _sdc_sequence DESC) lv
	FROM `tnc-data-pipeline-347720.google_ads_thenursecoaches.campaign_performance_report`



)
WHERE lv = _sdc_sequence
GROUP BY date, campaign_id, channel, platform, account, campaign_name, campaign_advertising_channel_type
ORDER BY DATE DESC 


  );
  