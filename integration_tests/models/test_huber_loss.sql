with regression_25 as (
    select *
    from {{ ref('regression_25') }}
)

select
    {{ dbt_ml_eval.huber_loss(actual='actual', predicted='predicted') }} as actual_25,
    0.0714 as expected_25 -- calculated by hand: since all |residuals| <= 1, huber_loss = 0.5 * MSE = 0.5 * 0.1428
from regression_25
