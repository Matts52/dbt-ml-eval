{%- macro informedness(actual, predicted, positive_label=1) -%}
    {{ adapter.dispatch('informedness', 'dbt_ml_eval')(actual, predicted, positive_label) }}
{%- endmacro -%}

{%- macro default__informedness(actual, predicted, positive_label=1) -%}

    (
        {{ dbt_ml_eval.true_positive_rate(actual, predicted, positive_label) }}
        + {{ dbt_ml_eval.true_negative_rate(actual, predicted, positive_label) }}
        - 1
    )

{%- endmacro -%}
