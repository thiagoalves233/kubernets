module "vnet" {
  source = "../vnet"
}

module "source" {
  source = "../source"
}
#### DEV
resource "azurerm_kubernetes_cluster" "dev-qa-aks-backend" {
  name                = "dev-qa-mm-aks-backend"
  location            = module.source.resource-group-aks-location
  resource_group_name = module.source.resource-group-aks-name
  dns_prefix          = "dev-mm-aks"

  default_node_pool {
      name            = "default"
      node_count      = 1
      vm_size         = "Standard_f8s"
      max_pods        = 250
      os_disk_size_gb = 100
      enable_auto_scaling   = false
      enable_node_public_ip = false
      vnet_subnet_id  = module.vnet.subnet-backend-id
    }
    network_profile {
      network_plugin    = "azure"
      load_balancer_sku = "Standard"
      load_balancer_profile {
        outbound_ip_address_ids = [
          module.vnet.lb-pubicip-backend-id
        ]
      }
    }
    service_principal {
        client_id     = "84d28679-2f09-4464-800a-93d34fde3dda"
        client_secret = "D4D.kslmwNMUNIkf2U6MyupRqLIwi-RVZj"
    }
    role_based_access_control {
       enabled = true
    }
  lifecycle {
    ignore_changes = [
      windows_profile
    ]
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "backend01" {
  name                  = "backend"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.dev-qa-aks-backend.id
  enable_node_public_ip = false
  enable_auto_scaling   = false
  max_pods        = 250
  os_disk_size_gb = 100
  os_type         = "Linux"
  node_count      = 1
  vm_size         = "Standard_f8s"
  mode            = "User"
  vnet_subnet_id  = module.vnet.subnet-backend-id
}


#### PROD
resource "azurerm_kubernetes_cluster" "prod-aks-backend" {
  name                = "prod-mm-aks-backend"
  location            = module.source.prod-resource-group-aks-location
  resource_group_name = module.source.prod-resource-group-aks-name
  dns_prefix          = "prod"

  default_node_pool {
      name            = "default"
      enable_auto_scaling   = true
      min_count       = 1
      max_count       = 10
      node_count      = 1
      vm_size         = "Standard_f8s"
      max_pods        = 200
      os_disk_size_gb = 100
      enable_node_public_ip = false

      vnet_subnet_id  = module.vnet.prod-subnet-backend-id
    }
    network_profile {
      network_plugin    = "azure"
      load_balancer_sku = "Standard"
      load_balancer_profile {
        outbound_ip_address_ids = [
          module.vnet.prod-lb-pubicip-backend-id
        ]
      }
    }
    service_principal {
        client_id     = "84d28679-2f09-4464-800a-93d34fde3dda"
        client_secret = "D4D.kslmwNMUNIkf2U6MyupRqLIwi-RVZj"
    }
    role_based_access_control {
       enabled = true
    }
  lifecycle {
    ignore_changes = [
      windows_profile
    ]
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "prod_backend01" {
  name                  = "backend"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.prod-aks-backend.id
  enable_node_public_ip = false
  enable_auto_scaling   = true
  min_count       = 1
  max_count       = 10
  max_pods        = 200
  os_disk_size_gb = 100
  os_type         = "Linux"
  node_count      = 1
  vm_size         = "Standard_f8s"
  mode            = "User"
  vnet_subnet_id  = module.vnet.prod-subnet-backend-id
}
