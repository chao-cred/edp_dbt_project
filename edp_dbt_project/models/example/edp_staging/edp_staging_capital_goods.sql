{{ config(materialized='table') }}

with source_cap_ex as (select *
from {{ ref('cap_ex')}}
),

final as (
    select * from source_cap_ex
)

select * from final
