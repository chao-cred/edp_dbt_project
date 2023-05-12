with air_travel as (
    select * from {{ ref('edp_staging_travel_air')}}
    where LOAD_TIMESTAMP = (SELECT MAX(LOAD_TIMESTAMP) FROM {{ ref('edp_staging_travel_air')}})
),

final as (
    select month, year, cabin, carrier, sum(mileage) as mileage, sum(spend_usd) as spend_usd 
    from air_travel
    group by month, year, cabin, carrier

)

select *
from final