
# resource for generating random adminUser
resource "random_pet" "adminUser"{
  length    = 2
  separator = ""
} 

# resource for generating random adminUser
resource "random_pet" "rg-name"{
  prefix          = var.resource_group_name_prefix
}

# resource for generating random password
resource "random_string" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

# resource group for vm
resource "azurerm_resource_group" "rg" {
  name      = random_pet.rg-name.id
  location  = var.resource_group_location
  tags      = var.rg_tags
}


# Create virtual network
resource "azurerm_virtual_network" "myterraformnetwork" {
  name                = "${var.vm_name}-vnet"
  address_space       = ["10.0.0.0/21"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Create subnet
resource "azurerm_subnet" "myterraformsubnet" {
  name                 = "${var.vm_name}-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.myterraformnetwork.name
  address_prefixes     = ["10.0.0.0/24"]
}

# Create public IPs
resource "azurerm_public_ip" "myterraformpublicip" {
  name                = "${var.vm_name}-PIP"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "myterraformnsg" {
  name                = "${var.vm_name}-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "rdp"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range	       = "*"
    destination_port_range     = "3389"
    source_address_prefix      = var.my_home_pip
    destination_address_prefix = "*"
  }
}

# Create network interface
resource "azurerm_network_interface" "myterraformnic" {
  name                = "vm_one_NIC"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "myNicConfiguration"
    subnet_id                     = azurerm_subnet.myterraformsubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.myterraformpublicip.id
  }
}


# Create virtual machine
resource "azurerm_windows_virtual_machine" "vmOne" {
  name                = "vmOne"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_F2"
  admin_username      = "${random_pet.adminUser.id}"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.myterraformnic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}

# Create public IPs
#resource "azurerm_public_ip" "vmtwopip" {
#  name                = "vmtwo-PIP"
#  location            = azurerm_resource_group.rg.location
#  resource_group_name = azurerm_resource_group.rg.name
#  allocation_method   = "Dynamic"
#}

# Create network interface
resource "azurerm_network_interface" "vm_two_nic" {
  name                = "vm_two_NIC"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "VmTwoNicConfiguration"
    subnet_id                     = azurerm_subnet.myterraformsubnet.id
    private_ip_address_allocation = "Dynamic"
 }
}

# Connect the security group to the subnet
resource "azurerm_subnet_network_security_group_association" "vm_two_nsg_subnet_assoc" {
  subnet_id			= azurerm_subnet.myterraformsubnet.id
  network_security_group_id	= azurerm_network_security_group.myterraformnsg.id
}

# Create virtual machine
resource "azurerm_windows_virtual_machine" "vmTwo" {
  name                = "vmTwo"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_F2"
  admin_username      = "${random_pet.adminUser.id}"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.vm_two_nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}


