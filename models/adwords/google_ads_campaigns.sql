{% set accounts = get_column_values(table=ref('accounts_proc'), column='account', max_records=50, filter_column='platform', filter_value='Google Ads') %}

{% if accounts != [] %}



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
{% for account in accounts %}
	SELECT  
	'Paid' as channel
	,'Adwords' as platform
	,date
	,campaignid
	,campaign_name
	,cost_micros/1000000 cost
	,impressions,
	,clicks
	,_sdc_sequence
	,first_value(_sdc_sequence) OVER (PARTITION BY campaignid, day ORDER BY _sdc_sequence DESC) lv
	FROM `{{ target.project }}.{{account}}.CAMPAIGN_PERFORMANCE_REPORT`

{% if not loop.last %} UNION ALL {% endif %}
{% endfor %}
)
WHERE lv = _sdc_sequence
GROUP BY date, campaignid, account, channel, platform, campaign

{% endif %}