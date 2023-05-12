with facilities_records as (
    select * from {{ ref('edp_staging_facilities_data')}}
    where LOAD_TIMESTAMP = (SELECT MAX(LOAD_TIMESTAMP) FROM {{ ref('edp_staging_facilities_data')}})
),

date_table as (
    select * from {{ ref('date_table')}}

),

final as (
    select month(date) as month, year(date) as year, property_id, property_type, address, city, country, postalZip, region, lease_structure,  
	ISNULL(SUM(lease_rentable_sf), 0) * CAST(COUNT(DISTINCT DATE) as numeric)/DAY(EOMONTH(DATEFROMPARTS(YEAR(DATE),MONTH(DATE),1))) as building_total_sf
    from facilities_records
    JOIN date_table ON DATE >= EFFECTIVE_DATE AND DATE <= END_DATE 
    AND DATEFROMPARTS(YEAR(DATE),MONTH(DATE),1) < DATEFROMPARTS(YEAR(GETDATE()),MONTH(GETDATE()),1)
    GROUP BY month(date), year(date), property_id, property_type, address, city, country, postalZip, region, lease_structure
)

select *
from final