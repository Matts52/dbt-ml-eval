{%- macro mean_squared_logarithmic_error(actual, predicted) -%}
    {{ adapter.dispatch('mean_squared_logarithmic_error', 'dbt_ml_eval')(actual, predicted) }}
{%- endmacro -%}

{%- macro default__mean_squared_logarithmic_error(actual, predicted) -%}

    {{ dbt_utils.safe_divide(
        "sum(power(ln(1 + " ~ actual ~ ") - ln(1 + " ~ predicted ~ "), 2))",
        "count(" ~ actual ~ ")"
    ) }}

{%- endmacro -%}
