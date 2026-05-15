
### Quoi ?

Bicep est un langage spécifique au domaine (DSL) créé par Microsoft. C'est une couche d'abstraction au-dessus de l'ARM. En réalité, quand tu exécutes du Bicep, Azure le "transpile" (convertit) en ARM JSON avant de l'exécuter.

### Pourquoi ?

- **Lisibilité :** Fini les parenthèses et les accolades infinies du JSON. C'est beaucoup plus proche d'un langage de programmation moderne.
- **Gestion des dépendances :** Bicep détecte souvent seul l'ordre de création des ressources (pas besoin de `dependsOn` à chaque ligne).
- **Modulaire :** Tu peux créer des fichiers séparés (modules) et les réutiliser.

### Comment ?

C'est très simple. Au lieu d'avoir un fichier `.json` illisible, tu as un fichier `.bicep`.

- **Syntaxe :** `resource <nom-symbolique> '<type-ressource>@<version-api>' = { ... }`