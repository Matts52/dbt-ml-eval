with classification_25 as (
    select *
    from {{ ref('classification_25') }}
)
select {{ dbt_ml_eval.matthews_correlation(
        actual = 'actual',
        predicted = 'predicted'
    ) }} as actual_25,
    0.5192307692307692 as expected_25 -- calculated by hand ((TP*TN - FP*FN)/sqrt((TP+FP)*(TP+FN)*(TN+FP)*(TN+FN)))
from classification_25