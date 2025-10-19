with classification_25 as (
    select *
    from {{ ref('classification_25') }}
)
select {{ dbt_ml_eval.informedness(
        actual = 'actual',
        predicted = 'predicted'
    ) }} as actual_25,
    0.5192307692307692 as expected_25 -- calculated by hand (TPR + TNR - 1)
from classification_25