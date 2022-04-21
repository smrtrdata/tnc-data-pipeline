select distinct
site,
bigquery_name,
platform,
goal_name,
account,
goal_type,
time_of_entry
from  ( 

	select  
	site,
	bigquery_name,
	platform,
	goal_name,
	goal_type,
	account,
	time_of_entry,
	first_value(time_of_entry) over (partition by platform, account, goal_name order by time_of_entry desc) lv
	from `{{ target.project }}.thenursecoaches_data_pipeline.conversion_goals` 

) 
where lv = time_of_entry
and date(time_of_entry) = (select date(max(time_of_entry)) from `{{ target.project }}.thenursecoaches_data_pipeline.conversion_goals`)

