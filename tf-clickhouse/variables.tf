variable "folder_id" {
  description = "Folder ID"
  type        = string
}

variable "clickhouse_password" {
  description = "Clickhouse admin password"
  type        = string
  sensitive   = true
}

output "clickhouse_host_fqdn" {
  value = resource.yandex_mdb_clickhouse_cluster.clickhouse_dwh.host[0].fqdn
}

