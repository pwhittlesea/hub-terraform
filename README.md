# hub-terraform
Terraform deployment configuration to deploy the https://github.com/flightstats/hub into a VPC on AWS

TODO
- [x] Allow setup of a VPC if one does not already exist
- [x] Create a ZooKeeper cluster of a configurable size (default 3)
- [ ] Create Dynamo DB tables (including IAM roles)
- [ ] Create S3 bucket (including IAM roles)
- [ ] Create a Hub cluster of a configurable size (default 3)
- [ ] Create a Load Balancer for the Hub cluster
- [ ] Ensure health checks are in place for all components (with auto restart on failure)
- [ ] Support regions other than eu-west-1
