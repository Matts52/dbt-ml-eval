with classification_25 as (
    select *
    from {{ ref('classification_25') }}
)

select
    {{ dbt_ml_eval.false_positives(actual='actual', predicted='predicted') }} as actual_25,
    3 as expected_25 -- false positives (FP)
from classification_25
