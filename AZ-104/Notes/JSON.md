## Erreur de syntaxe JSON (Common Pitfalls)
Lors de l'écriture de templates ARM (.json), VS Code peut retourner l'erreur `Expected a JSON object, array or literal`.

### Les causes identifiées :
1. **Commentaires interdits :** Le format JSON standard ne supporte pas les commentaires avec `#` ou `//`. 
2. **Multiples objets racines :** Un fichier JSON doit contenir **un seul** bloc `{}` principal. On ne peut pas mettre deux définitions séparées dans le même fichier.

### Actions futures :
- Supprimer les commentaires hors du bloc JSON.
- Utiliser **Bicep** pour les futurs déploiements (syntaxe plus proche de la programmation, supporte les commentaires).

### Commande de validation :
Pour vérifier un template sans le déployer :
`az deployment group validate --resource-group MonRG --template-file storage-account.json`


## Commandes Azure CLI
Pour déployer ce template "Lab : Déploiement Storage Account" , j'utilise la commande suivante dans le terminal :
```azurecli
templateFile="storage-account.json"
az deployment group create \
  --name testdeployment1 \
  --resource-group MonResourceGroup \
  --template-file $templateFile \
  --parameters storageAccountType=Standard_LRS