resource "aws_elb" "app" {
  name = "foobar-terraform-elb"

  subnets         = "${aws_subnet.public.*.id}"
  security_groups = ["${aws_security_group.allow_http.id}"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "TCP:80"
    interval            = 5
  }

  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "app-elb"
  }
}
