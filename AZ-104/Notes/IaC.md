Les avantages de l’infrastructure en tant que code sont les suivants :
- Configurations cohérentes
- Scalabilité améliorée
- Déploiements plus rapides
- Meilleure traçabilité

L'IaC réside dans les composants "invisibles" :

- **Identité :** Créer des groupes de sécurité, assigner des rôles RBAC ou configurer des applications d'entreprise dans un annuaire comme Entra ID.
    
- **PaaS (Platform as a Service) :** Déployer une base de données SQL sans gérer l'OS, ou un service d'hébergement d'applications web (App Services).
    
- **Gouvernance :** Appliquer des politiques (Policies) qui interdisent la création de ressources hors d'une région spécifique ou sans certains tags.
    
- **Sécurité :** Déployer des coffres-forts numériques (Key Vaults) avec des politiques d'accès ultra-précises.

### CLI/Script vs IaC
- **L'approche Impérative (CLI/Script) :** "Crée-moi ce groupe, puis crée cette VM, puis ouvre ce port." Si le script plante au milieu, le relancer peut créer des doublons ou des erreurs.
    
- **L'approche Déclarative (IaC) :** "Voici l'état final que je veux." L'outil (Terraform, Bicep) compare cet état avec la réalité. S'il manque juste une règle de pare-feu, il ne touchera pas au reste et ne créera que ce qui manque.

### Cattle vs Pets : L'Infrastructure Immuable

Cette vision que vous appréciez s'appelle **l'infrastructure immuable**. Au lieu de passer des heures à débugger pourquoi un serveur est lent ou pourquoi une configuration a "dérivé" (le fameux _Configuration Drift_), on applique la méthode radicale :

1. On identifie le bug dans le code.
2. On corrige le code.
3. On détruit l'ancienne ressource.
4. On redéploie la nouvelle, parfaitement propre.

Cela garantit que votre environnement de production est toujours dans un état connu et documenté.
