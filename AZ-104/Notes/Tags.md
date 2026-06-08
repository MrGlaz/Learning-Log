## 🏷️ Azure Tags : L'essentiel en 30 secondes

### 1. C'est quoi ?

Un tag est une simple **paire Clé / Valeur** (ex: `Environnement` : `Production`) que l'on associe directement à une ressource Azure. C'est l'équivalent d'une étiquette pour organiser tes objets.

### 2. Pourquoi on l'utilise ? (Cas d'usage)

- **Facturation et FinOps :** Regrouper et filtrer les coûts par département (`Service` : `Marketing`) ou par application (`Projet` : `SaaS-Form-Builder`).
    
- **Gestion des ressources :** Identifier instantanément à qui appartient une ressource ou quel est son niveau de criticité.
    
- **Automatisation :** Lancer des scripts qui ciblent uniquement les ressources étiquetées (ex: _"Éteindre toutes les VMs avec le tag `Mode` : `Dev` à 20h"_).
    

### 3. Les règles d'or et pièges de l'examen (AZ-104)

- **Pas d'héritage automatique :** Contrairement au RBAC ou aux Policies, **les tags ne se propagent pas vers le bas**. Si tu mets un tag sur un _Resource Group_, les ressources à l'intérieur **n'en héritent pas**.
    
- **Comment forcer l'héritage ?** On utilise une **Azure Policy** (avec l'effet `Modify` ou `DeployIfNotExists`) pour copier automatiquement les tags du groupe vers les ressources.
    
- **Format :** Les tags sont de simples métadonnées textuelles. Ils n'altèrent jamais le fonctionnement ou les performances de la ressource.