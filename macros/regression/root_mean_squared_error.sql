{%- macro root_mean_squared_error(actual, predicted) -%}
    {{ adapter.dispatch('root_mean_squared_error', 'dbt_ml_eval')(actual, predicted) }}
{%- endmacro -%}

{%- macro default__root_mean_squared_error(actual, predicted) -%}

    sqrt(
        {{ dbt_utils.safe_divide(
            "sum(power(" ~ actual ~ " - " ~ predicted ~ ", 2))",
            "count(" ~ actual ~ ")"
        ) }}
    )

{%- endmacro -%}
