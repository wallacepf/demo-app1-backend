output "backend_api_url" {
  value = "http://${module.backend.backend_ip[0]}:3030"
}
