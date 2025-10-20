{%- macro mean_absolute_error(actual, predicted) -%}
    {{ adapter.dispatch('mean_absolute_error', 'dbt_ml_eval')(actual, predicted) }}
{%- endmacro -%}

{%- macro default__mean_absolute_error(actual, predicted) -%}

    {{ dbt_utils.safe_divide(
        "sum(abs(" ~ actual ~ " - " ~ predicted ~ "))",
        "count(" ~ actual ~ ")"
    ) }}

{%- endmacro -%}
