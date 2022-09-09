resource "aws_instance" "primary-az1" {
  instance_type          = var.instance_class
  ami                    = var.ami_id
  key_name               = var.key_name
  subnet_id              = aws_subnet.primary-az1.id
  vpc_security_group_ids = [aws_security_group.primary-default.id]

  connection {
    host = coalesce(self.public_ip, self.private_ip)
    type = "ssh"
    user = "ubuntu"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt install python3 python3-pip git",
      "git clone https://github.com/vineetx/fuzzy-funicular.git",
      "cd fuzzy-funicular/e6data",
      "pip3 install -r requirements.txt",
      "python3 main.py",
    ]
  }
}

resource "aws_instance" "secondary-az1" {
  instance_type          = var.instance_class
  ami                    = var.ami_id
  key_name               = var.key_name
  subnet_id              = aws_subnet.secondary-az1.id
  vpc_security_group_ids = [aws_security_group.secondary-default.id]

  connection {
    host = coalesce(self.public_ip, self.private_ip)
    type = "ssh"
    user = "ubuntu"
  }

  provisioner "remote-exec" {
    inline = [
      "curl ${aws_instance.primary-az1.private_dns}:5000"
    ]
  }
  depends_on = [aws_instance.primary-az1]
}
