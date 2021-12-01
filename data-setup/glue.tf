resource "aws_glue_catalog_database" "data" {
  name = var.bucket-name
}

resource "aws_glue_crawler" "data" {
  database_name = aws_glue_catalog_database.data.name
  name          = var.bucket-name
  role          = aws_iam_role.glue-service-role.arn
  table_prefix  = "${var.bucket-name}-"

  s3_target {
    path = "s3://${var.bucket-name}/data"
    exclusions = ["_SUCCESS"]
  }

}

resource "aws_iam_role" "glue-service-role" {
  name                 = "${var.bucket-name}-aws-glue-service-role"
  force_detach_policies = true
  assume_role_policy   = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "glue.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
}
EOF
}


resource "aws_iam_role_policy_attachment" "glue-service-role" {
  role       = aws_iam_role.glue-service-role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

data "aws_iam_policy_document" "read-s3" {
  statement {
    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion"
    ]
    resources = [
      "${aws_s3_bucket.data.arn}/*"
    ]
  }
}

resource "aws_iam_policy" "read-s3" {
  policy = data.aws_iam_policy_document.read-s3.json
}

resource "aws_iam_role_policy_attachment" "read-s3" {
  policy_arn = aws_iam_policy.read-s3.arn
  role = aws_iam_role.glue-service-role.id
}