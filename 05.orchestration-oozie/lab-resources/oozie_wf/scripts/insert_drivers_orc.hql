INSERT OVERWRITE TABLE ${group}.${hiveUsername}_nyc_drivers
SELECT 
  driver_id,
  split(name, ' ')[0] AS first_name,
  split(name, ' ')[1] AS last_name,
  ssn,
  location AS address,
  CASE WHEN certified = 'Y' THEN true ELSE false END AS certified,
  wage_plan
FROM ${group}.${hiveUsername}_nyc_drivers_ext;
