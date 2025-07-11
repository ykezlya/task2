resource "aws_security_group" "AccessToEndpoints" {
  name        = "AccessToEndpoints"
  description = "Allow HTTPs inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = module.vpc.private_subnets_cidr_blocks
    }
    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic
  } 
    tags = {
        Name = "AccessToEndpoints"
        Environment = "dev"
        Name = "task2"
    }
}

resource "aws_security_group" "ALBAccess" {
  name        = "ALBAccess"
  description = "Allow ALB inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic
  }
  tags = {
    Name = "Task2-AccessToALB" 
  }
}

resource "aws_security_group" "ECSAccess" {
  name        = "ECSAccess"
  description = "Allow ECSA inbound traffic from ALB"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = module.vpc.public_subnets_cidr_blocks
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic
  }
  tags = {
    Name = "Task2-ECSAccess" 
  }
}
