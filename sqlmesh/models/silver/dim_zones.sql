/* SQLMesh model definition for ClickHouse */
MODEL (
  name silver.dim_zones,
  kind FULL,
  cron '@daily',
  owner 'imatveev',
  start '2023-01-01',
  tags ['seeds']
);

SELECT
  locationid,
  borough,
  zone,
  replace(service_zone, 'Boro', 'Green') AS service_zone
FROM bronze.taxi_zone_lookup