resource "aws_iam_role" "this" {
  name = "${var.bucket-name}-reader"
  assume_role_policy = data.aws_iam_policy_document.reader-assume.json
}

data "aws_iam_policy_document" "reader-assume" {
  statement {
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      identifiers = [
        data.aws_caller_identity.this.arn
      ]
      type        = "AWS"
    }
  }
}

data "aws_caller_identity" "this" {}