
- **C'est quoi ?** Ce n'est pas un langage différent, mais un **hôte** (un conteneur Linux éphémère) accessible via le navigateur.

- **Le plus :** Il contient **déjà** Azure CLI et Azure PowerShell préinstallés et préconfigurés avec vos identifiants.

- **Usage unique :** Il permet d'utiliser l'un ou l'autre (Bash pour le CLI ou PowerShell) sans rien installer sur votre machine locale.

- **Utilise Azure Cloud Shell si :** Tu es sur un ordinateur qui n'est pas le tien, si tu as besoin d'un accès rapide pour une commande unique, ou si tu veux modifier un script via l'éditeur intégré (`code .`) sans gérer de versions de modules.
	- _Exemple :_ Vérifier rapidement l'état d'un groupe de ressources pendant un déplacement.

Cloud Shell vous permet aussi de mapper un partage de fichiers Stockage Azure, qui est lié à une région spécifique. L’accès à un partage de fichiers Azure vous permet d’utiliser le contenu de ce partage via Cloud Shell.

une seule région peut avoir le stockage alloué à Azure Cloud Shell.
Azure Cloud Shell autorise une seule instance à la fois et n’est pas adapté au travail simultané sur plusieurs abonnements ou locataires.

Ouvrir une session de ligne de commande sécurisée sur n’importe quel appareil basé sur un navigateur.
Interagir avec les ressources Azure sans avoir besoin d’installer des plug-ins ou des extensions sur votre appareil.