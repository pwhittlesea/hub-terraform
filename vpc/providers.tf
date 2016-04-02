#
# AWS provider will use the region and the profile specified.
#
provider "aws" {
  region = "${var.aws_region}"
  profile = "${var.aws_profile}"
}
