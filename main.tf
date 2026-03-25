resource "aws_instance" "my_instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name   
  vpc_security_group_ids = var.security_group_id

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
