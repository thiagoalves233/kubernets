module "source" {
  source = "../source"
}

resource "azurerm_network_security_group" "sg-backend" {
  name                = "SecurityGroup-Backend"
  location            = module.source.resource-group-aks-location
  resource_group_name = module.source.resource-group-aks-name
  # security_rule {
  #   name                       = "test123"
  #   priority                   = 100
  #   direction                  = "Inbound"
  #   access                     = "Allow"
  #   protocol                   = "Tcp"
  #   source_port_range          = "*"
  #   destination_port_range     = "*"
  #   source_address_prefix      = "*"
  #   destination_address_prefix = "*"
  # }
  tags = {
    environment = "dev-qa"
  }
}

resource "azurerm_virtual_network" "vnet-backend" {
  name                = "backend-vnet"
  location            = module.source.resource-group-aks-location
  resource_group_name = module.source.resource-group-aks-name
  address_space       = ["172.0.0.0/13"]
  tags = {
    environment = "dev-qa"
  }
}

resource "azurerm_subnet" "backend-subnet" {
  name                  = "backend-subnet"
  virtual_network_name  = azurerm_virtual_network.vnet-backend.name
  resource_group_name   = module.source.resource-group-aks-name
  address_prefixes      = ["172.1.0.0/20"]
}

resource "azurerm_subnet_network_security_group_association" "backend-subnet" {
  subnet_id                 = azurerm_subnet.backend-subnet.id
  network_security_group_id = azurerm_network_security_group.sg-backend.id
}


### PROD


resource "azurerm_network_security_group" "prod-sg-backend" {
  name                = "prod-SecurityGroup-Backend"
  location            = module.source.prod-resource-group-aks-location
  resource_group_name = module.source.prod-resource-group-aks-name
  # security_rule {
  #   name                       = "test123"
  #   priority                   = 100
  #   direction                  = "Inbound"
  #   access                     = "Allow"
  #   protocol                   = "Tcp"
  #   source_port_range          = "*"
  #   destination_port_range     = "*"
  #   source_address_prefix      = "*"
  #   destination_address_prefix = "*"
  # }
  tags = {
    environment = "prod"
  }
}

resource "azurerm_virtual_network" "prod-vnet-backend" {
  name                = "prod-backend-vnet"
  location            = module.source.prod-resource-group-aks-location
  resource_group_name = module.source.prod-resource-group-aks-name
  address_space       = ["10.0.0.0/13"]
  tags = {
    environment = "prod"
  }
}

resource "azurerm_subnet" "prod-backend-subnet" {
  name                  = "prod-backend-subnet"
  virtual_network_name  = azurerm_virtual_network.prod-vnet-backend.name
  resource_group_name   = module.source.prod-resource-group-aks-name
  address_prefixes      = ["10.1.0.0/20"]
}

resource "azurerm_subnet_network_security_group_association" "prod-backend-subnet" {
  subnet_id                 = azurerm_subnet.prod-backend-subnet.id
  network_security_group_id = azurerm_network_security_group.prod-sg-backend.id
}
