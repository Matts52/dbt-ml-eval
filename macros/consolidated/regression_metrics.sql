{%- macro regression_metrics(actual, predicted) -%}
    {{ adapter.dispatch('regression_metrics', 'dbt_ml_eval')(actual, predicted) }}
{%- endmacro -%}

{%- macro default__regression_metrics(actual, predicted) -%}

    -- Core error metrics
    {{ dbt_ml_eval.mean_absolute_error(actual, predicted) }} as mean_absolute_error,
    {{ dbt_ml_eval.mean_squared_error(actual, predicted) }} as mean_squared_error,
    {{ dbt_ml_eval.root_mean_squared_error(actual, predicted) }} as root_mean_squared_error,
    {{ dbt_ml_eval.mean_absolute_percentage_error(actual, predicted) }} as mean_absolute_percentage_error,
    {{ dbt_ml_eval.mean_squared_logarithmic_error(actual, predicted) }} as mean_squared_logarithmic_error,

    -- Fit & correlation metrics
    {{ dbt_ml_eval.r2_score(actual, predicted) }} as r2_score,
    {{ dbt_ml_eval.explained_variance(actual, predicted) }} as explained_variance,

    -- Scale-independent metrics
    {{ dbt_ml_eval.median_absolute_error(actual, predicted) }} as median_absolute_error,
    {{ dbt_ml_eval.mean_bias_error(actual, predicted) }} as mean_bias_error,

    -- Robust loss metrics
    {{ dbt_ml_eval.huber_loss(actual, predicted) }} as huber_loss

{%- endmacro -%}
