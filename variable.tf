variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
  source      = "resourcegroup.list_resource_group_names"
}
