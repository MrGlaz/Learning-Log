
```
Entra ID Tenant (root)
  └─ Management Group (root MG)
        └─ Management Group (child) — up to 6 levels
              └─ Subscription
                    └─ Resource Group
                          └─ Resource
```

**Downward inheritance**: RBAC, Policy, Tags (Cost management) → everything assigned to one level applies to lower levels.
