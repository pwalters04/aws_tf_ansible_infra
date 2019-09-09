#Resource: Create IAM Users / Groups
resource "aws_iam_role_policy" "ec2_role_policy" {
  name = "ec2_role_policy"
  role = "${aws_iam_role.ec2_role.id}"
  policy = "${file("ec2_policy.json")}"
}
resource "aws_iam_role" "ec2_role" {
  name = "ec2_role"
  assume_role_policy ="${file("ec2_assume_policy.json")}"
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_role_john"
  role = "${aws_iam_role.ec2_role.name}"
}

resource "aws_iam_group_policy" "ops_group_policy" {
  name  = "ops_group_policy"
  group = "${aws_iam_group.ops_group.id}"
  policy = "${file("group_policy.json")}"
}

resource "aws_iam_policy" "policy" {
  name        = "test_policy"
  path        = "/"
  description = "OPS Policy"

  policy ="${file("iam_policy.json")}"
}

resource "aws_iam_group" "ops_group" {
  name = "ops_people"
  path = "/users/"
}

resource "aws_iam_group_policy_attachment" "test-attach" {
  group      = "${aws_iam_group.ops_group.name}"
  policy_arn = "${aws_iam_policy.policy.arn}"
}

resource "aws_iam_user" "ops_user_1" {
  name = "John_Doe"
  tags = {
    tag-key = "Ops-Peeps"
  }
}

resource "aws_iam_user" "ops_user_2" {
  name = "Bob_Doe"
  tags = {
    tag-key = "Ops-Peeps"
  }
}
resource "aws_iam_group_membership" "ops-users" {
    name = "ops-users"
    users = [
        "${aws_iam_user.ops_user_1.name}",
        "${aws_iam_user.ops_user_2.name}"
    ]
    group = "${aws_iam_group.ops_group.name}"
}