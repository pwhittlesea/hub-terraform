#
# Zookeeper cluster
#

# Security group for the Zookeeper nodes
resource "aws_security_group" "zk_sg" {
  name = "${var.stack_name}_zk_sg"
  description = "Zookeeper traffic for ${var.stack_name}"

  vpc_id = "${var.vpc_id}"

  tags {
    Name = "${var.stack_name}_zk_sg"
  }
}

# Allow inter-node access on all ports
resource "aws_security_group_rule" "zk_sg_inter" {
  type = "ingress"
  from_port = 0
  to_port = 0
  protocol = "-1"

  security_group_id = "${aws_security_group.zk_sg.id}"
  self = true
}

# Allow internet access
resource "aws_security_group_rule" "zk_sg_internet" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = [
    "0.0.0.0/0"
  ]
  security_group_id = "${aws_security_group.zk_sg.id}"
}

# Expand a template file for each Zookeeper node
resource "template_file" "zk_init_url" {
  count = "${var.zk_cluster_size}"

  template = "${file("templates/zookeeper_init_url.tpl")}"

  vars {
    zk_url = "zk_${format("%03d", count.index + 1)}.${var.stack_name}.${var.internal_dns_tld}"
    zk_id = "${count.index + 1}"
  }
}
resource "template_file" "zk_init" {
  count = "${var.zk_cluster_size}"

  template = "${file("templates/zookeeper_init.tpl")}"

  vars {
    zk_urls = "${join("", template_file.zk_init_url.*.rendered)}"
    zk_id = "${count.index + 1}"
  }
}

# Zookeeper machines
resource "aws_instance" "zookeeper" {
  count = "${var.zk_cluster_size}"

  ami = "${lookup(var.zk_amis, var.aws_region)}"
  instance_type = "${var.zk_instance_type}"

  associate_public_ip_address = true

  subnet_id = "${var.subnet_id_1}"
  security_groups = [
    "${aws_security_group.zk_sg.id}"
  ]

  key_name = "${var.ssh_key_name}"
  user_data = "${element(template_file.zk_init.*.rendered, count.index)}"

  tags {
    Name = "${element(template_file.zk_init_url.*.vars.zk_url, count.index)}"
    hub_stackname = "${var.stack_name}"
  }
}

resource "aws_route53_record" "zookeeper" {
  count = "${var.zk_cluster_size}"

  zone_id = "${var.route_53_zone_id}"

  name = "${element(template_file.zk_init_url.*.vars.zk_url, count.index)}"
  type = "A"
  ttl = "300"
  records = [
    "${element(aws_instance.zookeeper.*.private_ip, count.index)}"
  ]
}
