





SELECT
date
,campaignid
,campaign_name
,campaign_advertising_channel_type
,channel
,platform
,sum(cost) cost
,sum(impressions) impressions
,sum(clicks) clicks
,sum(conversions) conversions
FROM
( 

	SELECT  
	'Paid' as channel
	,'Adwords' as platform
	,date
	,campaignid
	,campaign_name
	,cost_micros/1000000 cost,
	,impressions,
	,clicks,
	,_sdc_sequence
	,first_value(_sdc_sequence) OVER (PARTITION BY campaignid, day ORDER BY _sdc_sequence DESC) lv
	FROM `tnc-data-pipeline-347720.google_ads_thenursecoaches.CAMPAIGN_PERFORMANCE_REPORT`



)
WHERE lv = _sdc_sequence
GROUP BY date, campaignid, account, channel, platform, campaign

