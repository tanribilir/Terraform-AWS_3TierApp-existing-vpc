# Terraform and AWS (into existing VPC)

Forked from https://github.com/tellisnz/terraform-aws.git

Modified terraform/terraform.tfvars file

A template and configuration that reuses modules from the terraform registry to deploy a sample app to an existing VPC, where:

The public presentation tier is an nginx host serving AngularJS static content
that passes API requests through to the private application tier.

The private application tier hosts a spring boot application that persists data
in the DB tier.

The db tier hosts an RDS PostgreSQL instance.

Sample app from (here)[http://javasampleapproach.com/spring-framework/spring-mvc/angular-4-spring-jpa-postgresql-example-angular-4-http-client-spring-boot-restapi-server].

# Usage

Retrieve public key of your keypair with command [MacOS/Linux]: `ssh-keygen -y -f /path_to_key_pair/my-key-pair.pem`

Do not forget to change `KeyPair_terraform` parameter in `app-asg.tf` and `web-asg.tf` files.

Take a copy of terraform.tfvars.template and substitute required values.

Create plan, i.e. `terraform plan -out out-into_existing_vpc.tfplan`

Apply as per normal, i.e. `terraform apply "out-into_existing_vpc.tfplan"`

# Testing

Install go and deps and check out code to $GOPATH/src

Run `go test -v -timeout 20m -run TestTerraformAws`
