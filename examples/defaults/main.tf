variable "aws_region" {
  default = "us-east-1"
}

provider "aws" {
  region = var.aws_region
}

variable "public_key_path" {}
variable "private_key_path" {}


module "vpc" {
  source = "github.com/insight-infrastructure/terraform-aws-default-vpc.git?ref=v0.2.0"
}

resource "aws_security_group" "this" {
  vpc_id = module.vpc.vpc_id

  dynamic "ingress" {
    for_each = [
      22,
      80,
      443,
      3000,
      7100,
      9000,
      9090,
      9093,
    9094]
    content {
      from_port = ingress.value
      to_port   = ingress.value
      protocol  = "tcp"
      cidr_blocks = [
      "0.0.0.0/0"]
    }
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
    "0.0.0.0/0"]
  }
}

module "defaults" {
  source                 = "../.."
  private_key_path       = var.private_key_path
  public_key_path        = var.public_key_path
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.this.id]
}
