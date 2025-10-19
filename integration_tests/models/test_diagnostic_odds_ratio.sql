with classification_25 as (
    select *
    from {{ ref('classification_25') }}
)
select {{ dbt_ml_eval.diagnostic_odds_ratio(
        actual = 'actual',
        predicted = 'predicted'
    ) }} as actual_25,
    10 as expected_25 -- calculated by hand (TP*TN)/(FP*FN) = (10*9)/(3*3)
from classification_25