# my_script.ps1
$randomValue = Get-Random -Minimum 100 -Maximum 1000
$randomValue | Out-File powershell_output.txt
