
La [[Localisation]] détermine jusqu'où tes données sont "dupliquées" (répliquées) pour garantir qu'elles ne disparaissent pas en cas de panne.
## 1. Pourquoi c'est pertinent ?

Le choix de la localisation impacte directement ton [[SLA]] (niveau de service garanti) et ta résilience :

1. **[[LRS]]** (Locally Redundant) : 3 copies dans 1 seul datacenter d'une **[[Localisation]]**.

2. **[[ZRS]]** (Zone Redundant) : Exploite les **[[Availability Zones]]** d'une même région. Si un bâtiment tombe, les autres prennent le relais.

3. **[[GRS]]** (Geo-Redundant) : Réplication asynchrone (données triplées en région A) vers une seconde **[[Localisation]]** (région B) via les **[[Region Pairs]]**.

4. **[[GZRS]]** (Geo-Zone-Redundant) : Le combo ultime (ZRS local + LRS distant).