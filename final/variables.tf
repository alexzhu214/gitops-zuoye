# Tencent Cloud variables.
variable "region" {
  description = "The location where instacne will be created"
  default     = "ap-hongkong"
}

# harbor default registry name
variable "registry" {
  default = "example"
}

variable "harbor_password" {
  default = "Harbor12345"
}

variable "pg_password" {
  default = "password123"
}

variable "example_project_name" {
  default = "camp-go-example"
}



# grafana
variable "grafana_password" {
  default = "password123"
}

# jenkins
variable "jenkins_password" {
  default = "password123"
}

# sonar
variable "sonar_password" {
  default = "password123"
}

# argocd password, do not change it!
variable "argocd_password" {
  default = "password123"
}

# github
variable "github_username" {
  default = ""
}

# change me!
variable "github_personal_token" {
  default = ""
}

# Default variables


variable "instance_charge_type" {
  type    = string
  default = "SPOTPAID"
}

variable "tags" {
  description = "A map of the tags to use for the resources that are deployed"
  type        = map(string)

  default = {
    # This value will be the tage text.
    web = "tf-web"
    dev = "tf-dev"
  }
}


# instance password
variable "password" {
  default = "password123"
}

variable "domain" {
  default = "gkdevopscamp2.com"
}

variable "prefix" {
  default = "8424"
}

variable "secret_id" {
  default = "Your Access ID"
}

variable "secret_key" {
  default = "Your Access Key"
}