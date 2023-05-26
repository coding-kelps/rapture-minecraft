# Define VPC (Virtual Private Cloud)
resource "aws_default_vpc" "default" {

}

resource "aws_key_pair" "kp" {
  key_name   = "rapture-minecraft-ec2-instance-ansible-key-pair"
  public_key = var.ssh_public_key

  tags = {
    kelps               = ""
    kelps-project       = "rapture"
    kelps-rapture-game  = "minecraft"
  }
}

# Security group
resource "aws_security_group" "sg" {
  name        = "RaptureMinecraftSecurityGroup"
  description = "allow ssh on 22 & http on port 80"
  vpc_id      = aws_default_vpc.default.id

  tags = {
    kelps               = ""
    kelps-project       = "rapture"
    kelps-rapture-game  = "minecraft"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_all_traffic_to_server" {
  security_group_id = aws_security_group.sg.id

  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"

  tags = {
    kelps               = ""
    kelps-project       = "rapture"
    kelps-rapture-game  = "minecraft"
  }
}


resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_from_server" {
  security_group_id = aws_security_group.sg.id

  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"

  tags = {
    kelps               = ""
    kelps-project       = "rapture"
    kelps-rapture-game  = "minecraft"
  }
}

# Define ec2 server
resource "aws_instance" "minecraft_server" {
  ami             = "ami-045a8ab02aadf4f88"
  instance_type   = "c5.9xlarge"
  security_groups = [aws_security_group.sg.name]
  key_name = aws_key_pair.kp.key_name

  tags = {
    Name                = "rapture-minecraft-server"
    kelps               = ""
    kelps-project       = "rapture"
    kelps-rapture-game  = "minecraft"
    associated-domain   = "minecraft.kelps.org"
  }
}