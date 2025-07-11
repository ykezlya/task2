module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Terraform = "true"
    Environment = "dev"
    Name = "task2"
  }
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id       = module.vpc.vpc_id
  service_name = "com.amazonaws.eu-west-1.s3"
   tags = {
    Name = "task2-s3-interface-endpoint"
  }
  subnet_ids = module.vpc.private_subnets
  vpc_endpoint_type = "Interface" 
  private_dns_enabled = false
  security_group_ids = [aws_security_group.AccessToEndpoints.id]
}

resource "aws_vpc_endpoint" "s3gw" {
  vpc_id       = module.vpc.vpc_id
  service_name = "com.amazonaws.eu-west-1.s3"
   tags = {
    Name = "task2-s3-gateway-endpoint"
  }
  vpc_endpoint_type = "Gateway" 
  private_dns_enabled = false
  route_table_ids = module.vpc.private_route_table_ids
}

resource "aws_vpc_endpoint" "ecrapi" {
  vpc_id       = module.vpc.vpc_id
  service_name = "com.amazonaws.eu-west-1.ecr.api"
   tags = {
    Name = "task2-ecr-api-endpoint"
  }
  subnet_ids = module.vpc.private_subnets
  vpc_endpoint_type = "Interface" 
  private_dns_enabled = true
  security_group_ids = [aws_security_group.AccessToEndpoints.id]
}

resource "aws_vpc_endpoint" "ecrdkr" {
  vpc_id       = module.vpc.vpc_id
  service_name = "com.amazonaws.eu-west-1.ecr.dkr"
   tags = {
    Name = "task2-ecr-dkr-endpoint"
  }
  subnet_ids = module.vpc.private_subnets
  vpc_endpoint_type = "Interface" 
  private_dns_enabled = true
  security_group_ids = [aws_security_group.AccessToEndpoints.id]
}

resource "aws_vpc_endpoint" "logs" {
  vpc_id       = module.vpc.vpc_id
  service_name = "com.amazonaws.eu-west-1.logs"
   tags = {
    Name = "task2-logs-endpoint"
  }
  subnet_ids = module.vpc.private_subnets
  vpc_endpoint_type = "Interface" 
  private_dns_enabled = true
  security_group_ids = [aws_security_group.AccessToEndpoints.id]
}