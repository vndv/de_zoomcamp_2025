from dataclasses import dataclass

import clickhouse_connect as cc


@dataclass
class ClickhouseResource:
    db_host: str
    db_user: str
    db_password: str
    db_name: str

    def get_connection(self) -> cc.driver.client.Client:
        try:
            client_ch = cc.get_client(
                host=self.db_host,
                port=8443,
                interface='https',
                database=self.db_name,
                username=self.db_user,
                password=self.db_password,
                verify=False,
                connect_timeout=300000,
                query_limit=None,
            )
            print('ClickHouse connection successful')
            return client_ch
        except Exception as err:
            print(f'ClickHouse connection error: {err}')
            print(f'Error type: {type(err)}')
            if hasattr(err, '__cause__'):
                print(f'Cause: {err.__cause__}')
            raise

    @property
    def uri(self) -> str:
        return f'clickhouse://{self.db_user}:{self.db_password}@{self.db_host}:8443/{self.db_name}?verify=false&interface=https'
