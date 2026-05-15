
**VNet (Virtual Network)** = système nerveux de ton infrastructure Azure. Compréhension précise du réseau (adresses IP, routage, sécurité) mélangée à la logique Azure.

## 1. Pourquoi c'est pertinent ?

Le VNet n'est pas juste un "tuyau". C'est ton **périmètre de sécurité**. Sans lui :

- Tes ressources ne peuvent pas communiquer entre elles.
- Tes serveurs sont exposés directement sur Internet (danger !).
- Tu ne peux pas connecter ton réseau local (bureau) au Cloud.

**Pour l'examen :** Tu dois comprendre que si le VNet est mal configuré, rien d'autre ne fonctionne. Une erreur de masque de sous-réseau ($10.0.0.0/24$) et tu ne peux plus ajouter de machines.

## 2. Modèle ARM complexe

### Ce que contient un modèle complexe :

- **Plusieurs Subnets :** Un pour le Web, un pour la Data, un pour l'Administration (Bastion).
    
- **Network Security Groups (NSG) :** Des règles de pare-feu appliquées à chaque sous-réseau.
    
- **Route Tables (UDR) :** Forcer le trafic à passer par un Pare-feu (Azure Firewall) plutôt que d'aller directement sur Internet.
    
- **VNet Peering :** Connecter ce VNet à un autre (architecture Hub & Spoke).
    
- **Service Endpoints :** Sécuriser l'accès à un compte de stockage pour qu'il ne soit accessible _que_ depuis ce VNet.

## 3. Pourquoi les candidats ont du mal à "percuter" ?

Trois points précis que tu dois surveiller :

1. **Le découpage IP (CIDR) :** Savoir combien de machines entrent dans un $/24$ vs un $/27$. Azure réserve **5 adresses IP** par sous-réseau (le .0, .1, .2, .3 et le dernier), ce qui surprend souvent.
2. **L'ordre de priorité des NSG :** Comprendre qu'une règle "Allow" à 100 écrase une règle "Deny" à 200, mais que les règles par défaut (comme le blocage du trafic entrant d'Internet) sont toujours là à la fin.
3. **Le routage :** Comprendre que si tu as un VNet A et un VNet B connectés (Peering), le trafic ne passera pas vers le VNet C automatiquement (le routage n'est pas transitif par défaut).

## 4. Comment l'utiliser selon les besoins ?

### Cas A : L'approche "Zero Trust" (Sécurisée)

Si tu déploies une application bancaire :
- **Action :** Ton modèle ARM doit inclure un NSG strict sur chaque sous-réseau qui interdit tout par défaut, sauf les ports spécifiques (ex: 443).
### Cas B : L'approche "Hub & Spoke" (Organisationnelle)

Si tu gères plusieurs départements (RH, IT, Ventes) :
- **Action :** Tu déploies un **Hub** (VNet central avec le VPN et le Firewall) et des **Spokes** (VNets isolés pour chaque département) qui se rejoignent au centre. Le modèle ARM doit alors gérer les liaisons (peering) entre eux.

## 5. À quoi ça ressemble dans le code ?

Dans ton fichier JSON, la complexité vient des **dépendances**.

- Le **Subnet** dépend de la création du **VNet**.
- L'**Interface Réseau (NIC)** de la VM dépend du **Subnet**.
- Le **NSG** doit être créé _avant_ d'être associé au **Subnet**.

**Conseil pour l'AZ-104 :** Quand tu liras un modèle ARM de VNet dans l'examen, cherche toujours la section `properties`. C'est là que se cachent les erreurs (une plage IP qui chevauche une autre, ou un NSG mal associé).



## 1. Pourquoi c'est pertinent ?

Le **VNet** est la brique de base de tout réseau privé sur Azure. Il permet l'isolation, la segmentation et la communication sécurisée entre les ressources (VM, Bases de données, etc.).

- **En prod :** Indispensable pour sécuriser les flux et connecter le cloud au réseau On-premise.
- **Pour l'examen :** Tu dois savoir comment découper les plages d'IP et gérer les communications entre VNets.

---

## 2. Concepts Clés

- **Address Space :** Défini en notation CIDR (ex: `10.0.0.0/16`).
- **[[Subnets]] :** Découpage du VNet en segments plus petits (ex: `10.0.1.0/24`).
- **IP réservées :** Azure réserve **5 adresses IP** dans chaque subnet (.0, .1, .2, .3 et le dernier).
- **DNS :** Par défaut, Azure fournit la résolution de noms, mais on peut configurer un DNS personnalisé.

---

## 3. Comment l'utiliser (Syntaxe AZ-104)

### Azure CLI

Bash

```
# Créer un VNet avec un subnet par défaut
az network vnet create \
  --name MyVNet \
  --resource-group MyRG \
  --address-prefix 10.0.0.0/16 \
  --subnet-name FrontEnd \
  --subnet-prefix 10.0.1.0/24
```

### Azure PowerShell

PowerShell

```
# Créer un VNet
New-AzVirtualNetwork -Name "MyVNet" `
  -ResourceGroupName "MyRG" `
  -Location "CanadaCentral" `
  -AddressPrefix "10.0.0.0/16"
```

---

## 4. Points d'attention & Pièges (Examen ⚠️)

- **Chevauchement (Overlap) :** On ne peut pas connecter deux VNets via **[[VNet Peering]]** si leurs plages d'IP se chevauchent.
    
- **Transitivité :** Si VNet A est peeré avec VNet B, et B avec C, A ne peut **pas** parler à C automatiquement.
    
- **Modification :** On peut ajouter des plages d'adresses à un VNet après sa création sans interruption.
    

---

## 5. Connexions (Graph View)

- **Sécurité :** Se lie via les **[[NSG]]** et les **[[ASG]]**.
- **Calcul :** Héberge les **[[Virtual Machines]]** et les **[[App Service]]**.
- **Connectivité :** Étendu par **[[VNet Peering]]**, **[[VPN Gateway]]** ou **[[ExpressRoute]]**.

---

### Mon conseil "Pro" pour ton Obsidian

Dans Obsidian, utilise le plugin **"Dataview"** ou simplement la vue **"Graph View"**. Plus tu créeras de notes comme celle-ci, plus tu verras le **VNet** apparaître comme le nœud central de ton graphique.

C'est exactement ce que Microsoft attend de toi pour l'AZ-104 : comprendre que si tu touches au réseau, tu impactes la sécurité, le calcul et le stockage d'un coup.

Tu veux qu'on fasse la même chose pour un concept plus orienté "Sécurité" comme le **[[NSG]]** ?