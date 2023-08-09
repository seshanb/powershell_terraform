resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = "East US"
}

data "local_file" "tfstate" {
  filename = "${path.module}/terraform.tfstate"
}

data "terraform_remote_state" "stack" {
  backend = "local"

  config = {
    path = data.local_file.tfstate.content != "" ? "${path.module}/terraform.tfstate" : "${path.module}/.terraform/terraform.tfstate"
  }
}
