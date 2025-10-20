{%- macro median_absolute_error(actual, predicted) -%}
    {{ adapter.dispatch('median_absolute_error', 'dbt_ml_eval')(actual, predicted) }}
{%- endmacro -%}

{%- macro default__median_absolute_error(actual, predicted) -%}

  percentile_cont(0.5) WITHIN GROUP (ORDER BY abs({{ actual }} - {{ predicted }}))

{%- endmacro -%}
