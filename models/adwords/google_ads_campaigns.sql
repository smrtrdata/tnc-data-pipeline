{% set accounts = get_column_values(table=ref('accounts_proc'), column='account', max_records=50, filter_column='platform', filter_value='Google Ads') %}

{% if accounts != [] %}



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
{% for account in accounts %}
	SELECT  
	"{{account}}" as account
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
	FROM `{{ target.project }}.{{account}}.campaign_performance_report`

{% if not loop.last %} UNION ALL {% endif %}
{% endfor %}
)
WHERE lv = _sdc_sequence
GROUP BY date, campaign_id, channel, platform, account, campaign_name, campaign_advertising_channel_type
ORDER BY DATE DESC 

{% endif %}