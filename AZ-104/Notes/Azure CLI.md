
- **C'est quoi ?** Un outil multiplateforme (Windows, macOS, Linux) basé sur Python. Ses commandes commencent par `az`.

- **Structure :** Utilise une syntaxe "verbe-nom" simplifiée (ex: `az vm create`).

- **Format de sortie :** Retourne principalement du **JSON**, ce qui est idéal pour les développeurs ou les administrateurs habitués aux environnements Linux/Bash.

- **Utilise Azure CLI si :** Tu travailles dans un pipeline de déploiement (CI/CD), si tu es plus à l'aise avec Bash, ou si tu as besoin de scripts légers et rapides à exécuter.
    - _Exemple :_ Déployer un cluster AKS (Azure Kubernetes Service) avec un script Bash.


### Les patterns à mémoriser :

|**Aspect**|**Azure CLI**|**Azure PowerShell**|
|---|---|---|
|**Racine**|Toujours `az`|Toujours un Verbe + `-Az`|
|**Structure**|`az <service> <action>`|`Verbe-Az<Service>`|
|**Paramètres**|`--nom-du-parametre` (Double tiret)|`-NomDuParametre` (Simple tiret, PascalCase)|
|**Exemple (VM)**|`az vm create`|`New-AzVM`|
|**Exemple (RG)**|`az group create`|`New-AzResourceGroup`|