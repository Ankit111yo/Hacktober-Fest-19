

provider "aws" {
    access_key="${var.akey}"
    secret_key="${var.skey}"
    region="us-east-1"
  
}


resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
  tags{
      Name="myvpc"
  }
}

resource "aws_customer_gateway" "mycg" {
    ip_address="${var.cgip}"
    type="ipsec.1"
    bgp_asn=65000
    tags{
        Name="mycg"
    }
}

resource "aws_vpn_gateway" "myvpg" {
  vpc_id = "${aws_vpc.myvpc.id}"

  tags = {
    Name = "myvpg"
  }
}

resource "aws_vpn_connection" "myvpncon" {
    customer_gateway_id="${aws_customer_gateway.mycg.id}"
    vpn_gateway_id="${aws_vpn_gateway.myvpg.id}"
    type="ipsec.1"
}
