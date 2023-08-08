resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = "East US"
}

resource "null_resource" "execute_powershell" {
  provisioner "local-exec" {
    command = <<-EOT
      $randomValue = Get-Random -Minimum 100 -Maximum 1000
      $randomValue | Out-File random_output.txt
    EOT
    interpreter = ["/usr/bin/pwsh", "-Command"]
  }

  depends_on = [
    azurerm_resource_group.example,
  ]
}

output "random_value_output" {
  value = file("random_output.txt")
}

