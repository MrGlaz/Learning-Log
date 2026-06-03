[[RBAC]] determines **WHO** can do something (permissions)
[[Azure Policy]] determines **WHAT** can be done (properties of the resource, like size or location).

> 💡 **AZ-104 Rule of Thumb:**
> "Free Tier" Entra, dynamic groups are **DISABLED**.
### 1. Manage Groups
- Security groups : manage **access rights** (users, devices, services) to shared resources
- M365 groups : manage **collaboration** rights (shared mailbox, calendar, etc)
#### 3 types of group memberships 
- **Assigned** - manual actions
- **Dynamic User** (P1) - automatic actions based on rules and attributes (department, job title, or location)
- **Dynamic Device** - automatic actions based on rules. Only with security groups.

### 2. Registered devices

> 💡 **AZ-104 Rule of Thumb:**
> Personal laptop / BYOD / Mobile device accessing company apps? **Entra Registered**.
> Corporate-owned laptop logging in with an enterprise cloud account? **Entra Joined**.
> Legacy on-prem AD computer that also needs cloud access? **Hybrid Entra Joined**.
> **Entra Registered** devices support **MAM/Intune policies** to protect data (compliance, lost device, infected device, etc) + selective wipe, but you **CANNOT** apply Azure RBAC to a physical local PC

When a device is Entra Registered or Joined, it gets a PRT. This is a special token that proves who the user is and that the device is known. It's the key to Single Sign-On (SSO) for cloud resources.

**To remember**:
- Settings: `Entra > Devices > Device settings` → who can join, max devices/user, MFA for join, local admins.

| Details              | **Microsoft Entra Registered**     | **Microsoft Entra Joined** | **Hybrid Entra Joined**    |
| :------------------- | :--------------------------------- | :------------------------- | :------------------------- |
| **Device type**      | **BYOD** (Perso / Mobile / Mac)    | Company device             | Company device             |
| **OS**               | Windows 10/11, iOS, Android, macOS | Windows 10/11, Linux       | Windows 10/11 (et anciens) |
| **Account types**    | **Personal account**               | **Pro Entra ID account**   | **Local AD DS**            |
| **Authentification** | Web/App (SSO partial)              | Native Cloud Auth          | Kerberos local + Cloud     |
| **(MDM)**            | Intune (Optionnal)                 | Intune / MDM mandatory     | GPO + Intune               |

### 3. Licenses

> 💡 **AZ-104 Rule of Thumb:**
> **Need Dynamic Groups or Conditional Access?** $\rightarrow$ Requires **Premium P1**.
> **Need Identity Protection or PIM (Just-In-Time access)?** $\rightarrow$ Requires **Premium P2**.
> **Assigning licenses to 1000+ users?** $\rightarrow$ NEVER do it manually. Assign to a **Security Group**.
#### 1. License Tiers
* **Free:** Basic user/group management, self-service password change (cloud-only users), and Azure Portal access.
* **P1:** Advanced Group rules (Dynamic Groups), Conditional Access, and Hybrid sync (Entra Connect)
* **P2:** Identity Protection (RBAC) and Privileged Identity Management (PIM).
#### 2. Group-Based Licensing (Best Practice)
* **Concept:** Assign licenses to a **Security Group** or **Microsoft 365 Group** instead of individual users.
* **Inheritance:** User in a group inherits the license. If removed, the license is freed.
* **Limitation:** Licenses *cannot* be assigned directly to Dynamic Groups, but users resolved by dynamic rules will inherit licenses if they belong to an assigned security group.

| Method          | How                                                | Note                                                                                                                                                                                                                     |
| --------------- | -------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **Direct**      | `User > Licenses > Assignments`                    | Simple, doesn't scale                                                                                                                                                                                                    |
| **Group-based** | Assign the license to a group → all members get it | **P1 required**. **1 license per member** (group of 5 people = 5 licenses consumed, regardless of available pool size). If a user is in 2 groups with the same license = **no double consumption** (auto deduplication). |
| **Bulk**        | Multi-select users → Assign licenses               | For one-shot operations                                                                                                                                                                                                  |

##### **Frequent traps**:
- **No license without Usage Location** defined on the user (FR / US / etc.) → error `licenseAssignmentNotAllowed`.
- **License conflicts**: 2 licenses granting the same service plan → only one takes effect. Disable duplicate service plans.
- **Reprocess**: if a user stays in error → `Licenses > [license] > Reprocess`.
- Reports: `Entra > Billing > Licenses > All products` → consumption view per license.
#### When a licensed group is deleted
Must remove all licenses assigned to a group before being able to delete the group.

#### Manage licenses for products with prerequisites
Some Microsoft Online products are _add-ons_. Add-ons require a prerequisite service plan to be enabled for a user or a group before they can be assigned a license.


### 4. DEMO — portal paths

#### Tenant
- Creation: `Entra > Overview > Manage tenants > Create`
- The account that creates becomes **Global Admin** automatically.

#### Subscription
- Create / change tenant: `Subscription > Change directory` (moves the sub to another tenant — caution: RBAC is lost, to be reassigned).

#### Custom domain
- `Entra > Custom domain names > Add` → add a **TXT or MX** record at the registrar → Verify.
- The domain can be set as **primary**.

#### User creation
- **Single**: `Entra > Users > New user > Create new user` (cloud) or `Invite external user` (B2B).
- **Bulk**: `Users > Bulk operations > Bulk create` → upload CSV (template provided).

#### Administrative Unit
- `Entra > Roles & admins > Administrative units > Add`
- Add members (users / groups / devices) → then `Roles and administrators` at the AU scope to delegate.
- **Restricted Management AU**: option to check at creation. *Effect*: even a Global Admin CANNOT modify the AU's objects without an explicitly assigned role on it → protects break-glass / VIP accounts. *Irreversible* = once the box is checked at creation, **you can no longer uncheck it**. To undo, delete the AU and recreate it non-restricted (loss of config). Think carefully first.

#### App Registration
- `Entra > App registrations > New registration`
- Options to know:
  - **Supported account types**: single tenant (just your company) / multi-tenant (any Entra company) / multi-tenant + personal (expands to personal hotmail/outlook.com accounts)
  - **Redirect URI**: URL where Entra sends the user back after OAuth login (with the token). Must match EXACTLY. E.g. web app: `https://myapp.com/auth/callback`
  - **Client secrets**: string with expiration date (~2 years max), to rotate. Visible **only once** at creation
  - **Certificates**: more secure alternative (recommended for prod); you upload the public key, the app keeps the private one
  - **API permissions — Delegated**: app acts *on behalf of the logged-in user* (e.g. `User.Read` = read MY info when I AM logged in)
  - **API permissions — Application**: app acts *on its own* without user (e.g. `User.Read.All` = read all tenant users). Often requires **Grant admin consent** by a Global Admin
  - **App roles**: business roles exposed by the app (e.g. `Manager`, `Employee`). You assign these roles to users → the app sees them in the token and adapts its UI
- Verify in **Enterprise applications** that the service principal was indeed created.

#### Managed Identity
- **System-Assigned**: on the resource (e.g. VM) → `Identity > System assigned > On`. Disappears with the VM.
- **User-Assigned**: create the independent resource `Create > Managed Identity` then attach it to the VM via `Identity > User assigned > Add`.
- Quick test from the VM:
  ```
  az login --identity                      # SA
  az login --identity --username <client-id-UA>   # UA
  ```