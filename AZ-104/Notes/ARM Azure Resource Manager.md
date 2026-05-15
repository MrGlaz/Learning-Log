
Configuration et déploiement avec fichier JSON

Structure d'un modèle
- **schema** *obligatoire* : Emplacement du schéma JSON obligatoire
- **contentVersion** *obligatoire* : Version obligatoire du modèle
- **apiProfile** *faculatif* : Collection des versions d'API
- **parameters** *faculatif* : Valeurs fournies au déploiement (limite de 256 par modèle)
- **variables** *faculatif* : Valeurs simplifiant les expressions
- **functions** *faculatif* : Fonctions utilisateur du modèle
- **resources** *obligatoire* : Éléments réels à déployer
- **output** *faculatif* : Valeurs retournées après déploiement
-
**Les fonctions :** Savoir à quoi servent des fonctions comme `resourceId()`, `concat()` ou `parameters()`.

Resource Manager orchestre le déploiement des ressources afin qu’elles soient créées dans le bon ordre.


## Comment l'utiliser selon les besoins ?

### A. Pour un déploiement rapide et fiable

Si tu dois répliquer un environnement de test en production, n'essaie pas de te souvenir de chaque case cochée dans le portail.

- **Action :** Utilise la fonction **"Exporter le modèle"** depuis un groupe de ressources existant, nettoie le JSON, et réutilise-le.

### B. Pour la standardisation (Gouvernance)

Si ton entreprise impose que tous les comptes de stockage soient en zone de redondance géographique (GRS).

- **Action :** Crée un modèle ARM où la valeur `sku` est fixée sur `Standard_GRS` et distribue ce modèle à ton équipe.

### C. Déploiement via CLI ou PowerShell

C'est là que le module précédent se connecte à celui-ci. Tu utiliseras tes outils de ligne de commande pour envoyer le fichier JSON à Azure.

- **Azure CLI :** `az deployment group create --resource-group MonRG --template-file azuredeploy.json`
- **PowerShell :** `New-AzResourceGroupDeployment -ResourceGroupName MonRG -TemplateFile .\azuredeploy.json`


**Piège AZ-104 :** L'examen peut te montrer un modèle où une ressource manque d'une dépendance (`dependsOn`). Si tu essaies de créer une VM avant son interface réseau, le déploiement échoue.


## Informations utiles
Intégrer modèles ARM dans le CI/CD (comme Azure Pipelines)

## Linked templates

- **Modulariser :** Créer un modèle standard pour un VNet, un autre pour une VM, et les réutiliser dans plusieurs projets.
- **Dépasser les limites :** Un fichier ARM est limité à **4 Mo**. En le scindant, tu contournes cette restriction.
- **Faciliter la maintenance :** Si la configuration de sécurité de tes comptes de stockage change, tu ne modifies que le "petit" modèle lié au stockage, pas tous tes scripts de déploiement.

Le modèle **Principal** (Main) contient une ressource spéciale de type `Microsoft.Resources/deployments`. Au lieu de décrire une VM, il pointe vers l'URL d'un autre fichier JSON.

### La structure type :

Dans ton fichier `mainTemplate.json`, tu auras ceci :

JSON

```
"resources": [
  {
    "type": "Microsoft.Resources/deployments",
    "apiVersion": "2021-04-01",
    "name": "linkedDeployment",
    "properties": {
      "mode": "Incremental",
      "templateLink": {
        "uri": "https://mystorage.blob.core.windows.net/templates/vnet.json",
        "contentVersion": "1.0.0.0"
      }
    }
  }
]
```

- **Le problème :** Azure Resource Manager doit pouvoir "lire" ton modèle lié via une URL HTTP/HTTPS. Si tu mets ton script sur un compte de stockage privé, Azure ne pourra pas y accéder.
- **La solution :** Le **jeton [[SAS]]** (Shared Access Signature). C'est une clé temporaire ajoutée à l'URL qui donne un droit de lecture à Azure uniquement pendant le temps du déploiement.
- **En pratique :** Tu génères une URL du type `https://.../vnet.json?sv=2019...&sig=...`. Le modèle principal utilise cette URL sécurisée pour récupérer le code du modèle lié.

### Comment l'utiliser selon les besoins ?

- **Scénario A (Développement) :** Tu as une équipe réseau et une équipe système. L'équipe réseau gère le modèle `vnet.json`. Toi, tu crées le `main.json` qui appelle leur travail. Chacun sa responsabilité.
- **Scénario B (Sécurité) :** Tu ne veux pas que tes schémas d'infrastructure soient publics sur GitHub. Tu les stockes dans un **Azure Storage Account** verrouillé et tu utilises les jetons SAS pour permettre le déploiement.
- En Bicep, les "modèles liés" s'appellent simplement des **Modules**. Tu n'as pas besoin de les héberger sur une URL ou de gérer des jetons SAS ; il suffit de pointer vers le fichier local (ex: `module stg './storage.bicep' = { ... }`) et Azure s'occupe du reste.

### Ajouter des ressources au modèle
Fournisseur de ressource `Microsoft.Storage`
L'un des types de ce fournisseur est `storageAccount`
Le type s'affiche donc : `Microsoft.Storage/storageAccounts`

Liste des fournisseurs : https://learn.microsoft.com/fr-fr/azure/azure-resource-manager/management/azure-services-resource-providers

Fournisseur de ress > type de ress > propriétés > valeur


### Paramètres d'un modèle

Les propriétés disponibles pour un paramètre sont les suivantes :

```
"parameters": {
  "<parameter-name>": {
    "type": "<type-of-parameter-value>",
    "defaultValue": "<default-value-of-parameter>",
    "allowedValues": [
      "<array-of-allowed-values>"
    ],
    "minValue": <minimum-value-for-int>,
    "maxValue": <maximum-value-for-int>,
    "minLength": <minimum-length-for-string-or-array>,
    "maxLength": <maximum-length-for-string-or-array-parameters>,
    "metadata": {
      "description": "<description-of-the-parameter>"
    }
  }
}
```

Les types de paramètres autorisés sont les suivants :
-  chaîne
-  secureString
-  entiers
-  booléen
-  objet
-  secureObject
-  tableau

- Utilisez des paramètres qui varient en fonction de l’environnement, par exemple, la référence SKU, la taille ou la capacité.
- Utilisez aussi des paramètres pour les noms de ressources que vous voulez spécifier vous-même afin d’en faciliter l’identification ou pour suivre les conventions de nommage internes.
- Fournissez une description pour chaque paramètre et utilisez des valeurs par défaut chaque fois que c’est possible.
- Pour des raisons de sécurité, ne codez jamais rien en dur et ne spécifiez pas de valeurs par défaut pour les noms d’utilisateur et/ou les mots de passe dans les modèles. 
- Utilisez toujours des paramètres pour les noms d’utilisateur et les mots de passe (ou secrets).
- Utilisez _secureString_ pour tous les mots de passe et secrets. Si vous transmettez des données sensibles dans un objet JSON, utilisez le type _secureObject_. Les paramètres de modèle avec les types _secureString_ ou _secureObject_ ne peuvent pas être lus ni collectés après le déploiement de la ressource.

Quand vous déployez le modèle modifié avec une partie `parameters`, vous pouvez fournir une valeur pour le paramètre. Notez la dernière ligne de la commande suivante :

```
templateFile="azuredeploy.json"
az deployment group create --name testdeployment1 --template-file $templateFile --parameters storageAccountType=Standard_LRS
```

## Sorties d’un modèle ARM

Dans la section outputs de votre modèle ARM, vous pouvez spécifier les valeurs qui sont retournées après un déploiement réussi. Voici les éléments qui composent la section Sorties.

```
"outputs": {
  "<output-name>": {
    "condition": "<boolean-value-whether-to-output-value>",
    "type": "<type-of-output-value>",
    "value": "<output-value-expression>",
    "copy": {
      "count": <number-of-iterations>,
      "input": <values-for-the-variable>
    }
  }
}
```

### Utiliser des sorties dans un modèle ARM

Voici un exemple pour produire en sortie les points de terminaison du compte de stockage :

```
"outputs": {
  "storageEndpoint": {
    "type": "object",
    "value": "[reference('learntemplatestorage123').primaryEndpoints]"
  }
}
```

Notez la partie `reference` de l’expression. Cette fonction obtient l’état d’exécution du compte de stockage.

## Redéployer un modèle ARM

Les modèles ARM sont _idempotents_, ce qui signifie que vous pouvez redéployer le modèle dans le même environnement et que, si rien ne change dans le modèle, rien ne change dans l’environnement. 
Si une modification est apportée au modèle (par exemple, vous modifiez une valeur de paramètre), seule cette modification est déployée.
Votre modèle peut contenir toutes les ressources dont vous avez besoin pour votre solution Azure et vous pouvez réexécuter sans danger un modèle. Les ressources sont créées seulement si elles n’existent pas déjà et ne sont mises à jour qu’en cas de modification.