# Moodle LMS on Azure – Terraform Modular Deployment

Este proyecto implementa una arquitectura escalable y segura de Moodle LMS en Microsoft Azure, siguiendo buenas prácticas de IaC con Terraform.

## 📁 Estructura Modular

```
├── main.tf
├── terraform.tfvars
├── modules/
│   ├── network/
│   ├── db/
│   ├── app/
│   ├── storage/
│   └── vm/
```

## 📦 Módulos Incluidos

- **Network**: VNet, subredes, y grupo de recursos.
- **DB**: Azure Database for MySQL Flexible Server.
- **App**: App Service Plan (Linux) y App Service (PHP).
- **Storage**: Azure File Share para `moodledata`.
- **VM**: Linux virtual machine con acceso SSH.

## 🚀 Requisitos

- Terraform ≥ 1.3
- Azure CLI autenticado (`az login`)
- Suscripción activa de Azure

## ⚙️ Uso

1. Copia el archivo de ejemplo:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

2. Edita `terraform.tfvars` y define los valores:
   ```hcl
   name_prefix    = "moodle-prod"
   location       = "East US"
   admin_password = "StrongPasswordHere"
   vm_username    = "azureuser"
   vm_password    = "ChangeMeP@ssword1!"
   ```

3. Inicializa Terraform:
   ```bash
   terraform init
   ```

4. Revisa el plan de ejecución:
   ```bash
   terraform plan
   ```

5. Aplica la infraestructura:
   ```bash
   terraform apply
   ```

## 🔐 Seguridad

- La contraseña de la base de datos se maneja como variable sensible.
- No se expone la DB a internet.
- Puedes extender el módulo `network` para añadir NSGs, Azure Bastion, o WAF Gateway.

## 📤 Outputs

- URL del App Service
- Nombre del grupo de recursos
- FQDN de la base de datos MySQL
- IP pública de la VM

## 🧹 Limpieza

```bash
terraform destroy
```

## 📄 Licencia

MIT
