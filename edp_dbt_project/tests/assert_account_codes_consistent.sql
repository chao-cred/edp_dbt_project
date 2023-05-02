SELECT '3. LOW' AS PRIORITY, 'Account code has been removed. Verify removed account code does not impact EDP filtering logic' AS REASON, 'edp_staging_account_mapping' AS TARGET_TABLE, 
cast(HFM_NAME as varchar(50)) AS RECORD_ID, cast(DESCRIPTION as varchar(255)) AS SUPPORTING_NOTES
FROM (SELECT * FROM DBT_TEMPLATE.edp_staging_account_mapping a 
WHERE LOAD_TIMESTAMP = (SELECT MAX(LOAD_TIMESTAMP) FROM DBT_TEMPLATE.edp_staging_account_mapping WHERE LOAD_TIMESTAMP < (SELECT MAX(LOAD_TIMESTAMP) FROM DBT_TEMPLATE.edp_staging_account_mapping))
AND NOT EXISTS (SELECT 'X' FROM DBT_TEMPLATE.edp_staging_account_mapping b
WHERE LOAD_TIMESTAMP = (SELECT MAX(LOAD_TIMESTAMP) FROM DBT_TEMPLATE.edp_staging_account_mapping)
AND a.HFM_NAME = b.HFM_NAME)) B