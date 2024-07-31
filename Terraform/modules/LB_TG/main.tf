resource "aws_lb_target_group" "App_TG" {
  name     = var.TG_Name
  port     = var.targ_port
  protocol = "HTTP"
  vpc_id   = var.kube_vpc.id
  health_check {
    enabled             = true
    interval            = 30
    //port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
}
resource "aws_lb_target_group_attachment" "App_TG_AT" {
  for_each          = { for idx, instance in var.workernode_instances : idx => instance }
  target_group_arn  = aws_lb_target_group.App_TG.arn
  target_id         = each.value
  port              = var.targ_port
}
# Define the Load Balancer
resource "aws_lb" "App_LB" {
  name               = var.LB_name
  internal           = false
  //load_balancer_type = "network"  # Use "network" for NLB
  security_groups    = var.LB_SG_IDS
  subnets            = [var.SubnetA, var.SubnetB] 
  enable_deletion_protection = false
  idle_timeout              = 60

  tags = {
    Name = "App_LB"
  }
}

# Define a Listener for the Load Balancer
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.App_LB.arn
  port              = var.listenport
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.App_TG.arn
  }
}

