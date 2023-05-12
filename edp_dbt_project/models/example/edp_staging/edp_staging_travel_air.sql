{{ config(materialized='table') }}

with source_air_travel as (select *
from {{ ref('travel_air')}}
),

final as (
    select *
    from source_air_travel
)

select * from final
