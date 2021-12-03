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

data "aws_iam_policy_document" "reader-read" {
  statement {
    actions = [
      "glue:GetTable",
      "glue:GetTables",
      "glue:GetDatabase",
      "glue:GetDataBases"
    ]
    resources = ["*"]
  }

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

resource "aws_iam_policy" "reader-read"  {
  policy = data.aws_iam_policy_document.reader-read.json
}

resource "aws_iam_role_policy_attachment" "reader-read" {
  policy_arn = aws_iam_policy.reader-read.arn
  role       = aws_iam_role.this.id
}

data "aws_caller_identity" "this" {}
