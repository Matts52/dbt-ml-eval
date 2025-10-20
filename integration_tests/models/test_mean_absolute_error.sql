with regression_25 as (
    select *
    from {{ ref('regression_25') }}
)

select
    {{ dbt_ml_eval.mean_absolute_error(actual='actual', predicted='predicted') }} as actual_25,
    0.324 as expected_25 -- calculated by hand (sum(abs errors)=8.1; 8.1/25=0.324)
from regression_25
