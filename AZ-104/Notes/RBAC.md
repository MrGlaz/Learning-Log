
## 📄 Azure Role-Based Access Control (RBAC)

### 1. Core Concepts & Architecture
* **The Role Assignment Equation:** `Security Principal (Who)` + `Role Definition (What)` + `Scope (Where)`.
* **Security Principals:** Can be a User, Group, Service Principal (App identity), or Managed Identity.
* **Scope Hierarchy:** Permissions cascade downward through the structure:
  $$\text{Management Groups} \rightarrow \text{Subscriptions} \rightarrow \text{Resource Groups} \rightarrow \text{Resources}$$
* **Inheritance:** Permissions assigned at a higher level are automatically inherited by all lower levels and **cannot** be revoked or blocked at a lower level.

### 2. Built-in Roles vs. Custom Roles
* **The Big Three (Built-in):**
  * `Owner`: Full access to all resources, including the ability to delegate access to others (assign RBAC).
  * `Contributor`: Can create and manage all types of Azure resources, but **cannot** grant access to others.
  * `Reader`: Can view existing Azure resources but cannot create, modify, or delete them.
* **Custom Roles:** Created using JSON if built-in roles do not match specific security needs.
  * Must specify `Actions` (allowed operations), `NotActions` (subtracted operations), and `AssignableScopes` (where the role can be used).

### 3. Data Plane vs. Control Plane
* **Control Plane (Management):** Operations related to managing the resource itself (e.g., starting a VM, creating a Storage Account). Covered by standard roles like `Contributor`.
* **Data Plane (Content):** Operations related to accessing the data *inside* the resource (e.g., reading blobs inside a storage account, database queries). 
  * *Crucial Note:* Being a `Contributor` on a storage account does **not** grant data-plane access to read the files inside by default. You need specific roles like `Storage Blob Data Contributor`.

### 4. Exam Pitfalls & Nuances (AZ-104)
* **Deny Assignments:** Standard RBAC is exclusively additive (it only grants permissions). You **cannot** manually create a "Deny" rule. Deny Assignments exist in Azure but are applied exclusively by the system (e.g., Azure Blueprints or Managed Applications).
* **Root Management Group Elevation:** An Entra ID Global Administrator does **not** have access to Azure Subscriptions by default. They must explicitly toggle "Access management for Azure resources" in the portal to grant themselves the `User Access Administrator` role at the Root Management Group level.
* **The Assignment Limit:** There is a strict platform limit of **4,000** RBAC assignments per subscription. Best practice is to assign roles to **Groups**, never directly to individual users.