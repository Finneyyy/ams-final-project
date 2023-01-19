resource "local_file" "public_inventory" {
  filename = "./inventory/publicIPs.ini"
  content  = "output.rds_endpoint"
}