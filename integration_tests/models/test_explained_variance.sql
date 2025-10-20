with regression_25 as (
    select *
    from {{ ref('regression_25') }}
)

select
    {{ dbt_ml_eval.explained_variance(actual='actual', predicted='predicted') }} as actual_25,
    0.994 as expected_25 -- approximate explained variance
from regression_25
