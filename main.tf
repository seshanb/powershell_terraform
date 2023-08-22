resource "null_resource" "run_python_script" {
  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = "python ${path.module}/my_script.py"
  }
}

resource "null_resource" "run_powershell_script" {
  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command     = "pwsh -File ${path.module}/my_script.ps1"
    working_dir = path.module
  }
}

data "null_data_source" "python_output" {
  inputs = {
    python_output = file("${path.module}/python_output.txt")
  }
}

data "null_data_source" "powershell_output" {
  inputs = {
    powershell_output = file("${path.module}/powershell_output.txt")
  }
}

output "python_result" {
  value = data.null_data_source.python_output.outputs.python_output
}

output "powershell_result" {
  value = data.null_data_source.powershell_output.outputs.powershell_output
}
