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

variable "create_cluster" {
  type = bool
}

variable "cluster_version" {
  type = string
}

variable "database_name" {
  type = string
}

variable "user_name" {
  type = string
}

variable "user_password" {
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
  source          = "git::https://github.com/tdfacer/terrafacer.git//terraform/modules/atlas-cluster?ref=atlasv0.0.7"
  project_name    = var.project_name
  org_id          = var.org_id
  cluster_name    = var.cluster_name
  create_cluster  = var.create_cluster
  cluster_version = var.cluster_version
  database_name   = var.database_name
  user_name       = var.user_name
  user_password   = var.user_password
}
