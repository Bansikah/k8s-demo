terraform {
 required_providers {
   aws = {
     source  = "hashicorp/aws"
     version = "~> 3.0"
   }
 }
}
 
provider "aws" {
 region = var.region
}
 
variable "region" {
 default = "us-west-1"
 description = "AWS Region"
}
 
variable "ami" {
 default = "ami-00831fc7c1e3ddc60"
 description = "Amazon Machine Image ID for Ubuntu Server 20.04"
}
 
variable "type" {
 default = "t2.micro"
 description = "Size of VM"
}
 
resource "aws_instance" "demo" {
 ami = var.ami
 instance_type = var.type
 
 tags = {
   name = "Demo System"
 }
}
 
