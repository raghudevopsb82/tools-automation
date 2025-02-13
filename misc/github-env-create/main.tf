terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

# Configure the GitHub Provider
provider "github" {
  owner = "raghudevopsb82"
}

data "github_user" "current" {
  username = "r-devops"
}

resource "github_repository_environment" "env" {
  environment         = "DEV"
  repository          = "roboshop-cart"
  prevent_self_review = false
  reviewers {
    users = [data.github_user.current.id]
  }
}

