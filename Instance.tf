resource "aws_instance" "EC2-instance" {
  ami = "ami-0620d12a9cf777c87"
  instance_type = "t2.micro"
  key_name = aws_key_pair.key-pair.key_name
  vpc_security_group_ids = [aws_security_group.SG-group.id]
  subnet_id = aws_subnet.public_subnet1.id
}