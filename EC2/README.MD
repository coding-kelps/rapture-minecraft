# AWS EC2 Instance
I provided here an example of configuration with Terraform.

Terraform enable us to define our desired infrastructure with configuration files. Here I've defined a Terraform module from a single configuration file named "main.tf". However, a Terraform module can be composed of multiple configuration, as long as they are in the same directory.

The module that I've configured setup an AWS EC2 instance with Ubuntu as the OS.

## Requirements
  - You've installed AWS CLI on your local machine
  - Your AWS CLI is connected to your account
  - You've installed Terraform CLI on your local machine

## Getting Started 

```sh
terraform init
```
It will configure terraform to your working dir and recognize the **main.tf** file.

```sh
terraform apply
```
At applying phase, Terraform will apply all the required changes to make your infrastructure corresponds to the infrastructure described in the manifest.
If everything works well you should see your instance running the AWS console at EC2/Instances/Instances.

![EC2 shown in console](/res/ec2-in-console.png)

### Pro Tips
If you only want to see what changes Terraform will apply without doing them, you can run the *plan* command:

```sh
terraform plan
```

If you want to remove the infrastructure you've applied (to save you money), you can run the *destroy* command:

```sh
terraform destroy
```
The EC2 instance you've created should be then have a status value noted as "Terminated" (it will later be completely removed for the UI after an hour).
