{%- macro classification_metrics(actual, predicted, positive_label=1) -%}
    {{ adapter.dispatch('classification_metrics', 'dbt_ml_eval')(actual, predicted, positive_label) }}
{%- endmacro -%}

{%- macro default__classification_metrics(actual, predicted, positive_label=1) -%}

select
    -- Classification counts
    {{ dbt_ml_eval.true_positives(actual, predicted, positive_label) }} as true_positives,
    {{ dbt_ml_eval.true_negatives(actual, predicted, positive_label) }} as true_negatives,
    {{ dbt_ml_eval.false_positives(actual, predicted, positive_label) }} as false_positives,
    {{ dbt_ml_eval.false_negatives(actual, predicted, positive_label) }} as false_negatives,

    -- Basic metrics
    {{ dbt_ml_eval.accuracy(actual, predicted) }} as accuracy,
    {{ dbt_ml_eval.balanced_accuracy(actual, predicted, positive_label) }} as balanced_accuracy,
    {{ dbt_ml_eval.f1_score(actual, predicted, positive_label) }} as f1_score,
    {{ dbt_ml_eval.precision(actual, predicted, positive_label) }} as precision,
    {{ dbt_ml_eval.recall(actual, predicted, positive_label) }} as recall,

    -- Confusion matrix rates
    {{ dbt_ml_eval.true_positive_rate(actual, predicted, positive_label) }} as true_positive_rate,
    {{ dbt_ml_eval.true_negative_rate(actual, predicted, positive_label) }} as true_negative_rate,
    {{ dbt_ml_eval.false_positive_rate(actual, predicted, positive_label) }} as false_positive_rate,
    {{ dbt_ml_eval.false_negative_rate(actual, predicted, positive_label) }} as false_negative_rate,
    {{ dbt_ml_eval.positive_predictive_value(actual, predicted, positive_label) }} as positive_predictive_value,
    {{ dbt_ml_eval.negative_predictive_value(actual, predicted, positive_label) }} as negative_predictive_value,
    {{ dbt_ml_eval.false_omission_rate(actual, predicted, positive_label) }} as false_omission_rate,
    {{ dbt_ml_eval.false_discovery_rate(actual, predicted, positive_label) }} as false_discovery_rate,

    -- Derived metrics
    {{ dbt_ml_eval.informedness(actual, predicted, positive_label) }} as informedness,
    {{ dbt_ml_eval.markedness(actual, predicted, positive_label) }} as markedness,
    {{ dbt_ml_eval.prevalence(actual, predicted, positive_label) }} as prevalence,
    {{ dbt_ml_eval.prevalence_threshold(actual, predicted, positive_label) }} as prevalence_threshold,
    {{ dbt_ml_eval.positive_likelihood_ratio(actual, predicted, positive_label) }} as positive_likelihood_ratio,
    {{ dbt_ml_eval.negative_likelihood_ratio(actual, predicted, positive_label) }} as negative_likelihood_ratio,
    {{ dbt_ml_eval.diagnostic_odds_ratio(actual, predicted, positive_label) }} as diagnostic_odds_ratio,
    {{ dbt_ml_eval.fowlkes_mallows_index(actual, predicted, positive_label) }} as fowlkes_mallows_index,
    {{ dbt_ml_eval.matthews_correlation(actual, predicted, positive_label) }} as matthews_correlation,
    {{ dbt_ml_eval.jaccard_index(actual, predicted, positive_label) }} as jaccard_index

{%- endmacro -%}
