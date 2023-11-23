locals {
  prefix = "${lower(var.prefix)}-${var.environment}"

  azure_policies_library_path = "${path.root}/AzurePolicyDefinitions" #
  template_variables          = {}
}

locals {
  # Load file paths
  azure_policies_filepaths_json = local.azure_policies_library_path == "" ? [] : tolist(fileset(local.azure_policies_library_path, "**/*.{json,json.tftpl}"))
  azure_policies_filepaths_yaml = local.azure_policies_library_path == "" ? [] : tolist(fileset(local.azure_policies_library_path, "**/*.{yml,yml.tftpl,yaml,yaml.tftpl}"))

  # Load file content
  azure_policy_definitions_json = {
    for filepath in local.azure_policies_filepaths_json :
    filepath => jsondecode(templatefile("${local.azure_policies_library_path}/${filepath}", local.template_variables))
  }
  azure_policy_definitions_yaml = {
    for filepath in local.azure_policies_filepaths_yaml :
    filepath => yamldecode(templatefile("${local.azure_policies_library_path}/${filepath}", local.template_variables))
  }

  # Merge data
  azure_policy_definitions = merge(
    local.azure_policy_definitions_json,
    local.azure_policy_definitions_yaml
  )
}

locals {
  # Load Custom Azure Policy Definitions from files
  policy_definitions_list = flatten([
    for key, value in local.azure_policy_definitions:
    try(value.variables.policies.policyDefinitions, [])
  ])
  policy_definitions_map = {
    for value in local.policy_definitions_list :
    try(value.name, "") => value
  }

  # Load policy resources
  policy_resources = flatten([
    for key, value in local.azure_policy_definitions:
    try(value.resources, [])
  ])

  # Load Custom Azure Policy Set Definitions from files
  policy_set_definitions_list = [
    for index, value in local.policy_resources:
    lower(try(value.type, "")) == lower("Microsoft.Authorization/policySetDefinitions") ? value : null
  ]
  policy_set_definitions_map = {
    for index, value in compact(local.policy_set_definitions_list):
    try(value.name, "") => value
  }
}
