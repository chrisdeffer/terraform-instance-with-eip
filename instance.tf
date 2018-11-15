resource "aws_key_pair" "mykey" {
  key_name = "personal"
  public_key = "${file("${var.PUBLIC_KEY}")}"
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = "${aws_instance.myinstance.id}"
  allocation_id = "${aws_eip.demo-eip.id}"
}

resource "aws_eip" "demo-eip" {
  vpc      = true
}

resource "aws_instance" "myinstance" {
  ami = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.mykey.key_name}"
  vpc_security_group_ids = ["sg-0a3e2a6ec50377405"]
  //vpc_security_group_ids = ["${aws_security_group.allow-ssh.id}","${aws_security_group.allow-influxdb.id}","${aws_security_group.allow-influxdb2.id}"]
  ebs_block_device {
    device_name           = "/dev/sdg"
    volume_type           = "gp2"
    volume_size           = 1
    delete_on_termination = true
  }
   
 
  tags {
    Name = "demo-ec2-with-volume"
    Env = "dev"
    Provisioner = "terraform"
  }
  
  provisioner "file" {
    source = "script.sh"
    destination = "/tmp/script.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo /tmp/script.sh"
    ]
  }
  
  connection {
    user = "${var.INSTANCE_USERNAME}"
    private_key = "${file("${var.PRIVATE_KEY}")}"
  }
}
