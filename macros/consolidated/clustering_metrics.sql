{%- macro clustering_metrics(table, feature_columns, cluster_column) -%}
    {{ adapter.dispatch('clustering_metrics', 'dbt_ml_eval')(table, feature_columns, cluster_column) }}
{%- endmacro -%}

{%- macro default__clustering_metrics(table, feature_columns, cluster_column) -%}

    {{ dbt_ml_eval.silhouette_score(table, feature_columns, cluster_column) }} as silhouette_score,
    {{ dbt_ml_eval.davies_bouldin_index(table, feature_columns, cluster_column) }} as davies_bouldin_index,
    {{ dbt_ml_eval.calinski_harabasz_index(table, feature_columns, cluster_column) }} as calinski_harabasz_index,
    {{ dbt_ml_eval.dunn_index(table, feature_columns, cluster_column) }} as dunn_index,
    {{ dbt_ml_eval.inertia(table, feature_columns, cluster_column) }} as inertia

{%- endmacro -%}
