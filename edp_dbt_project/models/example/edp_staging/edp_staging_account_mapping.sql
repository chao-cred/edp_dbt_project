
with source_account_mapping as (select *
from {{ source('edp_staging', 'account_mapping')}}
),

final as (
    select PK_ID, CAST(HFM_NAME AS VARCHAR(255)) AS HFM_NAME,
       CAST(DESCRIPTION AS VARCHAR(400)) AS DESCRIPTION,
       CAST(HFM_PARENT_NAME AS VARCHAR(400)) AS HFM_PARENT_NAME,
       CAST(PARENT_DESCRIPTION AS VARCHAR(400)) AS PARENT_DESCRIPTION,
       CAST(LEAF AS VARCHAR(255)) AS LEAF,
       LOAD_TIMESTAMP 
    from source_account_mapping
)

select * from final
