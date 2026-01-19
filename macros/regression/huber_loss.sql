{%- macro huber_loss(actual, predicted, delta=1.0) -%}
    {{ adapter.dispatch('huber_loss', 'dbt_ml_eval')(actual, predicted, delta) }}
{%- endmacro -%}

{%- macro default__huber_loss(actual, predicted, delta) -%}

    {{ dbt_utils.safe_divide(
        "sum(case when abs(" ~ actual ~ " - " ~ predicted ~ ") <= " ~ delta ~ " then 0.5 * power(" ~ actual ~ " - " ~ predicted ~ ", 2) else " ~ delta ~ " * (abs(" ~ actual ~ " - " ~ predicted ~ ") - 0.5 * " ~ delta ~ ") end)",
        "count(" ~ actual ~ ")"
    ) }}

{%- endmacro -%}
