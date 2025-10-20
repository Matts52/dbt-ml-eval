with classification_25 as (
    select *
    from {{ ref('classification_25') }}
)

select
    {{ dbt_ml_eval.true_negatives(actual='actual', predicted='predicted') }} as actual_25,
    9 as expected_25 -- true negatives (TN)
from classification_25
