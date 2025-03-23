# DBT ve Airflow Projesi

Bu proje, DBT kullanarak veritabanı modelleri çalıştıran ve Airflow ile zamanlanmış görevler kullanan bir veri işleme iş akışını içerir.

## Adımlar

1. **CSV Dosyaları**: `data/` klasörüne yüklenmiş veriler DBT projelerinde kullanılacaktır.
2. **DBT Modelleri**: `dbt/models/` içinde bulunan SQL dosyaları DBT tarafından çalıştırılacak.
3. **Airflow**: Airflow DAG'leri, DBT modellerini her sabah 10:00'da çalıştıracak şekilde ayarlanmıştır.

## Kurulum

1. Docker'ı ve Docker Compose'u kurun.
2. Proje kök dizininde `docker-compose up` komutunu çalıştırın.
3. Airflow web arayüzüne `localhost:8080` üzerinden erişebilirsiniz.
4. DBT modellerini çalıştırmak için `docker-compose exec dbt dbt run` komutunu kullanabilirsiniz.
