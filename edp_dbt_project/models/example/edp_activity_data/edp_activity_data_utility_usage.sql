with utility_usage as (
    select * from {{ ref('edp_staging_utility_usage')}}
    where LOAD_TIMESTAMP = (SELECT MAX(LOAD_TIMESTAMP) FROM {{ ref('edp_staging_utility_usage')}})
),

facilities_records as (
    select * from {{ ref('edp_activity_data_facilities')}}
),

final as (
    select coalesce(u.month, f.month) as month, coalesce(u.year, f.year) as year, 
    coalesce(u.property_id, f.property_id) as property_id, property_type, address, city, country, postalZip, region,
    sum(electricity_nonrenewable_kwh) as electricity_nonrenewable_kwh, sum(electricity_renewable_kwh) as electricity_renewable_kwh,
    sum(fuel_oil_liters) as fuel_oil_liters, sum(natural_gas_kwh) as natural_gas_kwh
    from utility_usage u full outer join facilities_records f 
    on u.property_id = f.property_id and u.month = f.month and u.year = f.year
    group by coalesce(u.month, f.month), coalesce(u.year, f.year), 
    coalesce(u.property_id, f.property_id), property_type, address, city, country, postalZip, region
)

select *
from final