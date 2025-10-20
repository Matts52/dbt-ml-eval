{%- macro mean_bias_error(actual, predicted) -%}
    {{ adapter.dispatch('mean_bias_error', 'dbt_ml_eval')(actual, predicted) }}
{%- endmacro -%}

{%- macro default__mean_bias_error(actual, predicted) -%}

    {{ dbt_utils.safe_divide(
        "sum(" ~ predicted ~ " - " ~ actual ~ ")",
        "count(" ~ actual ~ ")"
    ) }}

{%- endmacro -%}
