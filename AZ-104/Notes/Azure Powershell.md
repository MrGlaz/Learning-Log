
- **C'est quoi ?** Un ensemble de modules (Az) qui s'ajoutent à l'environnement PowerShell. Les commandes suivent la structure `Verbe-Nom` (ex: `New-AzVM`).

- **Structure :** Repose sur le framework .NET.

- **Format de sortie :** Retourne des **objets**. Cela signifie que vous pouvez "piper" (transmettre) un objet complet d'une commande à une autre pour manipuler ses propriétés nativement, ce qui est extrêmement puissant pour la logique complexe.

- **Utilise Azure PowerShell si :** Tu dois gérer des scénarios d'administration complexes nécessitant une manipulation fine des objets (boucles, conditions avancées) ou si ton infrastructure existante repose déjà sur l'écosystème Windows.
	- _Exemple :_ Parcourir tous les abonnements pour identifier les disques non attachés et générer un rapport détaillé.


Get-AzVM -Name xxxxx
Get-AzVM -ResourceGroupName yyyyyy -Name xxxxxx


### Les patterns à mémoriser :

|**Aspect**|**Azure CLI**|**Azure PowerShell**|
|---|---|---|
|**Racine**|Toujours `az`|Toujours un Verbe + `-Az`|
|**Structure**|`az <service> <action>`|`Verbe-Az<Service>`|
|**Paramètres**|`--nom-du-parametre` (Double tiret)|`-NomDuParametre` (Simple tiret, PascalCase)|
|**Exemple (VM)**|`az vm create`|`New-AzVM`|
|**Exemple (RG)**|`az group create`|`New-AzResourceGroup`|
