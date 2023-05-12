with hotel_travel as (
    select * from {{ ref('edp_staging_travel_hotel')}}
    where LOAD_TIMESTAMP = (SELECT MAX(LOAD_TIMESTAMP) FROM {{ ref('edp_staging_travel_hotel')}})
),

final as (
    select month, year, city, country, hotel_vendor, 
    sum(num_nights) * sum(unique_room_count) as total_nights, sum(spend_usd) as spend_usd 
    from hotel_travel
    group by month, year, city, country, hotel_vendor

)

select *
from final