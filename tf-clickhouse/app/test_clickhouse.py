import clickhouse_connect
from clickhouse_connect.driver.exceptions import ClickHouseError

from clickhouse import ClickhouseResource


def test_connection():
    """Test ClickHouse connection using clickhouse-connect"""
    config = {
        "db_host": "your_host",
        "db_user": "admin",
        "db_password": "clickhouse",
        "db_name": "default",
    }

    print(f"\nTrying connection with config: {config}")
    try:
        # Create resource
        clickhouse = ClickhouseResource(**config)
        print(f"Connecting with URI: {clickhouse.uri}")

        # Get client connection
        client = clickhouse.get_connection()

        # Test basic query
        version = client.command("SELECT version()")
        print(f"Connection successful! ClickHouse version: {version}")

        # Test a simple query
        result = client.command("SELECT 1 as test")
        print(f"Test query result: {result}")

        return client

    except ClickHouseError as e:
        print(f"ClickHouse error: {str(e)}")
        print(f"Error code: {getattr(e, 'code', 'unknown')}")
        raise
    except Exception as e:
        print(f"Connection failed with error: {str(e)}")
        print(f"Error type: {type(e)}")
        if hasattr(e, "__cause__"):
            print(f"Cause: {e.__cause__}")
        raise


def test_queries(client: clickhouse_connect.driver.client.Client):
    """Test various queries to verify connection is working"""
    try:
        # Test basic queries
        tests = [
            "SELECT 1",
            "SELECT version()",
            "SHOW DATABASES",
            "SELECT name, engine FROM system.databases",
        ]

        for query in tests:
            print(f"\nExecuting: {query}")
            try:
                result = client.command(query)
                print(f"Result: {result}")
            except Exception as e:
                print(f"Query failed: {str(e)}")

    except Exception as e:
        print(f"Query execution failed: {str(e)}")
        raise


if __name__ == "__main__":
    try:
        # Test regular connection
        print("\n=== Testing ClickHouse Connection ===")
        client = test_connection()

        # Test queries if connection successful
        if client:
            print("\n=== Testing ClickHouse Queries ===")
            test_queries(client)

    except Exception as e:
        print(f"\nFinal error: {e}")
    finally:
        print("\n=== Test Complete ===")
