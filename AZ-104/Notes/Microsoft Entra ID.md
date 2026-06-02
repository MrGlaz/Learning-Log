**ENTRA ID vs AD DS**
- Entra ID = flat (no OU, no GPO, no LDAP, no Kerberos)
- Auth: SAML / WS-Fed / OpenID Connect → Authz: OAuth
- Connexion via REST API over HTTP/HTTPS (not LDAP)

**TENANTS & SUBSCRIPTIONS**
- ENTRA = Multi-tenant by design
- 1 subscription = 1 tenant only (→ RBAC)
- 1 tenant = multiple subscriptions
- Entra tenant with unique DNS prefix.
- Part of PaaS
- Modern management > **NEVER** create multiple users for isolation. > Use **RBAC** (Management Groups or Azure Policies) applied at the Subscription or Resource Group level to segregate access.

**OBJECTS**
- **Application Object** = global template (1 only, home tenant) **(the blueprint)**
- **Service Principal** = local identity (1 per tenant where app is used) **(usage of blueprint)**

## Licenses

| License  | For what                           | Key features                                                                                                                                                                                                  |
| -------- | ---------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Free** | Included with any Azure / M365 sub | Users & groups, unlimited SSO for MS Cloud apps, Security Defaults (basic MFA via Authenticator), basic B2B                                                                                                   |
| **P1**   | Hybrid + advanced security         | Everything in Free + **Conditional Access**, **SSPR** (cloud + writeback to on-prem AD), **dynamic groups**, **Administrative Units**, advanced **Entra Connect / Cloud Sync** (password writeback), full MFA |
| **P2**   | Identity Protection + Governance   | Everything in P1 + **Identity Protection** (risk-based policies), **PIM** (Privileged Identity Management), **Access Reviews**                                                                                |

> AZ-104 note: mainly remember **what requires P1** (dynamic groups, AU, Conditional Access, SSPR). This is the most frequent trap.


## Microsoft Entra Domain Services (Entra DS)
* **Use case:** Migrate legacy apps (LOB) which needs Kerberos, LDAP or GPO to Azure
* **Benefit:** no more DC with VM or local complex VPNs
* **Prerequisite :** Requires Entra ID P1 or P2

### Entra DS : Advantages & Limitations
* **The + (Zero Infra) :** Managed service (no patch, no AD replication), no AD domain/entreprise role
* **Major limitation:**
  * **Scheme :** Impossible to extend
  * **UO :** Flat organization (no nested UO).
  * **GPO :** Unique and integrated. Cannot target UO or use WMI filters
* **Billing :** Hourly, depends on the directory's size.

> 💡 **AZ-104 Rule of Thumb:** 
> Complex, custom, or targeted GPOs? **Entra DS is OUT.** 
   You MUST deploy real Domain Controllers (DCs) on Azure VMs.
   


#### Roles to restore or permanently delete users 
- Global administrator
- Partner Tier-1 Support
- Partner Tier-2 Support
- User administrator