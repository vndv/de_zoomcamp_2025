-- Seed data containing water names.
MODEL (
  name bronze.taxi_zone_lookup,
  kind SEED (
    path '../../seeds/taxi_zone_lookup.csv',
  ),
  columns (
    locationid Int32, 
    borough String, 
    zone String,
    service_zone String
)
);