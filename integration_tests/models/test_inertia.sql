{%- set clustering_data = ref('clustering_25') -%}

select
    {{ dbt_ml_eval.inertia(
        table=clustering_data,
        feature_columns=['x', 'y'],
        cluster_column='cluster'
    ) }} as actual_25,
    2.06 as expected_25  -- two tight clusters with small within-cluster spread (~2.06)
