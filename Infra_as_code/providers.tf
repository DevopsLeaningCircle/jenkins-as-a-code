terraform {
  required_version = "~> 1.12"
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "devopslearningcircle-terraform-statefile"
    key = "terraform/Jenkins-as-a-code/Infra_as_code/state.tfstate"
    region = "us-east-1"
    use_lockfile = true
    
  }
}

provider "aws" {
  region = "us-east-1"
}