{
    "name": .parameters.input.value.name,
    "type": .parameters.input.value.type,
    "apiVersion": "2019-09-01",
    "properties": {
        "displayName": .parameters.input.value.properties.displayName,
        "description": .parameters.input.value.properties.description,
        "notScopes": .parameters.input.value.properties.notScopes,
        "parameters": .parameters.input.value.properties.parameters,
        "policyDefinitionId": "${root_scope_resource_id}/providers/Microsoft.Authorization/policySetDefinitions/",
        "nonComplianceMessages": .parameters.input.value.properties.nonComplianceMessages,
        "scope": "${current_scope_resource_id}",
        "enforcementMode": .parameters.input.value.properties.enforcementMode,
    },
    "location": "${default_location}",
    "identity": .identity
}
| .properties.policyDefinitionId += .name