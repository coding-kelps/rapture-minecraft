# define configuration of AWS Terraform provider

provider "aws" {
  region  = "eu-west-3"

  assume_role {
    role_arn      = "arn:aws:iam::660168936356:role/KelpsGitOpsRole"
    session_name  = "TerraformAssumeRoleSession"
  }
}