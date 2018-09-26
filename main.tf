provider "aws" {
  access_key = "********************"
  secret_key = "********************"
  region     = "us-west-2"
}
resource "aws_instance" "sample" {
  ami="ami-0e32ec5bc225539f5"
  instance_type="t2.micro"
  key_name="ec2"
  security_groups=["launch-wizard-2"]
 count="2"
  tags{
    Name="MSR-test-Instance-${count.index}"
  }
 connection {
  user = "ubuntu"
  type = "ssh"
  private_key="${file("/home/ubuntu/ec2.pem")}"
  }
provisioner "file" {
    source      = "/home/ubuntu/sample/script.sh"
    destination = "/tmp/script.sh"
  }
provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "/tmp/script.sh args"
   ]
  }
}
resource "aws_instance" "sample1" {
instance_id = "${aws_instance.sample.id}"
provisioner "file" {
    source      = "/home/ubuntu/sample/apache.sh"
    destination = "/tmp/apache.sh"
  }
provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/apache.sh",
      "/tmp/apache.sh args",
      "sudo chmod 777 /var/lib/tomcat7/webapps/"
   ]
  }
 provisioner "file" {
    source      = "/home/ubuntu/sample/index.html"
    destination = "/var/lib/tomcat7/webapps/index.html"
  }
provisioner "remote-exec" {
    inline = [
      "sudo service tomcat7 restart"
   ]
  }
}
resource "aws_instance" "sample2" {
instance_id = "${aws_instance.sample.id}"
provisioner "file" {
    source      = "/home/ubuntu/sample/couchdb.sh"
    destination = "/tmp/couchdb.sh"
  }

provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/couchdb.sh",
      "/tmp/couchdb.sh args"
    ]
  }
}
