# Load the built-in archetype definitions from the internal library path
locals {
  archetype_definitions_json = tolist(fileset(local.library_path, "**/archetype_definition_*.{json,json.tftpl}"))
  archetype_definitions_yaml = tolist(fileset(local.library_path, "**/archetype_definition_*.{yml,yml.tftpl,yaml,yaml.tftpl}"))
}
# Load the archetype definition extensions
locals {
  extend_archetype_definitions_json = tolist(fileset(local.library_path, "**/archetype_extension_*.{json,json.tftpl}"))
  extend_archetype_definitions_yaml = tolist(fileset(local.library_path, "**/archetype_extension_*.{yml,yml.tftpl,yaml,yaml.tftpl}"))
}

# Load the archetype definition exclusions
locals {
  exclude_archetype_definitions_json = tolist(fileset(local.library_path, "**/archetype_exclusion_*.{json,json.tftpl}"))
  exclude_archetype_definitions_yaml = tolist(fileset(local.library_path, "**/archetype_exclusion_*.{yml,yml.tftpl,yaml,yaml.tftpl}"))
}

# Create datasets containing all built-in and custom archetype definitions from each source and file type
locals {
  archetype_definitions_dataset_from_json = {
    for filepath in local.archetype_definitions_json :
    filepath => jsondecode(templatefile("${local.library_path}/${filepath}", local.template_file_vars))
  }
  archetype_definitions_dataset_from_yaml = {
    for filepath in local.archetype_definitions_yaml :
    filepath => yamldecode(templatefile("${local.library_path}/${filepath}", local.template_file_vars))
  }
  extend_archetype_definitions_dataset_from_json = {
    for filepath in local.extend_archetype_definitions_json :
    filepath => jsondecode(templatefile("${local.library_path}/${filepath}", local.template_file_vars))
  }
  extend_archetype_definitions_dataset_from_yaml = {
    for filepath in local.extend_archetype_definitions_yaml :
    filepath => yamldecode(templatefile("${local.library_path}/${filepath}", local.template_file_vars))
  }
  exclude_archetype_definitions_dataset_from_json = {
    for filepath in local.exclude_archetype_definitions_json :
    filepath => jsondecode(templatefile("${local.library_path}/${filepath}", local.template_file_vars))
  }
  exclude_archetype_definitions_dataset_from_yaml = {
    for filepath in local.exclude_archetype_definitions_yaml :
    filepath => yamldecode(templatefile("${local.library_path}/${filepath}", local.template_file_vars))
  }
}

# Convert the archetype datasets into maps
locals {
  archetype_definitions_map_from_json = {
    for key, value in local.archetype_definitions_dataset_from_json :
    keys(value)[0] => values(value)[0]
  }
  archetype_definitions_map_from_yaml = {
    for key, value in local.archetype_definitions_dataset_from_yaml :
    keys(value)[0] => values(value)[0]
  }
  extend_archetype_definitions_map_from_json = {
    for key, value in local.extend_archetype_definitions_dataset_from_json :
    keys(value)[0] => values(value)[0]
  }
  extend_archetype_definitions_map_from_yaml = {
    for key, value in local.extend_archetype_definitions_dataset_from_yaml :
    keys(value)[0] => values(value)[0]
  }
  exclude_archetype_definitions_map_from_json = {
    for key, value in local.exclude_archetype_definitions_dataset_from_json :
    keys(value)[0] => values(value)[0]
  }
  exclude_archetype_definitions_map_from_yaml = {
    for key, value in local.exclude_archetype_definitions_dataset_from_yaml :
    keys(value)[0] => values(value)[0]
  }
}

# Merge the archetype maps into a single map, and extract the desired archetype definition.
# If duplicates exist due to a custom archetype definition being
# defined to override a built-in definition, this is handled by
# merging the custom archetypes after the built-in archetypes.
locals {
  base_archetype_definitions = merge(
    local.archetype_definitions_map_from_json,
    local.archetype_definitions_map_from_yaml,
  )
}

# Merge the extend archetype maps into a single map.
locals {
  extend_archetype_definitions = merge(
    local.extend_archetype_definitions_map_from_json,
    local.extend_archetype_definitions_map_from_yaml,
  )
}

# Merge the exclude archetype maps into a single map.
locals {
  exclude_archetype_definitions = merge(
    local.exclude_archetype_definitions_map_from_json,
    local.exclude_archetype_definitions_map_from_yaml,
  )
}

# Add or remove configuration settings from an existing [built-in] or custom archetype definition.
# Get full description context in github #issue_72
locals {
  archetype_definitions = {
    for adk, adv in local.base_archetype_definitions :
    adk => {
      policy_assignments = [
        for value in distinct(concat(
          adv.policy_assignments,
          try(local.extend_archetype_definitions["extend_${adk}"].policy_assignments, local.empty_list)
        )) : value
        if contains(try(local.exclude_archetype_definitions["exclude_${adk}"].policy_assignments, local.empty_list), value) != true
      ],
      policy_definitions = [
        for value in distinct(concat(
          adv.policy_definitions,
          try(local.extend_archetype_definitions["extend_${adk}"].policy_definitions, local.empty_list)
        )) : value
        if contains(try(local.exclude_archetype_definitions["exclude_${adk}"].policy_definitions, local.empty_list), value) != true
      ],
      policy_set_definitions = [
        for value in distinct(concat(
          adv.policy_set_definitions,
          try(local.extend_archetype_definitions["extend_${adk}"].policy_set_definitions, local.empty_list)
        )) : value
        if contains(try(local.exclude_archetype_definitions["exclude_${adk}"].policy_set_definitions, local.empty_list), value) != true
      ],
      role_definitions = [
        for value in distinct(concat(
          adv.role_definitions,
          try(local.extend_archetype_definitions["extend_${adk}"].role_definitions, local.empty_list)
        )) : value
        if contains(try(local.exclude_archetype_definitions["exclude_${adk}"].role_definitions, local.empty_list), value) != true
      ],
      archetype_config = {
        parameters = merge(
          adv.archetype_config.parameters,
          try(local.extend_archetype_definitions["extend_${adk}"].archetype_config.parameters, local.empty_map)
        )
        access_control = merge(
          adv.archetype_config.access_control,
          try(local.extend_archetype_definitions["extend_${adk}"].archetype_config.access_control, local.empty_map)
        )
      }
    }
  }
}

# Extract the required archetype_definition value for the current context
locals {
  archetype_definition = local.archetype_definitions[local.archetype_id]
}
