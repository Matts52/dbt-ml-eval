{%- macro mean_squared_error(actual, predicted) -%}
    {{ adapter.dispatch('mean_squared_error', 'dbt_ml_eval')(actual, predicted) }}
{%- endmacro -%}

{%- macro default__mean_squared_error(actual, predicted) -%}

    {{ dbt_utils.safe_divide(
        "sum(power(" ~ actual ~ " - " ~ predicted ~ ", 2))",
        "count(" ~ actual ~ ")"
    ) }}

{%- endmacro -%}
