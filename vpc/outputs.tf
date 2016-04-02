#
# Outputs file
#

output "aws_region" {
  value = "${var.aws_region}"
}
output "vpc_id" {
  value = "${aws_vpc.main-vpc.id}"
}
output "subnet_1_id" {
  value = "${aws_subnet.subnet-1.id}"
}
output "subnet_2_id" {
  value = "${aws_subnet.subnet-2.id}"
}
output "route_53_zone_id" {
  value = "${aws_route53_zone.primary.id}"
}
output "vpc_dns_tld" {
  value = "${var.internal_dns_tld}"
}
