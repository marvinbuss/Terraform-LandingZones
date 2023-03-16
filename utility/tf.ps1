get-childItem '/Users/uday/git/uday31in/AzOps/sparta-1 (sparta-1)/' -Filter *policydefinitions*.json -Recurse | % {
    $name = $_.Name;
    $policy = get-content $_ | jq '.parameters.input.value.properties | del(.metadata.createdBy , .metadata.updatedBy)'
    $destination = join-path  "/Users/uday/git/uday31in/Terraform-LandingZones/code/lib/policy_definitions/" -ChildPath ("policy_definition_" + ($($name.ToString() -replace 'microsoft.authorization_policydefinitions-'))).replace(".parameters","").replace("-","_")
    $policy > $destination
}



get-childItem '/Users/uday/git/uday31in/AzOps/sparta-1 (sparta-1)/' -Filter *policySetdefinitions*.json -Recurse | % {
    $name = $_.Name;
    $policySet = get-content $_ | jq '.parameters.input.value.properties | del(.metadata.createdBy, .metadata.updatedBy)' | ConvertFrom-Json
    $destination = join-path  "/Users/uday/git/uday31in/Terraform-LandingZones/code/lib/policy_set_definitions" -ChildPath ("policy_set_definition_" + ($($name.ToString() -replace 'microsoft.authorization_policysetdefinitions-'))).replace(".parameters","").replace("-","_")

    $policySet.policyDefinitions |% {
        $guidPattern = "\b[A-Fa-f0-9]{8}-[A-Fa-f0-9]{4}-[A-Fa-f0-9]{4}-[A-Fa-f0-9]{4}-[A-Fa-f0-9]{12}\b"
        if ($_.policyDefinitionId  -notmatch $guidPattern) {
            Write-Verbose "Custom Policy Definition: $($_.policyDefinitionId)"
            $_.policyDefinitionId = '${root_scope_resource_id}' + $_.policyDefinitionId
        }
    }
    $policySet |  ConvertTo-Json -Depth 100 > $destination
}

get-childItem '/Users/uday/git/uday31in/AzOps/sparta-1 (sparta-1)/' -Filter *policyassignments*.json -Recurse | % {
    $name = $_.Name;
    $policyAssignment = get-content $_ | jq -f ./utility/policyassignment.jq
    $destination = join-path  "/Users/uday/git/uday31in/Terraform-LandingZones/code/lib/policy_asignments" -ChildPath ("policy_assignment_" + ($($name.ToString() -replace 'microsoft.authorization_policyassignments-'))).replace(".parameters","").replace("-","_")
    $($name.ToString() -replace 'microsoft.authorization_')
    $policyAssignment > $destination
}