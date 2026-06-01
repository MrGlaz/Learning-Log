ENTRA ID vs AD DS
- Entra ID = flat (no OU, no GPO, no LDAP, no Kerberos)
- Auth: SAML / WS-Fed / OpenID Connect → Authz: OAuth
- Connexion via REST API over HTTP/HTTPS (not LDAP)

TENANTS & SUBSCRIPTIONS
- 1 subscription = 1 tenant only (→ RBAC)
- 1 tenant = multiple subscriptions
- Multi-tenant by design

OBJECTS
- **Application Object** = global template (1 only, home tenant) **(the blueprint)**
- **Service Principal** = local identity (1 per tenant where app is used) **(usage of blueprint)**

## Licenses

| License  | For what                           | Key features                                                                                                                                                                                                  |
| -------- | ---------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Free** | Included with any Azure / M365 sub | Users & groups, unlimited SSO for MS Cloud apps, Security Defaults (basic MFA via Authenticator), basic B2B                                                                                                   |
| **P1**   | Hybrid + advanced security         | Everything in Free + **Conditional Access**, **SSPR** (cloud + writeback to on-prem AD), **dynamic groups**, **Administrative Units**, advanced **Entra Connect / Cloud Sync** (password writeback), full MFA |
| **P2**   | Identity Protection + Governance   | Everything in P1 + **Identity Protection** (risk-based policies), **PIM** (Privileged Identity Management), **Access Reviews**                                                                                |

> AZ-104 note: mainly remember **what requires P1** (dynamic groups, AU, Conditional Access, SSPR). This is the most frequent trap.
