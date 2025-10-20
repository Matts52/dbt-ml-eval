{%- macro explained_variance(actual, predicted) -%}
    {{ adapter.dispatch('explained_variance', 'dbt_ml_eval')(actual, predicted) }}
{%- endmacro -%}

{%- macro default__explained_variance(actual, predicted) -%}

    1 - {{ dbt_utils.safe_divide(
        "sum(power(" ~ actual ~ " - " ~ predicted ~ ", 2))",
        "nullif( (sum(power(" ~ actual ~ ", 2)) - power(sum(" ~ actual ~ "), 2) / nullif(count(" ~ actual ~ "), 0)), 0)"
    ) }}

{%- endmacro -%}
