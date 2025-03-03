data "aws_availability_zones" "available" {}
provider "aws" {
  region  = var.aws_region
  # profile = var.aws_profile 
}