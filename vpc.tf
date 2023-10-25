data "aws_availability_zones" "available" {
    state = "available"
}

resource "aws_vpc" "bitgouel-vpc" {
    cidr_block = "192.168.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support = true
    instance_tenancy = "default"

    tags = {
        Name = "bitgouel-vpc"
    }
}

# Create Public Subnet
# Create Subnet Public
resource "aws_subnet" "bitgouel-public-subnet-2a" {
    vpc_id = aws_vpc.bitgouel-vpc.id
    cidr_block = "192.168.0.0/20"
    map_public_ip_on_launch = true
    availability_zone = data.aws_availability_zones.available.names[0]

    tags = {
        "Name" = "hi-public-subnet-2a"
    }
}

resource "aws_subnet" "bitgouel-public-subnet-2b" {
    vpc_id = aws_vpc.bitgouel-vpc.id
    cidr_block = "192.168.32.0/20"
    map_public_ip_on_launch = true
    availability_zone = data.aws_availability_zones.available.names[1]

    tags = {
        "Name" = "bitgouel-public-subnet-2b"
    }
}

## Create Subnet Private
resource "aws_subnet" "bitgouel-private-subnet-2a" {
    vpc_id = aws_vpc.bitgouel-vpc.id
    cidr_block = "192.168.16.0/20"
    map_public_ip_on_launch = false
    availability_zone = data.aws_availability_zones.available.names[0]

    tags = {
        "Name" = "bitgouel-private-subnet-2a"
    }
}

resource "aws_subnet" "bitgouel-private-subnet-2b" {
    vpc_id = aws_vpc.bitgouel-vpc.id
    cidr_block = "192.168.48.0/20"
    map_public_ip_on_launch = false 

    availability_zone = data.aws_availability_zones.available.names[1]

    tags = {
        "Name" = "bitgouel-private-subnet-2b"
    }
}
