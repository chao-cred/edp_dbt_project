with car_travel as (
    select * from {{ ref('edp_staging_travel_car')}}
    where LOAD_TIMESTAMP = (SELECT MAX(LOAD_TIMESTAMP) FROM {{ ref('edp_staging_travel_car')}})
),

final as (
    select month, year, city, country, car_type, 
    sum(rental_mileage) as rental_mileage, sum(spend_usd) as spend_usd 
    from car_travel
    group by month, year, city, country, car_type

)

select *
from final