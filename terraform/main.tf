terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "meridian-terraform-state"
    key    = "ant-project/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.aws_region
}

variable "aws_region" {
  default = "us-east-1"
}

resource "aws_ecs_service" "ant_project" {
  name            = "ant-project"
  cluster         = "meridian-cluster"
  task_definition = aws_ecs_task_definition.ant_project.arn
  desired_count   = 2
}

resource "aws_ecs_task_definition" "ant_project" {
  family                = "ant-project"
  container_definitions = jsonencode([{
    name  = "ant-project"
    image = "meridian/ant-project:latest"
    portMappings = [{ containerPort = 8080 }]
  }])
}
