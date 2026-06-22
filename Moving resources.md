
Move resources between RG / Sub / Region.
Move resources between RG / Sub / Region.

| Move | Doable? | Note |
|---|---|---|
| **Cross-RG** (same sub) | ✅ Direct | The simplest. Related resources must follow |
| **Cross-subscription** (same tenant) | ✅ Direct | Prior Azure validation |
| **Cross-region** | ❌ Not native | **ASR** (VMs), **Resource Mover**, or recreate |
| **Cross-tenant** | ❌ Very complex | Recreate on the destination side |
