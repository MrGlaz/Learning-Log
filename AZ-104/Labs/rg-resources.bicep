resource exercicedeployARM 'Microsoft.Storage/storageAccounts@2025-01-01' = {
  name: 'exercicedeployARM'
  tags: {
    displayName: 'exercicedeployARM'
  }
  location: resourceGroup().location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}
