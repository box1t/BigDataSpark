# Инструкция по запуску


## Структура проекта:

```
BigDataSpark/
├── launch_instruction.md
├── docker-compose.yml
├── clickhouse/
│      └── users.xml    
├── исходные данные/
│   ├── mock_data_N.csv
│   └── ...
├── jars/
│   ├── postgresql-42.6.0.jar  
│   ├── mongo-spark-connector_2.12-3.0.1.jar
│   └── clickhouse-jdbc-0.4.6.jar 
├── notebooks/
│   ├── 1_snowflake_etl.ipynb
│   └── 2_clickhouse_reports.ipynb
│   
├── scripts/
│   ├── 01_create_tables.sql
│   ├── 02_load_csv_data.sh
│   └── run_all.sh

```

## Шаг 1: Запуск проекта

```sh

git clone "репозиторий"
cd BigDataSpark
chmod +x scripts/02_load_csv_data.sh
chmod +x scripts/run_all.sh

docker-compose -f docker-compose.yml down -v
docker-compose -f docker-compose.yml up -d   
docker compose logs -f db 


```
## Шаг 2: Jupyter

- Сделал по модели данных снежинка на основе ЛР-1.
- Spark запускается внутри jupyter-notebook со всеми spark.jars.
- Для демонстрации ETL в Jupyter нужен URL с token, которая будет в логах jupyter-notebook при запуске:

```sh
docker-compose -f docker-compose.yml logs jupyter-notebook
```

## Заметки
- Решил проблему с драйверами монтированием папки в docker-compose для juputer. 
- Теперь они доступны для просмотра как файлы в проводнике слева. Это шаг критичный.

![alt text](<src/Screenshot from 2025-06-01 17-46-42.png>)

![report](<src/Screenshot from 2025-06-01 17-50-29.png>)