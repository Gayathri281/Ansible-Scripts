#template
data "template_file" "webapp"
{
template="$$(username),$$(password)"
vars=
{
    "username"="someusername"
    "password"="somepassword"
}

}

#variable

variable "aws_region"
{
    default="us-east-1"
}
variable "webserver_amis"
{
    type="map"
}

variable "availability_zone"
{
    type="list"
    default=["us-east-1a","us-east-1b","us-east-1c","us-east-1d"]
}

#provider

provider "aws" {
    access_key="Specify_your_access_key"
    secret_key="Specify_your_secret_key"
    region="${var.aws_region}"
}
#resource
resource "aws_instance" "appserver"
{
    ami="${lookup(var.webserver_amis,var.aws_region)}"
    instance_type="t2.micro"
    count="${var.availability_zone<=2?4:1}"
}
output "ips"
{
    value="${aws_instance.appserver.*.public_ip}"
}
resource "aws_default_subnet" "subnet"
{
    ami="${lookup(var.webserver_amis,var.aws_region)}"
    instance_type="t2.micro"
    subnet_id="${aws_default_subnet.subnet.id}"

}
resource "aws_security_group" "security_group" {
    name="security_group"
    ingress{
        from_port=0
        to_port=22
        protocol="http"
        cidr_block=["0.0.0.0/0"]
    }
  egress{
        from_port=0
        to_port=0
        protocol="-1"
        cidr_block=["0.0.0.0/0"]
    }
  
}

provisioner "remote"
{
    inline=["ttraffic..."

    ]
}
#webserver_amis.tfvars
webserver_amis=
{
    "ami-b374d5a5"="us-east-1"
     "ami-b535c6d8"="us-west-1"
      "ami-b36g75a9"="us-north-1"
       "ami-b374u75"="us-south-1"

}
 

 
  

