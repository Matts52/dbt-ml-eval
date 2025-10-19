{%- macro fowlkes_mallows_index(actual, predicted, positive_label=1) -%}
    {{ adapter.dispatch('fowlkes_mallows_index', 'dbt_ml_eval')(actual, predicted, positive_label) }}
{%- endmacro -%}

{%- macro default__fowlkes_mallows_index(actual, predicted, positive_label=1) -%}

    sqrt(
        {{ dbt_ml_eval.positive_predictive_value(actual, predicted, positive_label) }}
        *
        {{ dbt_ml_eval.true_positive_rate(actual, predicted, positive_label) }}
    )

{%- endmacro -%}
