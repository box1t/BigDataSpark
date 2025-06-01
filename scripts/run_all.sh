# scripts/run_all.sh
#!/bin/bash
set -e

echo "Ждём запуска Postgres..."
until pg_isready -U "$POSTGRES_USER" -d "$POSTGRES_DB"; do
  sleep 1
done

echo "Postgres готов!"

echo "Шаг 1: Создание таблиц..."
psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -f /docker-entrypoint-initdb.d/01_create_tables.sql

echo "Очистка Dim и Fact таблиц перед загрузкой снежинки Spark..."
PGPASSWORD="$PGPASSWORD" psql -h db -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c "TRUNCATE TABLE FactSales RESTART IDENTITY CASCADE;"
PGPASSWORD="$PGPASSWORD" psql -h db -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c "TRUNCATE TABLE DimCustomers RESTART IDENTITY CASCADE;"
PGPASSWORD="$PGPASSWORD" psql -h db -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c "TRUNCATE TABLE DimSellers RESTART IDENTITY CASCADE;"
PGPASSWORD="$PGPASSWORD" psql -h db -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c "TRUNCATE TABLE DimProducts RESTART IDENTITY CASCADE;"
PGPASSWORD="$PGPASSWORD" psql -h db -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c "TRUNCATE TABLE DimStores RESTART IDENTITY CASCADE;"
PGPASSWORD="$PGPASSWORD" psql -h db -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c "TRUNCATE TABLE DimSuppliers RESTART IDENTITY CASCADE;"
PGPASSWORD="$PGPASSWORD" psql -h db -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c "TRUNCATE TABLE DimDate RESTART IDENTITY CASCADE;"


echo "Postgres инициализация схем завершена!"