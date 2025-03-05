resource "aws_instance" "web" {
  ami           = "07eef52105e8a2059"
  instance_type = "t2.micro"
  
  tags = {
    Name = "myinstance"
  }
}
