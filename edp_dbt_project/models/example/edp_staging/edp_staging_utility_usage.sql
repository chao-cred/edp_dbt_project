{{ config(materialized='table') }}

with source_utility as (select *
from {{ ref('utility_data')}}
),

final as (
    select *
    from source_utility
)

select * from final