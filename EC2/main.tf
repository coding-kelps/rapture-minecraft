# Defines the configuration of Terraform for the setup of the infrastructure
# in this module
terraform {
  # Defines the providers of resources (in our case cloud computing resource
  # as aws will provide us a EC2 instance)
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

# Define the configuration of our provider (in our case here we want to ensure
# that our EC2 instance will be hosted in Paris region)
provider "aws" {
  region  = "eu-west-3" // => the AWS Paris region code
}

# Define the configuration of the resource we want to setup
# it is of type "aws_instance" (=> EC2) and its name is
# "rapture_testing_instance"
resource "aws_instance" "rapture_testing_instance" {
  # ami => amazon machine image (the image that
  # will define which OS will be used on the machine)
  ami           = "ami-05b5a865c3579bbc4" // The ami ID for Ubuntu 22.04
  instance_type = "t2.micro" // The type (~size) of the machine

  # Here we can define all the tags we wants
  # AWS will automatically recognize the "Name" label and will displays it
  # on the AWS console.
  tags = {
    Name = "rapture-testing-instance"
  }
}