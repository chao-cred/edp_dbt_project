{{ config(materialized='table') }}

with source_facilities_data as (select *
from {{ ref('facility_data')}}),

final as (
    select *
    from source_facilities_data
)

select * from final
