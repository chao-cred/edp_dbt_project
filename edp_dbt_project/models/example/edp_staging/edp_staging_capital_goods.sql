

with source_cap_ex as (select *
from {{ source('edp_staging', 'cap_ex')}}
),

final as (
    select * from source_cap_ex
)

select * from final
