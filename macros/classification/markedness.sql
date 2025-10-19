{%- macro markedness(actual, predicted, positive_label=1) -%}
    {{ adapter.dispatch('markedness', 'dbt_ml_eval')(actual, predicted, positive_label) }}
{%- endmacro -%}

{%- macro default__markedness(actual, predicted, positive_label=1) -%}

    (
        {{ positive_predictive_value(actual, predicted, positive_label) }}
        + {{ negative_predictive_value(actual, predicted, positive_label) }}
        - 1
    )

{%- endmacro -%}
