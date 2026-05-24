{%- set clustering_data = ref('clustering_25') -%}

select
    {{ dbt_ml_eval.clustering_metrics(
        table=clustering_data,
        feature_columns=['x', 'y'],
        cluster_column='cluster'
    ) }}
