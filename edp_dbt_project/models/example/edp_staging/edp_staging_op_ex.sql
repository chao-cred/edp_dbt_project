{{ config(materialized='table') }}

with source_op_ex as (select *
from {{ ref('op_ex')}}
),

final as (
    select * from source_op_ex
)

select * from final
