with classification_25 as (
    select *
    from {{ ref('classification_25') }}
)
select {{ dbt_ml_eval.prevalence_threshold(
        actual = 'actual',
        predicted = 'predicted'
    ) }} as actual_25,
    -0.1111111111111111 as expected_25 -- calculated by hand ( (TPR*FPR - FPR) / (TPR - FPR) = -1/9 )
from classification_25