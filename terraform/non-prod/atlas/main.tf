# variables

## provider
variable "mongodbatlas_public_key" {
  type        = string
  description = "public key for mongodbatlas API access"
}

variable "mongodbatlas_private_key" {
  type        = string
  description = "private key for mongodbatlas API access"
}

## project
variable "project_name" {
  type        = string
  description = "name of the atlas project"
}

variable "org_id" {
  type        = string
  description = "id of the atlas org"
}

## cluster
variable "cluster_name" {
  type        = string
  description = "name of the atlas cluster"
}

variable "create_cluster" {
  # if using free tier, atlas API does not support create via API
  type        = bool
  description = "whether or not to create the atlas cluster"
}

variable "cluster_version" {
  type        = string
  description = "mongodb version, e.g. 4.4"
}

## db
variable "database_name" {
  type        = string
  description = "name of the database"
}

## user
variable "user_name" {
  type        = string
  description = "name of the user that will be used by the application"
}

variable "user_password" {
  type        = string
  description = "password of the user that will be used by the application"
}

## access
variable "whitelist_ips" {
  type = map(object({
    ip          = string
    description = string
  }))
  description = "object map of ips to whitelist"
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
  source          = "git::https://github.com/tdfacer/terrafacer.git//terraform/modules/atlas-cluster?ref=v2.0.2"
  project_name    = var.project_name
  org_id          = var.org_id
  cluster_name    = var.cluster_name
  create_cluster  = var.create_cluster
  cluster_version = var.cluster_version
  database_name   = var.database_name
  user_name       = var.user_name
  user_password   = var.user_password
  whitelist_ips   = var.whitelist_ips
}
