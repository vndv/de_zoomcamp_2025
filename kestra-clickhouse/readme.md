# Clickhouse Kestra and MinIO

This is an example using Clickhouse as engine Kestra as orchestrator and MinIO for object storage.

## What You Will Learn

- **Kestra**: Master workflow orchestration and scheduling for complex ETL/ELT pipelines.
- **Metabse**: Create interactive dashboards and visualizations to analyze and present your data.
- **SQLMesh**: Transformation framework for SQL
- **MinIO**: Learn about object storage and how it integrates with modern data pipelines, serving as your S3-compatible storage layer. (Using this architecture for a NYC 

<p align='center'>
  <img src='mds.png')
</p>

## Services

### MinIO (Object Storage)
- **Purpose**: Acts as an S3-compatible object storage layer for raw and processed data.
- **What You’ll Learn**:
  - Uploading and managing files via the MinIO Console.
  - Using MinIO as a source and destination for ETL pipelines.
- **Console URL**: [http://localhost:9001](http://localhost:9001)

### Kestra (Workflow Orchestrator)
- **Purpose**: Creating pipeline and orchestrate task.
- **What You’ll Learn**:
  - Uploading data to Minio .
  - Creating tables in Clickhouse.
- **Console URL**: [http://localhost:8080](http://localhost:8080)




## How to Run

1. **Clone the Repository**  
   ```bash
   git clone git@github.com:vndv/de_zoomcamp_2025.git
   cd de_zoomcamp_2025/kestra-clickhouse
   ```

2. **Build & Start Services**
    ``` bash
      docker-compose up -d
    ```

3. **Access Servies**
 - MinIO Console: http://localhost:9001 (user: minio-user, password: minio-password)
 - Kestra UI http://localhost:8080/
 - Clickhouse connect in DBeaver (port:8123, user: default, database: default, password: clickhouse_password)

4. **Minio**
 - Open Minio UI and add secret_key and accsess_key they need to load data into bucket
 - Add region eu-central-1 and restart
 - After create bucket in Kestra pipeline change bucket Access Policy to public 

5. **Kestra**
  - Create minio_kv pipeline
  - Create minio_create_bucket pipeline and then add Access Policy
  - Create minio_taxi pipeline


Stop and remove the containers and network:
```shell
docker-compose down
```
