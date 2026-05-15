
On ne choisit pas n'importe quelle région pour la réplication GRS. C'est Azure qui impose la région paire (ex: tu ne peux pas jumeler le Canada avec la France manuellement pour du GRS).

### 📝 Description (Synthèse)

- **Couplage** : Association de deux régions (même géographie).
- **Distance** : Minimum 480 km d'écart physique.
- **Maintenance** : Mises à jour Azure séquentielles (une seule à la fois).
- **Réplication** : Support physique du stockage [[GRS]].
- **Isolement** : Protection contre catastrophes régionales majeures.

### 🎯 Pourquoi c'est pertinent ?

Assure la **continuité d'activité** et la reprise après sinistre (DR) en cas de panne totale d'un datacenter ou d'une région entière.

### ⚙️ Comment l'utiliser ?

Sélectionner une option de redondance géo-répliquée (**[[GRS]]** ou **[[GZRS]]**) lors de la création d'un **[[Storage Account]]** ; Azure gère automatiquement la copie vers la région paire.

### 💡 Un exemple pour tes liens :

- `Canada Central` (Toronto) est appairé avec `Canada East` (Québec).
- `France Central` (Paris) est appairé avec `France South` (Marseille).