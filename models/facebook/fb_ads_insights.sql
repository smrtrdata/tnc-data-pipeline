{% set accounts = get_column_values(table=ref('accounts_proc'), column='account', max_records=50, filter_column='platform', filter_value='FB Ads') %}

{% if accounts != [] %}

WITH fb_ads_insights as (

	    {% for account in accounts %}
		   	SELECT 
		   	account_name,
			date_start,
			campaign_id,
			campaign_name,
			adset_id,
			adset_name,
			ad_id,
			ad_name
			spend,
			cpm,
			inline_link_click_ctr,
			reach,
			inline_link_clicks,
			##_sdc_sequence,
			##first_value(_sdc_sequence) OVER (PARTITION BY date_start, ad_id, campaign_id ORDER BY _sdc_sequence DESC) lv
			FROM `{{ target.project }}.{{account}}.ads_insights`
		    {% if not loop.last %} UNION ALL {% endif %}
	   {% endfor %}

)

SELECT
account_name account,
date_start date,
campaign_id,
campaign_name campaign,
adset_id,
adset_name,
ad_id,
ad_name,
sum(spend) cost,
avg(cpm) cpm,
sum(reach) reach,
sum(impressions) impressions,
sum(inline_link_clicks) clicks,
sum(spend)/sum(inline_link_click) cpc,
sum(inline_link_clicks)/sum(reach) ctr

FROM fb_ads_insights
##where lv = _sdc_sequence
GROUP BY 
account,
date_start date,
campaign_id,
campaign,
adset_id,
adset_name,
ad_id,
ad_name,

{% endif %}
