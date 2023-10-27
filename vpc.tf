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
        "Name" = "bitgouel-public-subnet-2a"
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

# Create Internet Gateway
resource "aws_internet_gateway" "bitgouel-igw" {
    vpc_id = aws_vpc.bitgouel-vpc.id
}

# Create EIP
resource "aws_eip" "nat_ip" {
    vpc = true
    
    lifecycle {
        create_before_destroy = true
    }
}

# Create Nat Gateway

resource "aws_nat_gateway" "bitgouel-nat" {
    allocation_id = aws_eip.nat_ip.id
    subnet_id = aws_subnet.bitgouel-public-subnet-2a.id

    tags = {
        Name = "bitgouel-nat"
    }
}

# Create Route Table
## Create Public Route Table

resource "aws_route_table" "bitgouel-public-rtb" {
    vpc_id = aws_vpc.bitgouel-vpc.id

    tags = {
        Name = "bitgouel-public-rtb"
    }
}

## Create Private Route Table
resource "aws_route_table" "bitgouel-private-rtb" {
    vpc_id = aws_vpc.bitgouel-vpc.id

    tags = {
        Name = "bitgouel-private-rtb"
    }
}

# Subnet Register RTB
## Public Subnet Register RTB

resource "aws_route_table_association" "bitgouel-public-rt-association-1" {
    subnet_id = aws_subnet.bitgouel-public-subnet-2a.id
    route_table_id = aws_route_table.bitgouel-public-rtb.id
}

resource "aws_route_table_association" "bitgouel-public-rt-association-2" {
    subnet_id = aws_subnet.bitgouel-public-subnet-2b.id
    route_table_id = aws_route_table.bitgouel-public-rtb.id
}

## Private Subnet Register RTB 
resource "aws_route_table_association" "bitgouel-private-rt-association-1" {
    subnet_id = aws_subnet.bitgouel-private-subnet-2a.id
    route_table_id = aws_route_table.bitgouel-private-rtb.id
}

resource "aws_route_table_association" "bitgouel-private-rt-association-2" {
    subnet_id = aws_subnet.bitgouel-private-subnet-2b.id
    route_table_id = aws_route_table.bitgouel-private-rtb.id
}

## Internet Gateway Register RTB
resource "aws_route" "bitgouel-public-rt-igw" {
    route_table_id = aws_route_table.bitgouel-public-rtb.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.bitgouel-igw.id
}

## Nat Register RTB
resource "aws_route" "bitgouel-private-rt-nat" {
    route_table_id = aws_route_table.bitgouel-private-rtb.id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.bitgouel-nat.id
}
