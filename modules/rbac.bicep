param identityName string

resource identity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' existing = {
  name: identityName
}

resource contributor 'Microsoft.Authorization/roleDefinitions@2018-01-01-preview' existing = {
  scope: subscription()
  name: 'eb80d08b-93b7-4516-b157-aceebdb9e702'
}

resource rbac 'Microsoft.Authorization/roleAssignments@2020-04-01-preview' = {
  name: guid(identity.id, contributor.id)
  properties: {
    roleDefinitionId: contributor.id
    principalId: identity.properties.principalId
    principalType: 'ServicePrincipal'
  }
}
