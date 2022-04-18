 # Terraform in Azure


This repository is meant to hold all my terraform projects. So far here's what I've done:
* Deploying resource groups
* Deploying azure container instances
* Deploying Virtual machines

For some more information on these projects please click [here](https://www.ryan-ali.tech/blog/infrastructure-as-code-using-terraform-to-deploy-resources-in-azure) 

### To use these files follow these steps

1. Ensure terraform is installed

        Terraform version

2. Copy these files to your Azure CLI

3. Change into your desired directory 
Eg.

        CD Terraform/tf_container_deployment

4. Run terraform init

        Terraform init

5. Make a terraform plan file 

        Terraform plan -out main.tfplan

6. Apply terraform plan file. 

        Terraform apply main.tfplan

That's it! After following these steps you should have the resources deployed in a new resource group which follows the pattern rg-\*-\*

### After you're finished
You can removed the resources created by using terraform destroy. 

1. Make a terraform destroy plan

        Terraform plan -destroy -out main.destroy.tfplan
2. Execute destroy plan

        Terraform apply main.destroy.tfplan

After you've run these commands you can check your azure portal to ensure resources are removed

Enjoy! 
-Ryan 

