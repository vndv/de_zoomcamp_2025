/**
 * TODO: figure out if it is possible to get Iceberg to create these tables instead of needing to know the schema here.
 * See also https://github.com/trinodb/trino/issues/20419
 *
 * This is taken from https://github.com/trinodb/trino/blob/444/testing/trino-product-tests-launcher/src/main/resources/docker/presto-product-tests/conf/environment/singlenode-spark-iceberg-jdbc-catalog/create-table.sql
 */

CREATE TABLE iceberg_namespace_properties (
    catalog_name VARCHAR(255) NOT NULL,
    namespace VARCHAR(255) NOT NULL,
    property_key VARCHAR(5500),
    property_value VARCHAR(5500),
    PRIMARY KEY (catalog_name, namespace, property_key)
);

CREATE TABLE iceberg_tables (
    catalog_name VARCHAR(255) NOT NULL,
    table_namespace VARCHAR(255) NOT NULL,
    table_name VARCHAR(255) NOT NULL,
    metadata_location VARCHAR(5500),
    previous_metadata_location VARCHAR(5500),
    PRIMARY KEY (catalog_name, table_namespace, table_name)
);
