variable "region" {
  description = "The location where instacne will be created"
  default     = "ap-hongkong"
}

variable "availability_zone" {
  default = "ap-hongkong-2"
}

# ECS insance variables 
variable "image_id" {
  default = ""
}

variable "instance_type" {
  default = ""
}

variable "instance_name" {
  default = "alex-cvm"
}

variable "password" {
  default = "password123"
}

# VPC Info
variable "short_name" {
  default = "tf-vpc"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

# VSwitch Info
variable "web_cidr" {
  default = "10.0.1.0/24"
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