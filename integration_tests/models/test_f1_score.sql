with classification_25 as (
    select *
    from {{ ref('classification_25') }}
)
select {{ dbt_ml_eval.f1_score(
        actual = 'actual',
        predicted = 'predicted'
    ) }} as actual_25,
    0.7692307692307693 as expected_25 -- calculated by hand (2*TP/(2*TP+FP+FN))
from classification_25