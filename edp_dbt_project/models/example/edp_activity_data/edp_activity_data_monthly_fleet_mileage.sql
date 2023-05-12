with fleet_records as (
    select * from {{ ref('edp_staging_fleet_records')}}
    where LOAD_TIMESTAMP = (SELECT MAX(LOAD_TIMESTAMP) FROM {{ ref('edp_staging_fleet_records')}})
),

date_table as (
    select * from {{ ref('date_table')}}

),

final as (
    select country, make, model, fuel_type, month(date) as month, year(date) as date,
    CAST(COUNT(DISTINCT DATE) as numeric)/DAY(EOMONTH(DATEFROMPARTS(YEAR(DATE),MONTH(DATE),1))) as PERCENT_OF_MONTH_ACTIVE,
    NULLIF(max(monthly_mileage),0) as MILEAGE_PER_MONTH,
	NULLIF(max(monthly_mileage),0) * CAST(COUNT(DISTINCT DATE) as numeric)/DAY(EOMONTH(DATEFROMPARTS(YEAR(DATE),MONTH(DATE),1))) as MILEAGE_DISTRIBUTED
    from fleet_records
    JOIN date_table ON DATE >= EFFECTIVE_DATE AND DATE <= END_DATE 
    AND DATEFROMPARTS(YEAR(DATE),MONTH(DATE),1) < DATEFROMPARTS(YEAR(GETDATE()),MONTH(GETDATE()),1)
    GROUP BY country, make, model, fuel_type, month(date), year(date)
)

select *
from final