{%- macro mean_absolute_percentage_error(actual, predicted) -%}
    {{ adapter.dispatch('mean_absolute_percentage_error', 'dbt_ml_eval')(actual, predicted) }}
{%- endmacro -%}

{%- macro default__mean_absolute_percentage_error(actual, predicted) -%}

  100 * {{ dbt_utils.safe_divide(
      "sum(case when " ~ actual ~ " is not null and " ~ predicted ~ " is not null and " ~ actual ~ " != 0 then abs((" ~ actual ~ " - " ~ predicted ~ ") / " ~ actual ~ ") end)",
      "count(case when " ~ actual ~ " is not null and " ~ predicted ~ " is not null and " ~ actual ~ " != 0 then 1 end)"
  ) }}

{%- endmacro -%}
