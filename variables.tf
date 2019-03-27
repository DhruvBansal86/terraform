variable "aws_access_key" {
    description = " aws accss key"
    default = "xxxxxxxxxxxxxxxxxxxxxxx"
}
variable "aws_secret_key" {
    description = "secrest"
    default = "xxxxxxxxxxxxxxxxxxxxxxx"
}

variable "aws_key_path" {}


variable "aws_key_name" { 
    description = "AWS Key Name"
    default = "terraform_keys"
}

variable "aws_region" {
    description = "EC2 Region for the VPC"
    default = "us-west-1"
}

variable "aws_az1" {
    description = "EC2 Availability Zone "
    default = "us-west-1a"
}

variable "user_data" {
  description = "Instance user data. Do not pass gzip-compressed data via this argument"
  default     = "user-data.sh"
}

variable "amis" {
    description = "AMIs by region"
    default = {
        us-west-1 = "ami-06397100adf427136" # ubuntu 14.04 LTS
    }
}

variable "vpc_cidr" {
    description = "CIDR for the whole VPC"
    default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
    description = "CIDR for the Public Subnet"
    default = "10.0.0.0/24"
}

variable "private_subnet_cidr" {
    description = "CIDR for the Private Subnet"
    default = "10.0.1.0/24"
}
