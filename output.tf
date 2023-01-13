output "my_server_id" {
  value = aws_instance.my_server.id
}

output "my_server_ami" {
  value = aws_instance.my_server.ami

}

output "my_server_arn" {
  value = aws_instance.my_server.arn

}
