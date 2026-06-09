Key-value labels (`environment=prod`, `owner=alice`) attached to resources for organization, billing, automation, and governance.

### TL;DR

- Max **50 tags/resource**, key ≤ 512 chars, value ≤ 256 chars (storage accounts: 128/256)
- **Not inherited by default** — child resources don't get parent RG/Sub tags automatically
- Enforce them with **Azure Policy** (`Require`, `Inherit`, `Modify`)

Tags flow into **Cost Management** for filtering/grouping spend

### Why / When to use

- **Cost tracking**: split a shared subscription bill by `costcenter`, `project`, `environment`
- **Ops & automation**: target VMs with `shutdown=18h` via Automation runbooks
- **Ownership**: `owner=email` so you know who to ping before deleting
- **Compliance/lifecycle**: `dataclassification=confidential`, `expiry=2025-12-31`
- **RBAC-light filtering**: filter portal/CLI views by tag (not a security boundary!)

### How to set them

**Portal**: Resource → _Tags_ blade → add key/value
**CLI** (append, doesn't wipe existing):

bash
```bash
az tag update --resource-id <id> --operation merge --tags env=prod owner=alice
```

**PowerShell**:
```powershell
Update-AzTag -ResourceId <id> -Tag @{env="prod"} -Operation Merge
```

**Operations**: `merge` (add/update), `replace` (overwrite all), `delete`

### Common traps

- **No inheritance by default** — easiest exam trap. RG tag ≠ resource tag.
- **Case-sensitive values**, case-insensitive keys (treat both as case-sensitive to be safe)
- **`az tag update` with `--operation replace` wipes everything** — use `merge` to add
- Some resource types **don't support tags** (classic, some child resources) — policy may fail silently
- Tags **don't appear in cost reports immediately** — ~24h delay, and only forward-looking (past costs aren't retagged)
- **Moving a resource** keeps its tags; **deleting and recreating** loses them


### Exam tips

- Question says _"ensure all resources in an RG have tag X"_ → **Azure Policy with Modify effect + managed identity**, not manual tagging
- Question mentions _"existing non-compliant resources"_ → need a **remediation task** (Modify/DeployIfNotExists)
- Tags are **not a security boundary** — don't confuse with RBAC scope
- Cost analysis grouping by tag → requires the tag to exist **before** the cost was incurred