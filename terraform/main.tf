resource "aws_instance" "ubuntu-instance" {
  ami           = var.ami
  instance_type = "c7i-flex.large"
  
  security_groups = ["${aws_security_group.UbuntuSG.name}"]

  tags  = {
    Name  = "netflix-clone-EC2"
  }

  key_name      = aws_key_pair.UbuntuKP.key_name

}