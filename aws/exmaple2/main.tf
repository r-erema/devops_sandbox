provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

variable "aws_access_key" {
  type = string
  description = "AWS access key"
}
variable "aws_secret_key" {
  type = string
  description = "AWS secret key"
}
variable "aws_region" {
  type = string
  description = "AWS region"
}

variable "transition_cloudtrail_logs_to_glacier_delay_days" {
  default = "365"
}

variable "cloudtrail_logs_retention_period" {
  default = "1095"
}
