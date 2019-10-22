provider "aws" {
  region     = "${var.region}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}


resource "aws_instance" "myec2" {
  ami = "ami-0b69ea66ff7391e80"
  instance_type = "t2.micro"

 tags = {
    Name = "MyTerraform-Instance"
    Owner = "shiva Prasad"
  }
}

output "publicIP" {
    value = aws_instance.myec2.public_ip
}

output "privateIP" {
    value = aws_instance.myec2.private_ip
}

output "az" {
    value = aws_instance.myec2.availability_zone
}
