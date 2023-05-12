{{ config(materialized='table') }}

with source_headcount as (select *
from {{ ref('headcount')}}
),

final as (
    select * from source_headcount
)

select * from final
