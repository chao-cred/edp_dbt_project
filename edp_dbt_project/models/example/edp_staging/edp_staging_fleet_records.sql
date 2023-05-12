{{ config(materialized='table') }}

with source_fleet_records as (select *
from {{ ref('fleet_records')}}
),

final as (
    select *
    from source_fleet_records
)

select * from final
