

  create or replace table `tnc-data-pipeline-347720`.`development`.`conversion_goals_proc`
  
  
  OPTIONS()
  as (
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
	from `tnc-data-pipeline-347720.thenursecoaches_data_pipeline.conversion_goals` 

) 
where lv = time_of_entry
and date(time_of_entry) = (select date(max(time_of_entry)) from `tnc-data-pipeline-347720.thenursecoaches_data_pipeline.conversion_goals`)
  );
  