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
    working_dir = path.module
  }

  depends_on = [
    azurerm_resource_group.example,
  ]
}

data "local_file" "random_output_file" {
  filename = "random_output.txt"
}

output "random_value_output" {
  value = data.local_file.random_output_file.content
}
