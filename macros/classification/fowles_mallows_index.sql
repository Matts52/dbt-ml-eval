{%- macro fowlkes_mallows_index(actual, predicted, positive_label=1) -%}
    {{ adapter.dispatch('fowlkes_mallows_index', 'dbt_ml_eval')(actual, predicted, positive_label) }}
{%- endmacro -%}

{%- macro default__fowlkes_mallows_index(actual, predicted, positive_label=1) -%}

    (
        {{ positive_predictive_value(actual, predicted, positive_label) }}
        *
        {{ true_positive_rate(actual, predicted, positive_label) }}
    )

{%- endmacro -%}
