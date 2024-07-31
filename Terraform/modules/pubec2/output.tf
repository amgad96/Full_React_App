output "instances" {
  value = aws_instance.Node[*].id
}