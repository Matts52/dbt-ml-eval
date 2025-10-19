with classification_25 as (
    select *
    from {{ ref('classification_25') }}
)
select {{ dbt_ml_eval.false_discovery_rate(
        actual = 'actual',
        predicted = 'predicted'
    ) }} as actual_25,
    0.23076923076923078 as expected_25 -- calculated by hand (FP/(FP+TP) = 3/13)
from classification_25