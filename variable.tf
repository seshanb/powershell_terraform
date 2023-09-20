variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  source      = "resourcegroup.list_resource_group_names"
}
