with classification_25 as (
    select *
    from {{ ref('classification_25') }}
)
select
    {{
        dbt_ml_eval.accuracy(
            actual = 'actual',
            predicted = 'predicted'
        )
    }}
    as actual_25,
    0.76 as expected_25 -- calculated by hand
from classification_25