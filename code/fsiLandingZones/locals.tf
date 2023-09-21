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
  azure_policies_definitions_json = {
    for filepath in local.azure_policies_filepaths_json :
    filepath => jsondecode(templatefile("${local.azure_policies_library_path}/${filepath}", local.template_variables))
  }
  azure_policies_definitions_yaml = {
    for filepath in local.azure_policies_filepaths_yaml :
    filepath => yamldecode(templatefile("${local.azure_policies_library_path}/${filepath}", local.template_variables))
  }

  # Merge data
  azure_policies_definitions = merge(
    local.azure_policies_definitions_json,
    local.azure_policies_definitions_yaml
  )
}

locals {
  # Load Custom Azure Policy Definitions from files
  policy_definitions_list = flatten([
    for key, value in local.azure_policies_definitions:
    try(value.variables.policies.policyDefinitions, [])
  ])
  policy_definitions_map = {
    for value in local.policy_definitions_list :
    try(value.name, "") => value
  }
}
