# groups
resource "aws_iam_group" "frontend" {
  name = "Frontend"
}

resource "aws_iam_group" "backend" {
  name = "Backend"
}

resource "aws_iam_group" "data" {
  name = "Data"
}

resource "aws_iam_group" "admin" {
  name = "Administrators"
}


# roles
resource "aws_iam_role" "frontend" {
  name               = "frontend_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          AWS = "*"
        }
      }
    ]
  })
}

resource "aws_iam_role" "backend" {
  name               = "backend_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          AWS = "*"
        }
      }
    ]
  })
}

resource "aws_iam_role" "data" {
  name               = "data_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          AWS = "*"
        }
      }
    ]
  })
}

resource "aws_iam_role" "admin" {
  name               = "admin_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          AWS = "*"
        }
      }
    ]
  })
}

# policies
resource "aws_iam_policy" "frontend" {
  name   = "frontend_policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "cloudfront:Get*",
          "cloudfront:List*",
          "cloudwatch:Describe*",
          "cloudwatch:List*",
          "cloudwatch:Get*"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "backend" {
  name   = "backend_policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      { 
        Effect   = "Allow"
        Action   = [
          "eks:DescribeCluster",
          "eks:ListClusters",
          "cloudwatch:Describe*",
          "cloudwatch:List*",
          "cloudwatch:Get*"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "data" {
  name   = "data_policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "redshift:Describe*",
          "redshift:ViewQueriesInConsole",
          "cloudwatch:Describe*",
          "cloudwatch:List*",
          "cloudwatch:Get*"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "admin" {
  name   = "admin_policy"
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": {
      "Effect": "Allow",
      "Action": "iam:*",
      "Resource": "*"
    }
  })
}

# attachments
resource "aws_iam_role_policy_attachment" "frontend_attachment" {
  policy_arn = aws_iam_policy.frontend.arn
  role       = aws_iam_role.frontend.name
}
resource "aws_iam_role_policy_attachment" "backend_attachment" {
  policy_arn = aws_iam_policy.backend.arn
  role       = aws_iam_role.backend.name
}
resource "aws_iam_role_policy_attachment" "data_attachment" {
  policy_arn = aws_iam_policy.data.arn
  role       = aws_iam_role.data.name
}
resource "aws_iam_role_policy_attachment" "admin_attachment" {
  policy_arn = aws_iam_policy.admin.arn
  role       = aws_iam_role.admin.name
}

# users
resource "aws_iam_group_membership" "frontend_users" {
  name  = aws_iam_group.frontend.name 
  users = var.frontend_users 
  group = aws_iam_group.frontend.name
}
resource "aws_iam_group_membership" "backend_users" {
  name  = aws_iam_group.backend.name
  users = var.backend_users
  group = aws_iam_group.backend.name
}
resource "aws_iam_group_membership" "data_users" {
  name  = aws_iam_group.data.name
  users = var.data_users
  group = aws_iam_group.data.name
}
resource "aws_iam_group_membership" "admin_users" {
  name  = aws_iam_group.admin.name
  users = var.admin_users
  group = aws_iam_group.admin.name
}
