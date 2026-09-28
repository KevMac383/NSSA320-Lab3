# NSSA-320 Lab 3: Azure Ubuntu VM with Terraform

Infrastructure as Code lab that deploys an Ubuntu Linux VM on Azure using Terraform, resizes it with a variable, and installs NGINX with a provisioner.

## What it deploys

- Resource group (`rg-nssa320-student`)
- Virtual network and subnet
- Network security group with inbound rules for SSH (22) and HTTP (80)
- Static public IP
- Network interface
- Ubuntu 22.04 LTS VM (`vm-student`) accessed via SSH key authentication

## Files

| File | Purpose |
|---|---|
| `main.tf` | Resource definitions (network, NSG, public IP, NIC, VM, provisioner) |
| `variables.tf` | Input variable declarations (`location`, `vm_size`) |
| `terraform.tfvars` | Variable values |
| `outputs.tf` | Output values (SSH command) |

## Activities

1. **Deployment:** Provisioned the resource group, networking, and VM, then connected over SSH.
2. **VM resize:** Changed `vm_size` in `terraform.tfvars` from `Standard_D2s_v3` to `Standard_D4s_v3`. Terraform applied this as an in-place change (1 to change) instead of recreating the VM.
3. **NGINX via provisioner:** Added a `remote-exec` provisioner that connects over SSH and installs NGINX, plus an HTTP security rule for port 80. Verified with `curl`.

## Usage

```bash
az login
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```

Verify NGINX:

```powershell
curl.exe http://<public-ip>
```

Clean up:

```bash
terraform destroy
```

## Notes

- The course lab specifies `Standard_B1s` and `Standard_B2ms`. B-series sizes were not available on the Azure for Students subscription, so `Standard_D2s_v3` and `Standard_D4s_v3` were used instead.
- The subscription has an Azure Policy limiting deployments to `eastus2`, `eastus`, `southcentralus`, `westus3`, and `mexicocentral`. This deployment uses `eastus2`.
- Provisioners only run when a resource is created. To rerun the NGINX install on an existing VM, use `terraform apply -replace="azurerm_linux_virtual_machine.vm"`.
- The SSH private key, `.terraform/`, and `terraform.tfstate*` are excluded from the repo via `.gitignore`.
