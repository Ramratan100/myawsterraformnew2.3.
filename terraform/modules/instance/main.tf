resource "aws_instance" "bastion_host" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = var.public_subnet_id
  security_groups = [var.bastion_sg_id]
  associate_public_ip_address = true

user_data = <<-EOF
    #!/bin/bash

    # Update system and install required packages
    sudo apt-get update -y
    sudo apt-get install -y python3 python3-pip awscli apache2

    # Install Python packages
    sudo pip3 install boto3

    # Create /home/ubuntu directory if it does not exist
    sudo mkdir -p /home/ubuntu

    # Download the private key (jenkins.pem) from the presigned URL
    wget "https://ramratan-bucket-2510.s3.amazonaws.com/jenkins.pem?AWSAccessKeyId=AKIAZ3MGMYHMT6M3VUVM&Signature=eApwyOpugPZnjl1LgQy%2FUHMAdBg%3D&Expires=1734595756" -O /home/ubuntu/jenkins.pem

    # Set the appropriate permissions for the private key
    sudo chmod 400 /home/ubuntu/jenkins.pem

    # Change the ownership of jenkins.pem to ubuntu
    sudo chown ubuntu:ubuntu /home/ubuntu/jenkins.pem

    # Fetch the private IP of the MySQL instance dynamically
    MYSQL_IP=$(aws ec2 describe-instances \
        --instance-ids ${aws_instance.mysql_instance.id} \
        --query "Reservations[].Instances[].PrivateIpAddress" \
        --output text)

    # Create a PHP test page to verify MySQL connectivity
    echo "<?php phpinfo(); ?>" | sudo tee /var/www/html/index.php
    echo "<?php
    \$conn = new mysqli('$MYSQL_IP', 'net_user', 'password', 'mysql');
    if (\$conn->connect_error) { die('Connection failed: ' . \$conn->connect_error); }
    echo 'Connected successfully';
    ?>" | sudo tee /var/www/html/test.php

    # Start and enable Apache service
    sudo systemctl start apache2
    sudo systemctl enable apache2
EOF

  tags = {
    Name = "Bastion-Host"
  }
}

resource "aws_instance" "mysql_instance" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = var.private_subnet_id
  security_groups = [var.mysql_sg_id]



  tags = {
    Name = "MySQL-Instance"
  }
}
