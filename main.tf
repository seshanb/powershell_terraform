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
    interpreter = ["pwsh", "-Command"]
    working_dir = path.module
  }

  depends_on = [
    azurerm_resource_group.example,
  ]
}

output "random_value_output" {
  value = file("random_output.txt")
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

resource "null_resource" "run_python_script" {
  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = "python my_script.py"
  }
}

data "external" "python_output" {
  depends_on = [null_resource.run_python_script]

  program = ["python", "my_script.py"]
}

output "python_result" {
  value = data.external.python_output.result
}
