variable "mongodbatlas_public_key" {
  type = string
}

variable "mongodbatlas_private_key" {
  type = string
}

variable "project_name" {
  type = string
}

variable "org_id" {
  type = string
}

variable "cluster_name" {
  type = string
}

terraform {
  backend "s3" {
    bucket         = "terrafacer"
    key            = "non-prod/atlas.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform"
    encrypt        = true
  }
  required_providers {
    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
      version = "=1.1.1"
    }
  }
}

provider "mongodbatlas" {
  public_key  = var.mongodbatlas_public_key
  private_key = var.mongodbatlas_private_key
}

module "atlas_cluster" {
  source       = "git::https://github.com/tdfacer/terrafacer.git//terraform/modules/atlas-cluster?ref=atlas-cluster"
  project_name = var.project_name
  org_id       = var.org_id
  cluster_name = var.cluster_name
}
