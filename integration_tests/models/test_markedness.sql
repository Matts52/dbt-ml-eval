with classification_25 as (
    select *
    from {{ ref('classification_25') }}
)
select {{ dbt_ml_eval.markedness(
        actual = 'actual',
        predicted = 'predicted'
    ) }} as actual_25,
    0.5192307692307692 as expected_25 -- calculated by hand (PPV + NPV - 1)
from classification_25