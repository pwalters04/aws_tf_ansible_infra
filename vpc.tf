resource "aws_subnet" "public" {
  count = "${length(var.subnets_cidr)}"
  vpc_id = "${aws_vpc.vpc-rds.id}"
  cidr_block = "${element(var.subnets_cidr,count.index)}"
  availability_zone = "${element(var.azs,count.index)}"
  tags ={
    Name = "Subnet-Public${count.index+1}"
  }
}

resource "aws_internet_gateway" "gateway-global" {
  vpc_id = "${aws_vpc.vpc-rds.id}"
  tags = {
    Name = "global-gateway"
  }
}

resource "aws_route_table" "public-rt-sandbox" {
    vpc_id="${aws_vpc.vpc-rds.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id ="${aws_internet_gateway.gateway-global.id}"
    }
    tags = {
        Name = "RDSpublicRouteTable"
    } 
}

resource "aws_route_table_association" "link-rt-sandbox" {
    count = "${length(var.subnets_cidr)}"
    subnet_id      = "${element(aws_subnet.public.*.id,count.index)}"
    route_table_id = "${aws_route_table.public-rt-sandbox.id}"
}