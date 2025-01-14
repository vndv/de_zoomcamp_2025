## 1. Configure Developer Environment


<summary>Use devcontainer (locally)</summary>
<p>

1. Install [Docker](https://docs.docker.com/desktop/#download-and-install) on your local machine.

1. Install devcontainer CLI:

    Open command palette (CMD + SHIFT+ P) type *Install devcontainer CLI*


    Install devcontainer extension


1. Next build and open dev container:

    ```bash
    # build dev container
    devcontainer build .

    # up dev container
    devcontainer up
    ```
    open dev container (CMD + SHIFT+ P) type Dev Containers: Attach to running container then choose the container.
    In new opened window choose folder /workspaces/

</p>

Verify you are in a development container by running commands:

```bash
terraform -v

yc --version

```

## 2. Deploy Infrastructure to Yandex.Cloud with Terraform

1. We will deploy:
    - [Yandex Managed Service for ClickHouse](https://cloud.yandex.com/en/services/managed-clickhouse)
    
    ![](./docs/clickhouse_management_console.gif)

1. Configure `yc` CLI: [Getting started with the command-line interface by Yandex Cloud](https://cloud.yandex.com/en/docs/cli/quickstart#install)

    ```bash
    yc init
    ```

1. Populate `.env` file

    `.env` is used to store secrets as environment variables.

    Copy template file [.env.template](./.env.template) to `.env` file:
    ```bash
    cp .env.template .env
    ```

    Open file in editor and set your own values.


1. Set environment variables:

    ```bash
    export YC_TOKEN=$(yc iam create-token)
    export YC_CLOUD_ID=$(yc config get cloud-id)
    export YC_FOLDER_ID=$(yc config get folder-id)
    export TF_VAR_folder_id=$(yc config get folder-id)
    export $(xargs < .env)
    ```

1. Deploy using Terraform

    Configure YC Terraform provider:
    

    Get familiar with Cloud Infrastructure: [main.tf](./main.tf) and [variables.tf](./variables.tf)

    ```bash
    terraform init
    terraform validate
    terraform fmt
    terraform plan
    terraform apply
    ```

    Store terraform output values as Environment Variables:

    ```bash
    export CLICKHOUSE_HOST=$(terraform output -raw clickhouse_host_fqdn)
    ```

    [EN] Reference: [Getting started with Terraform by Yandex Cloud](https://cloud.yandex.com/en/docs/tutorials/infrastructure-management/terraform-quickstart)
    
    [RU] Reference: [Начало работы с Terraform by Yandex Cloud](https://cloud.yandex.ru/docs/tutorials/infrastructure-management/terraform-quickstart)

## 3. Check database connection

[Configure JDBC (DBeaver) connection](https://cloud.yandex.ru/docs/managed-clickhouse/operations/connect#connection-ide):

```bash
terraform output -raw clickhouse_host_fqdn
```

```
port=8443
ssl=true
```

user and password in .env file

```bash
terraform destroy

```