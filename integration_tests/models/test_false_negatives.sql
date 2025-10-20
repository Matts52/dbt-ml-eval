with classification_25 as (
    select *
    from {{ ref('classification_25') }}
)

select
    {{ dbt_ml_eval.false_negatives(actual='actual', predicted='predicted') }} as actual_25,
    3 as expected_25 -- false negatives (FN)
from classification_25
