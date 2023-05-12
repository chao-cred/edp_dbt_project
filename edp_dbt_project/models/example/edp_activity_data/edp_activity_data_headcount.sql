with headcount as (
    select * from {{ ref('edp_staging_headcount')}}
    where LOAD_TIMESTAMP = (SELECT MAX(LOAD_TIMESTAMP) FROM {{ ref('edp_staging_headcount')}})
),


final as (
    select month, year, city, country, sum(headcount) as headcount
    from headcount h 
    group by month, year, city, country
)

select *
from final