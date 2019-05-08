resource "aws_security_group" "elb_web" {
  name = "${format("%s-elb-web-sg", var.name)}"

  vpc_id = "${var.vpc_id}"

  ingress {
    from_port   = "${var.web_port}"
    to_port     = "${var.web_port}"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Group = "${var.name}"
  }
}

module "elb_web" {
  source = "terraform-aws-modules/elb/aws"

  name = "${format("%s-elb-web", var.name)}"

  subnets         = ["${var.vpc_public_subnetids}"]
  security_groups = ["${aws_security_group.elb_web.id}"]
  internal        = false

  listener = [
    {
      instance_port     = "${var.web_port}"
      instance_protocol = "HTTP"
      lb_port           = "${var.web_port}"
      lb_protocol       = "HTTP"
    },
  ]

  health_check = [
    {
      target              = "HTTP:${var.web_port}/"
      interval            = "${var.web_elb_health_check_interval}"
      healthy_threshold   = "${var.web_elb_healthy_threshold}"
      unhealthy_threshold = "${var.web_elb_unhealthy_threshold}"
      timeout             = "${var.web_elb_health_check_timeout}"
    },
  ]

  tags {
    Group = "${var.name}"
  }

}

variable "web_elb_health_check_interval" {
  description = "Duration between health checks"
  default = 20
}

variable "web_elb_healthy_threshold" {
  description = "Number of checks before an instance is declared healthy"
  default = 2
}

variable "web_elb_unhealthy_threshold" {
  description = "Number of checks before an instance is declared unhealthy"
  default = 2
}

variable "web_elb_health_check_timeout" {
  description = "Interval between checks"
  default = 5
}

variable "vpc_public_subnetids" {
  description = "self explanatory"
  default = []
}


output "elb_dns_name" {
  value = "${module.elb_web.this_elb_dns_name}"
}

