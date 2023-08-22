resource "null_resource" "run_python_script" {
  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = "python my_script.py"
  }
}

resource "null_resource" "run_powershell_script" {
  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command     = "pwsh -File my_script.ps1"
    working_dir = path.module
  }
}

output "python_result" {
  value = "42"  # Replace with the actual output of your Python script
}

output "powershell_result" {
  value = null_resource.run_powershell_script.triggers.always_run  # Replace with the actual output of your PowerShell script
}
