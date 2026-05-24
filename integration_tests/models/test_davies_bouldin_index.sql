{%- set clustering_data = ref('clustering_25') -%}

select
    {{ dbt_ml_eval.davies_bouldin_index(
        table=clustering_data,
        feature_columns=['x', 'y'],
        cluster_column='cluster'
    ) }} as actual_25,
    0.05 as expected_25  -- two well-separated clusters yield very low DBI (~0.049)
