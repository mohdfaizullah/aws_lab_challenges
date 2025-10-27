resource "aws_security_group" "security_group_payment_app" {
  name        = "payment_app"
  description = "Application Security Group"
  /*
  depends_on  = [aws_eip.example]
  */

  tags = {
    Name        = "payment_app"
    team        = "payment_team"
    Environment = "dev"

  }

  # Below ingress allows HTTPS  from DEV VPC
  ingress {
    from_port   = var.HTTPS
    to_port     = var.HTTPS
    protocol    = "tcp"
    cidr_blocks = [var.vpc]
    description = "Allow HTTPS traffic from DEV VPC"
    
  }

  # Below ingress allows APIs access from DEV VPC

  ingress {
    from_port   = var.APIs_dev
    to_port     = var.APIs_dev
    protocol    = "tcp"
    cidr_blocks = [var.vpc]
    description = "Allow APIs traffic from DEV VPC"

  }

  # Below ingress allows APIs access from Prod App Public IP.

  ingress {
    from_port = var.APIs_prod
    to_port   = var.APIs_prod
    protocol  = "tcp"
    /*cidr_blocks = ["${aws_eip.example.public_ip}/32"]8?*/
    description = "Allow APIs traffic from Prod App Public IP"
  }

  egress {
    from_port   = var.splunk
    to_port     = var.splunk
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow Splunk outbound traffic"
    
  }

}

/*
resource "aws_eip" "example" {
  domain = "vpc"
}
*/
