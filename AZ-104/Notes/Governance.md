[[RBAC]] determines **WHO** can do something (permissions)
[[Azure Policy]] determines **WHAT** can be done (properties of the resource, like size or location).

> 💡 **AZ-104 Rule of Thumb:**
> "Free Tier" Entra, dynamic groups are **DISABLED**.
### 1. Manage Groups
- Security groups : manage **access rights** (users, devices, services) to shared resources
- M365 groups : manage **collaboration** rights (shared mailbox, calendar, etc)
#### > 3 types of group memberships 
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

> License assignment fails with a `MutuallyExclusiveViolation` error? 
> Entra ID **will not** auto-fix it. You must manually disable overlapping service plans or strip the redundant direct license. (SharePoint P2 aside with a SharePoint P1)

Some Microsoft services aren't available in all locations because of local laws and regulations. Then specify the **Usage location** property for the user > assign the license.

#### When a licensed group is deleted
Must remove all licenses assigned to a group before being able to delete the group.

#### Manage licenses for products with prerequisites
Some Microsoft Online products are _add-ons_. Add-ons require a prerequisite service plan to be enabled for a user or a group before they can be assigned a license.

