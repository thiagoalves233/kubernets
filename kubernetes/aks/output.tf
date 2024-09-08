##### DEV

output "client_certificate" {
  value = azurerm_kubernetes_cluster.dev-qa-aks-backend.kube_config.0.client_certificate
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.dev-qa-aks-backend.kube_config_raw
}

### PROD

output "prod-client_certificate" {
  value = azurerm_kubernetes_cluster.prod-aks-backend.kube_config.0.client_certificate
}

output "prod-kube_config" {
  value = azurerm_kubernetes_cluster.prod-aks-backend.kube_config_raw
}