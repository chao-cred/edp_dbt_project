{{ config(materialized='table') }}

with source_car_travel as (select *
from {{ ref('travel_car_rental')}}
),

final as (
    select *
    from source_car_travel
)

select * from final