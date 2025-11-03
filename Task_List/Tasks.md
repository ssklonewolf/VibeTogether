# 📘 DevOps Practical Assignment – GitHub, Azure CLI & Terraform

This guide lists all tasks required to complete your assignment — covering Git/GitHub basics, Azure CLI operations, and Terraform configurations.

---

## 🧩 INITIAL SETUP TASKS

### **Task 1: Fork Repository**
- From the GitHub UI, click **Fork** (top-right corner) to create a copy of this repository under your account.

### **Task 2: Clone Repository**
Clone your forked repository to your local system:
```bash
git clone <your-forked-repo-link>
```

### **Task 3: Create Folder with Your Name**
Create a folder using your name (example: `SSK`):
- **Windows:** Create manually → New Folder → `SSK`
- **Ubuntu:**
  ```bash
  mkdir SSK
  ```

### **Task 4: Create Subfolders**
Inside your name folder, create the following structure:
```
SSK/
├── Terraform
├── Docker
├── Kubernetes
└── Misc
```

### **Task 5: Add Files in Each Folder**
| Folder | File Name |
|---------|------------|
| Terraform  | main.tf |
| Docker     | Dockerfile |
| Kubernetes | pod.yaml |
| Misc       | notes.txt |

### **Task 6 (Optional): Automate Folder Creation**
Create folders and files using a script (.cmd, .ps1, .sh, or .bash).

Example (Linux/Mac):
```bash
mkdir -p SSK/{Terraform,Docker,Kubernetes,Misc}
touch SSK/Terraform/main.tf SSK/Docker/Dockerfile SSK/Kubernetes/pod.yaml SSK/Misc/notes.txt
```

### **Task 7: Push Changes to GitHub**
1. Create a new branch (don’t push directly to main):
   ```bash
   git checkout -b dev-branch
   ```
2. Add, commit, and push:
   ```bash
   git add .
   git commit -m "Initial folder structure and files added"
   git push origin dev-branch
   ```
3. Configure Git if not done:
   ```bash
   git config user.name "your-github-username"
   git config user.email "your-email@example.com"
   ```

### **Task 8: Create Pull Request (PR)**
In GitHub UI:
- Go to **Pull Request → Create PR** from your branch to the **main branch** of the original repo.

### **Task 9: Pull Latest Changes**
Once your PR is merged into the original repo, pull the latest updates into your forked repository.

---

## ☁️ AZURE CLI TASKS

Perform these tasks under the **Misc** folder and attach screenshots.

### **Task 10:** Add all Azure CLI task screenshots and documentation.

### **Task 11:** Install Azure CLI and verify installation
```bash
az --version
```

### **Task 12:** Find the command that lists all available `az` commands and document it.

### **Task 13:** Create and list Resource Groups
```bash
az group create --name <rg-name> --location <region>
az group list --output table
```

### **Task 14:** Create and list Storage Accounts
```bash
az storage account create --name <storage-account-name> --resource-group <rg-name> --location <region> --sku Standard_LRS
az storage account list --output table
```

### **Task 15:** Create and list Storage Containers
```bash
az storage container create --name <container-name> --account-name <storage-account-name>
az storage container list --account-name <storage-account-name> --output table
```

### **Task 16:** Upload a file to Storage Container and list all files
```bash
az storage blob upload --account-name <storage-account-name> --container-name <container-name> --file <file-path> --name <blob-name>
az storage blob list --account-name <storage-account-name> --container-name <container-name> --output table
```

---

### *(Optional – Advanced Azure Tasks)*

**Task 17:** Check if Storage Account name already exists.  
**Task 18:** Install Azure DevOps extension:
```bash
az extension add --name azure-devops
```
**Task 19:** Trigger an existing Azure DevOps pipeline using CLI.  
**Task 20:** List environment variables for Azure Container Apps.  
**Task 21:** Check the current status of Azure Container Apps.  

---

## 🧱 TERRAFORM TASKS

Perform all Terraform tasks inside the **Terraform** folder.  
For each major task, create a subfolder (example: `Task-24`, `Task-25`, etc.).

---

### **Task 22: Create a Folder for Each Task**
Example:
```
Terraform/
├── Task-24/
├── Task-25/
└── Task-26/
```

### **Task 23: Install Terraform**
Install Terraform and verify installation:
```bash
terraform --version
```

### **Task 24: Create a Resource Group with Terraform**
1. Create a Terraform configuration file to create a Resource Group.  
2. Run the Terraform workflow:
   ```bash
   terraform init
   terraform fmt
   terraform validate
   terraform plan
   terraform apply
   ```

### **Task 25: Create a Storage Account and Add Implicit Dependency**
- Create a storage account that depends on the resource group implicitly (through reference).

### **Task 26: Create a Storage Container and Add Explicit Dependency**
- Create a storage container that explicitly depends on the storage account using the `depends_on` argument.

### **Task 27: Configuration Scenario 1 – Addition in .tf file**
- Add a new resource block (for example, another resource group) and observe the plan changes.  
- Example: Add a new Resource Group and note how Terraform identifies it as a new resource.

### **Task 28: Configuration Scenario 2 – Deletion in .tf file**
- Delete or comment out a resource block from Tasks 24–26 and observe what Terraform plans to remove.

### **Task 29: Configuration Scenario 3 – Change from Azure Portal**
- Delete a resource (created by Terraform) directly from the Azure Portal.  
- Run `terraform plan` and observe the drift detection.

### **Task 30: Configuration Scenario 4 – Import Existing Resource**
- Create a new resource directly in the Azure Portal and import it into Terraform:
  ```bash
  terraform import <resource_type>.<name> <resource_id>
  ```

### **Task 31: Store Terraform State in Azure Storage Account**
- Configure backend storage in Terraform to save state remotely:
  ```hcl
  terraform {
    backend "azurerm" {
      resource_group_name  = "rg-name"
      storage_account_name = "storage-account"
      container_name       = "tfstate"
      key                  = "terraform.tfstate"
    }
  }
  ```

### **Task 32: State Locking and Force-Unlock**
**Way 1 – Same PC:**  
- Run `terraform apply` simultaneously in two terminals and observe the lock error.

**Way 2 – Different PCs:**  
- Use the same backend configuration and run `terraform apply` from two systems at the same time.

To unlock the state manually:
```bash
terraform force-unlock <LOCK_ID>
```

---

## 📝 Notes
- Always use **meaningful commit messages**.  
- Never push directly to the `main` branch — always create a new branch and raise a PR.  
- Add all **Azure CLI screenshots** inside the `Misc/` folder.  
