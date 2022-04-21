select
site,
bigquery_name,
account,
platform
from  (
 
	select  
	site,
	bigquery_name,
	account,
	platform,
	time_of_entry,
	first_value(time_of_entry) over (partition by site order by time_of_entry desc) lv
	from `{{ target.project }}.thenursecoaches_data_pipeline.accounts`
) 

where lv = time_of_entry