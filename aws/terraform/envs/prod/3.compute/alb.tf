resource "aws_lb" "main" {
  name               = "app-${var.env}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [data.terraform_remote_state.general.outputs.alb_security_group_id]
  subnets            = data.terraform_remote_state.general.outputs.public_subnet_ids

  enable_deletion_protection = true

  access_logs {
    bucket  = aws_s3_bucket.alb_logs.bucket
    prefix  = "alb-access-logs"
    enabled = true
  }

  tags = {
    Name = "app-${var.env}-alb"
  }
}

resource "aws_s3_bucket" "alb_logs" {
  bucket = "${var.project}-${var.env}-alb-logs-${random_id.bucket_suffix.hex}"
  tags = {
    Name = "${var.project}-${var.env}-alb-logs"
  }
}

resource "random_id" "bucket_suffix" {
  byte_length = 8
}

resource "aws_s3_bucket_policy" "alb_logs" {
  bucket = aws_s3_bucket.alb_logs.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = data.aws_elb_service_account.main.arn
        }
        Action   = "s3:PutObject"
        Resource = "${aws_s3_bucket.alb_logs.arn}/alb-access-logs/AWSLogs/${data.aws_caller_identity.current.account_id}/*"
      }
    ]
  })
}

resource "aws_lb_target_group" "app" {
  name        = "${var.project}-${var.env}-tg"
  port        = 3000
  protocol    = "HTTP"
  vpc_id      = data.terraform_remote_state.general.outputs.vpc_id
  target_type = "ip"

  health_check {
    enabled             = true
    interval            = 30
    matcher             = "200"
    path                = "/health"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 10
    healthy_threshold   = 2
    unhealthy_threshold = 3
  }

  deregistration_delay = 30

  tags = {
    Name = "${var.project}-${var.env}-tg"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  tags = {
    Name = "${var.project}-${var.env}-http-listener"
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.main.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01"
  certificate_arn   = "arn:aws:acm:ap-northeast-1:098131748091:certificate/d40d8f36-3a00-4098-b9af-22ebee5d3780" # aws_acm_certificate_validation.main.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }

  tags = {
    Name = "${var.project}-${var.env}-https-listener"
  }
}
