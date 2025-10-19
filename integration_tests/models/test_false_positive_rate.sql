with classification_25 as (
    select *
    from {{ ref('classification_25') }}
)
select {{ dbt_ml_eval.false_positive_rate(
        actual = 'actual',
        predicted = 'predicted'
    ) }} as actual_25,
    0.25 as expected_25 -- calculated by hand (FP/(FP+TN) = 3/12)
from classification_25