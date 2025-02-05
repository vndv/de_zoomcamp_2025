-- SQLMesh model definition for ClickHouse

MODEL (
  name silver.dim_zones,
  kind FULL,
  cron '@daily',
  owner 'imatveev',
  start '2023-01-01',
  tags ['seeds']
);

select 
    locationid, 
    borough, 
    zone, 
    replace(service_zone,'Boro','Green') as service_zone 
from bronze.taxi_zone_lookup;