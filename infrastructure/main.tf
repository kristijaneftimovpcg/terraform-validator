data "aws_availability_zones" "available-eu-west" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

module "default_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~>5.0.0"

  name = "default-vpc"

  cidr = "10.1.0.0/16"
  azs  = slice(data.aws_availability_zones.available-eu-west.names, 0, 3)

  private_subnets  = ["10.1.1.0/24", "10.1.2.0/24"]
  public_subnets   = ["10.1.3.0/24", "10.1.4.0/24"]
  database_subnets = [for k, v in data.aws_availability_zones.available-eu-west.names : cidrsubnet("10.1.0.0/16", 8, k + 6)]

  enable_nat_gateway   = false
  enable_dns_hostnames = true
}


resource "aws_security_group" "ssh" {
  name        = "ssh-security-group"
  description = "SSH Security Group"
  vpc_id      = module.default_vpc.vpc_id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

module "s3" {
  source      = "./modules/s3"
  bucket-name = "default-s3-bucket"
}

# module "default_lambda" {
#   source = "terraform-aws-modules/lambda/aws"

#   function_name = "default_lambda"
#   description   = "Default Lambda function"
#   handler       = "index.handler"
#   runtime       = "nodejs20.x"
#   timeout       = 60
#   memory_size   = 256

#   source_path = "./modules/lambda"

#   attach_policy_json = true
#   policy_json = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Effect = "Allow",
#         Action = [
#           "s3:PutObject",
#           "s3:PutObjectAcl",
#           "s3:GetObject"
#         ],
#         Resource = [
#           "${module.s3.bucket_arn}",
#           "${module.s3.bucket_arn}/*",
#         ]
#       }
#     ]
#   })
#   ignore_source_code_hash = true
# }
