provider "aws" {
  version = "~> 3.0"
  region  = "ca-central-1"
  profile = "vti"
}

terraform {
  required_version = ">= 0.13.0"

  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1.0"
    }
  }
}

provider "http" {}
