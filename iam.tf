resource "aws_iam_role" "this" {
  count              = var.create ? 1 : 0
  name               = "${title(var.name)}Role${title(random_pet.this.id)}"
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

  tags = var.tags
}

resource "aws_iam_instance_profile" "this" {
  count = var.create ? 1 : 0

  name = "${title(var.name)}InstanceProfile${title(random_pet.this.id)}"
  role = join("", aws_iam_role.this.*.name)
}

resource "aws_iam_policy" "ebs_mount_policy" {
  count  = ! local.instance_store_enabled && var.create && var.ebs_volume_size > 0 ? 1 : 0
  name   = "${title(var.name)}EbsMountPolicy${title(random_pet.this.id)}"
  policy = <<-EOT
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "EbsVolumeAttach",
            "Effect": "Allow",
            "Action": [
                "ec2:AttachVolume"
            ],
            "Resource": "[${aws_ebs_volume.this.*.arn[0]},${aws_instance.this.*.arn[0]}]"
        },
        {
            "Sid": "EbsVolumeDescribe",
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeVolumeStatus",
                "ec2:DescribeVolumes",
                "ec2:DescribeVolumeAttribute",
                "ec2:DescribeInstances"
            ],
            "Resource": "*"
        }
    ]
}
EOT
}

resource "aws_iam_role_policy_attachment" "ebs_mount_policy" {
  count = ! local.instance_store_enabled && var.create && var.ebs_volume_size > 0 ? 1 : 0

  role = join("", aws_iam_role.this.*.id)

  policy_arn = aws_iam_policy.ebs_mount_policy.*.arn[0]
}

resource "aws_iam_policy" "s3_put_logs_policy" {
  count = var.logs_bucket_enable && var.create ? 1 : 0

  name   = "${title(var.name)}S3PutLogsPolicy${title(random_pet.this.id)}"
  policy = <<-EOT
{
    "Version": "2012-10-17",
    "Statement": [
        {
          "Sid":"ReadWrite",
          "Effect":"Allow",
          "Action":["s3:GetObject", "s3:PutObject"],
          "Resource":["arn:aws:s3:::${aws_s3_bucket.logs.*.bucket[0]}/*"]
        }
    ]
}

EOT
}

resource "aws_iam_role_policy_attachment" "s3_put_logs_policy" {
  count = var.ebs_volume_size > 0 && var.create ? 1 : 0

  role = join("", aws_iam_role.this.*.id)

  policy_arn = aws_iam_policy.s3_put_logs_policy.*.arn[0]
}