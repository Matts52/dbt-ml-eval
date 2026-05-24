{%- set clustering_data = ref('clustering_25') -%}

select
    {{ dbt_ml_eval.silhouette_score(
        table=clustering_data,
        feature_columns=['x', 'y'],
        cluster_column='cluster'
    ) }} as actual_25,
    0.97 as expected_25  -- two well-separated clusters (~11 units apart, ~0.3 intra-cluster spread)
