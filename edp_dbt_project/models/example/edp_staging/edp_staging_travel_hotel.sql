{{ config(materialized='table') }}

with source_hotel_travel as (select *
from {{ ref('travel_hotel')}}
),

final as (
    select *
    from source_hotel_travel
)

select * from final