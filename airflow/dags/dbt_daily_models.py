from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime, timedelta

default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': datetime(2024, 3, 23),  
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

dag = DAG(
    'dbt_daily_models',
    default_args=default_args,
    description='Aylık ürün bazında satışlar ve aylık kategori bazında satışlar için dbt modelleri her sabah 10:00’da çalıştırılır',
    schedule_interval='0 10 * * *',  
    catchup=False,
)

# monthly_sales_by_product modelini çalıştırılır

run_monthly_sales = BashOperator(
    task_id='run_monthly_sales_by_product',
    bash_command='dbt run --select monthly_sales_by_product',
    dag=dag,
)

# monthly_sales_by_category modeli çalıştırılır

run_monthly_sales_by_category = BashOperator(
    task_id='run_monthly_sales_by_category',
    bash_command='dbt run --select monthly_sales_by_category',
    dag=dag,
)

# Task önceliği belirtilir
run_monthly_sales >> run_monthly_sales_by_category