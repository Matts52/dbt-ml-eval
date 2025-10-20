with classification_25 as (
    select *
    from {{ ref('classification_25') }}
)

select
    {{ dbt_ml_eval.true_positives(actual='actual', predicted='predicted') }} as actual_25,
    10 as expected_25 -- true positives (TP)
from classification_25
