output Master_SG{
    value  = aws_security_group.MasterNodeSG
}
output Worker_SG{
    value  = aws_security_group.WorkerNodeSG
}
output "LB_SGs_ids" {
  value = aws_security_group.LoadBalancer_SG[*].id
}