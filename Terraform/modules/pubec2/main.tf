resource "aws_instance" "Node" {
  ami           = "ami-04b70fa74e45c3917"
  instance_type = "t2.medium"
  subnet_id   = var.kube_pubsubnet_id
  associate_public_ip_address = true
  count   = var.node_count
  key_name   = "KubeBS"
  vpc_security_group_ids   = [var.Kube_SG_id]
  root_block_device {
      volume_size           = 30 
  }
  tags = {
    Name = format("%s-%s-%d", var.ece_role,"Node", count.index + 1)
  }
}
