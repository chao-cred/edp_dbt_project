SELECT '1. HIGH' AS PRIORITY, 'Sums of spend do not match between staging table and activity table' AS REASON, 
'edp_activity_data_capital_goods' AS TARGET_TABLE, 
'' AS RECORD_ID, '' AS SUPPORTING_NOTES 

FROM
  (SELECT SUM(MEASURE_AMT) AS total_spend FROM DBT_TEMPLATE.edp_staging_capital_goods
  where LOAD_TIMESTAMP = (SELECT MAX(LOAD_TIMESTAMP) FROM dbt_template.edp_staging_capital_goods)) t1
  CROSS JOIN
  (SELECT SUM(spend_USD) AS total_spend FROM DBT_TEMPLATE.edp_activity_data_capital_goods) t2

WHERE t1.total_spend <> t2.total_spend;