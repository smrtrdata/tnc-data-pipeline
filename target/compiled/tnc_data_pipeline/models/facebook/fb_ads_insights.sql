



WITH fb_ads_insights as (

	    
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
			FROM `tnc-data-pipeline-347720.fb_thenursecoaches.ads_insights`
		    
	   

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

