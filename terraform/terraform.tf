# Define the configuration of Terraform itself

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.47.0"
    }
  }
  required_version = "~> 1.15.5"

  backend "s3" {
    bucket  = "kelps-gitops"
    key     = "tfstates/rapture-minecraft.tfstate"
    region  = "eu-west-3"

    assume_role = {
      role_arn      = "arn:aws:iam::660168936356:role/KelpsGitOpsRole"
      session_name  = "TerraformBackendSession"
    }
  }
}
