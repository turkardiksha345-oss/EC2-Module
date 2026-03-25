

resource "aws_security_group" "my_sg" {
  name        = "my-sg"
  description = "Allow inbound and outbound rule"
  vpc_id      = var.vpc_id

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
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "my-sg"
  }
}

resource "aws_instance" "my_instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name   
  vpc_security_group_ids = [aws_security_group.my_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install nginx -y
              echo "<h1> hello this is nginx page </h1>" > /var/www/html/index.html
              sudo systemctl start nginx
              sudo systemctl enable nginx
              EOF

  tags = {
    Name = "my-instance"   
  }
}
