[[AZ104]]

**Le Pourquoi avant le Comment**
Pour chaque service (ex: Azure Bastion), noter le cas d'usage (à utiliser quand on veut du RDP/SSH sans exposer d'IP publique)
puis la définition

**Schématiser les hiérarchies**
Azure est très hiérarchique
ex : Groupe de Management > Abonnement > Groupe de Ressources
Visualiser la portée d'une stratégie RBAC (Role-Based Access Control) est bien plus efficace qu'une liste à puces.

**Comparatifs rapides :**
Faire des tableaux pour les services qui se ressemblent
(ex: _Load Balancer_ vs _Application Gateway_ vs _Traffic Manager_)

**Utilisez le "Active Recall" avec des mini-scénarios :** Au lieu de relire vos notes, posez-vous des questions de mise en situation : _"Si je dois connecter deux VNets dans des régions différentes, quelle est la solution la plus simple ?"_ (Réponse : VNet Peering).

Lier les notions d'infrastructure à l'automatisation

Comment automatiser une tâche avec PowerShell ou un template ARM ?

Tu ne peux pas fabriquer de réacteur sans comprendre la chimie de base.
Sur Azure, tu ne peux pas sécuriser un réseau sans comprendre le routage et les identités.

### Résumé de ta "Progression de Quêtes" (Roadmap)

|**Phase**|**Activité Obsidian**|**Activité Pratique**|
|---|---|---|
|**Tier 1 (Fondations)**|Notes sur Entra ID & RBAC|Scripts de création d'utilisateurs/groupes|
|**Tier 2 (Networking)**|Schémas de VNet Peering sur Canvas|Création de topologie Hub-and-Spoke|
|**Tier 3 (Compute)**|Guide de survie des VM et Scale Sets|Déploiement automatisé via PowerShell|
|**Tier 4 (Data/App)**|Comparatif des solutions de stockage|Configuration de politiques de sauvegarde|