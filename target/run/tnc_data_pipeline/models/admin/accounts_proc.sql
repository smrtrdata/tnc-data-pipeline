

  create or replace view `tnc-data-pipeline-347720`.`development`.`accounts_proc`
  OPTIONS()
  as select
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
	from `tnc-data-pipeline-347720.thenursecoaches_data_pipeline.accounts`
) 

where lv = time_of_entry;

