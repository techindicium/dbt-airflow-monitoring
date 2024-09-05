#!/bin/bash

cat <<EOL >> dbt_project.yml

sources:
  dbt_dag_monitoring:
    staging:
      adf_sources:
        raw_adf_monitoring:
          +enabled: false
      databricks_workflow_sources:
        raw_databricks_workflow_monitoring:
          +enabled: true
      airflow_sources:
        raw_airflow_monitoring:
          +enabled: false

models:
  dbt_dag_monitoring:
    marts:
      +materialized: table
    staging:
      adf_sources:  
        +enabled: false
      airflow_sources:
        +enabled: false
      databricks_workflow_sources:
        +enabled: true
      +materialized: view

vars:
  dbt_dag_monitoring:
    enabled_sources: ['databricks_workflow'] #Possible values: 'airflow', 'adf' or 'databricks_workflow'
    dag_monitoring_start_date: cast('2023-01-01' as date)
    dag_monitoring_airflow_database: cdi_dev
    dag_monitoring_airflow_schema: ci_dbt_dag_monitoring
    dag_monitoring_databricks_database: cdi_dev
    dag_monitoring_databricks_schema: ci_dbt_dag_monitoring
    dag_monitoring_adf_database: cdi_dev
    dag_monitoring_adf_schema: ci_dbt_dag_monitoring
EOL