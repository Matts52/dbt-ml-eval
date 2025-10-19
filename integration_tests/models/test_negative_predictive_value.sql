with classification_25 as (
    select *
    from {{ ref('classification_25') }}
)
select {{ dbt_ml_eval.negative_predictive_value(
        actual = 'actual',
        predicted = 'predicted'
    ) }} as actual_25,
    0.75 as expected_25 -- calculated by hand (TN/(TN+FN) = 9/12)
from classification_25