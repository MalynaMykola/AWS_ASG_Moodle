resource "aws_launch_configuration" "moodle" {
    name_prefix = "moodle"
    image_id = var.ami
    instance_type = var.instance_type
    user_data = data.template_file.script.rendered
    iam_instance_profile = "${aws_iam_instance_profile.moodle-instance-profile.id}"
    security_groups = [ "${aws_security_group.allow_http.id}"]
    lifecycle {
        create_before_destroy = true
    }
    key_name = "test"
}

resource "aws_autoscaling_group" "moodle" {
    name = "moodle-asg"
    launch_configuration = "${aws_launch_configuration.moodle.name}"
    min_size = 5
    max_size = 5
    vpc_zone_identifier = "${aws_subnet.private.*.id}"
    load_balancers = ["${aws_elb.app.name}"]
    lifecycle {
        create_before_destroy = true
    }
    
}

resource "aws_iam_role" "moodle-instance-role" {
    name = "moodle-instance-role"
    assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}
resource "aws_iam_instance_profile" "moodle-instance-profile" {
    name = "moodle-instance-profile"
    roles = ["${aws_iam_role.moodle-instance-role.name}"]
}
