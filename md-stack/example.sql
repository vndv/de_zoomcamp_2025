CREATE SCHEMA example.example_s3_schema WITH (location = 's3://warehouse/test');

CALL example.system.register_table(schema_name => 'example_s3_schema', table_name => 'players_games', table_location => 's3://warehouse/chess_players_games_data/players_games');

DROP TABLE example.example_s3_schema.players_games;

CREATE TABLE example.example_s3_schema.employees_test
(
  name varchar,
  salary decimal(10,2)
)
WITH (
  format = 'PARQUET'
);

INSERT INTO example.example_s3_schema.employees_test (name, salary) VALUES ('Sam Evans', 55000);