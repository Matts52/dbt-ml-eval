{%- macro classification_metrics(actual, predicted, positive_label=1) -%}
    {{ adapter.dispatch('classification_metrics', 'dbt_ml_eval')(actual, predicted, positive_label) }}
{%- endmacro -%}

{%- macro default__classification_metrics(actual, predicted, positive_label=1) -%}

select
    -- Basic metrics
    {{ accuracy(actual, predicted) }} as accuracy,
    {{ balanced_accuracy(actual, predicted, positive_label) }} as balanced_accuracy,
    {{ f1_score(actual, predicted, positive_label) }} as f1_score,
    {{ precision(actual, predicted, positive_label) }} as precision,
    {{ recall(actual, predicted, positive_label) }} as recall,

    -- Confusion matrix rates
    {{ true_positive_rate(actual, predicted, positive_label) }} as true_positive_rate,
    {{ true_negative_rate(actual, predicted, positive_label) }} as true_negative_rate,
    {{ false_positive_rate(actual, predicted, positive_label) }} as false_positive_rate,
    {{ false_negative_rate(actual, predicted, positive_label) }} as false_negative_rate,
    {{ positive_predictive_value(actual, predicted, positive_label) }} as positive_predictive_value,
    {{ negative_predictive_value(actual, predicted, positive_label) }} as negative_predictive_value,
    {{ false_omission_rate(actual, predicted, positive_label) }} as false_omission_rate,
    {{ false_discovery_rate(actual, predicted, positive_label) }} as false_discovery_rate,

    -- Derived metrics
    {{ informedness(actual, predicted, positive_label) }} as informedness,
    {{ markedness(actual, predicted, positive_label) }} as markedness,
    {{ prevalence(actual, predicted, positive_label) }} as prevalence,
    {{ prevalence_threshold(actual, predicted, positive_label) }} as prevalence_threshold,
    {{ positive_likelihood_ratio(actual, predicted, positive_label) }} as positive_likelihood_ratio,
    {{ negative_likelihood_ratio(actual, predicted, positive_label) }} as negative_likelihood_ratio,
    {{ diagnostic_odds_ratio(actual, predicted, positive_label) }} as diagnostic_odds_ratio,
    {{ fowlkes_mallows_index(actual, predicted, positive_label) }} as fowlkes_mallows_index,
    {{ matthews_correlation(actual, predicted, positive_label) }} as matthews_correlation,
    {{ jaccard_index(actual, predicted, positive_label) }} as jaccard_index

{%- endmacro -%}
