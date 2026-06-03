
> Impose **rules** on all resources : what can be created, where, how, with what tags. Audit or enforcement.

### Core Concepts : 
```
Policy Definition  (the rule, JSON)
   ↓ grouped in
Initiative (Set Definition)  (group of policies, e.g. "ISO 27001 baseline")
   ↓ assigned to a
Scope (MG / Sub / RG / Resource) with parameters + exclusions
   ↓ generates
Compliance state (Compliant / Non-compliant / Conflict / Exempt)
```

### Actions

| Effect                       | What                                                                                                                                                                     |
| ---------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **Audit**                    | Log non-compliant (just reporting)                                                                                                                                       |
| **Deny**                     | Refuses creation/modification (enforcement)                                                                                                                              |
| **Append**                   | Adds a field to the resource (e.g.: default tag)                                                                                                                         |
| **Modify**                   | Modifies/adds properties (tags, role assignments) — **remediation possible**                                                                                             |
| **DeployIfNotExists (DINE)** | If the resource doesn't have the expected sub-resource, **deploys** an ARM template to create it (e.g.: deploy a monitoring agent on each VM) — **remediation possible** |
| **AuditIfNotExists**         | Audit if a sub-resource is missing (without deploying)                                                                                                                   |
| **Disabled**                 | Temporarily disables the policy (useful for debug)                                                                                                                       |
| **Manual**                   | Compliance managed manually (attestation by human)                                                                                                                       |

### Initiatives
- Groups multiple policy definitions → single assignment
- Built-in: **Azure Security Benchmark**, **CIS**, **ISO 27001**, **NIST**, **PCI DSS**, **HIPAA HITRUST**, etc.
- MS recommendation: **always assign via an initiative**, even for 1 policy → you can add others without reassigning.

### Remediation
- Bring a resource to compliance based on a definition and assignment
- For existing non-compliant resources → create a remediation tasks
- New resources applicable to Modify or DINE def : automatically remediated 

### Exemptions
- Allows excluding a resource from a policy
- 2 categories : 2 categories: **Waiver** (accepted as-is) or **Mitigated** (compliant via another means).
* **Brownfield (Existing Environments):** New policies won't automatically fix or block pre-existing non-compliant resources. You must trigger a **Remediation Task** to fix them.

### Compliance evaluation
- Trigger : resource **creation** or **update**
- Timing : periodic scan (~24h), or manual trigger (`az policy state trigger-scan`).
- View: `Policy > Compliance` → drill-down per initiative/policy/resource.