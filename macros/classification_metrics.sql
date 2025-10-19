{%- macro classification_metrics(actual, predicted, positive_label=1) -%}
    {{ adapter.dispatch('classification_metrics', 'dbt_ml_eval')(actual, predicted, positive_label) }}
{%- endmacro -%}

{%- macro default__classification_metrics(actual, predicted, positive_label=1) -%}

    {{ accuracy(actual, predicted) }} as accuracy,
    {{ precision(actual, predicted, positive_label) }} as precision,
    {{ recall(actual, predicted, positive_label) }} as recall

{%- endmacro -%}