provider "aws" {
  region = "us-east-1" # Update this as per your requirements
}

resource "aws_instance" "web_server" {
  ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2 AMI
  instance_type = "t2.micro"

  tags = {
    Name = "TerraformWebServer"
  }

  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install -y python3 git
    sudo pip3 install flask boto3
    git clone https://github.com/<your-username>/<your-http-service-repo>.git
    cd <your-http-service-repo>
    python3 main.py &
  EOF
}

output "public_ip" {
  value = aws_instance.web_server.public_ip
}
