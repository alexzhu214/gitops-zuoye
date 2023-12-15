provider "tencentcloud" {
  region     = var.region
}


data "tencentcloud_images" "default" {
  image_type = ["PUBLIC_IMAGE"]
  os_name    = "ubuntu"
}

data "tencentcloud_instance_types" "default" {
  filter {
    name   = "instance-family"
    values = ["S5"]
  }

  filter {
    name   = "zone"
    values = ["${var.availability_zone}"]
  }

  // min 4C, 8G
  cpu_core_count = 4
  memory_size    = 8
}



# resource "tencentcloud_key_pair" "key" {
#   key_name   = "tf_key"
#   public_key = file("ssh-key/id_rsa.pub")
# }

# Create a web server without public ip
resource "tencentcloud_instance" "ubuntu" {
  instance_name = "${var.instance_name}-${count.index}"
  #name  = "neo.${count.index}"
  availability_zone = var.availability_zone
  image_id          = data.tencentcloud_images.default.images.0.image_id
  //key_ids                    = [tencentcloud_key_pair.key.id]
  instance_type              = data.tencentcloud_instance_types.default.instance_types.0.instance_type
  system_disk_type           = "CLOUD_SSD"
  system_disk_size           = 50
  hostname                   = "${var.instance_name}-${count.index}"
  vpc_id                     = tencentcloud_vpc.tf_vpc.id
  subnet_id                  = tencentcloud_subnet.tf_service_subnet.id
  instance_charge_type       = "SPOTPAID"
  internet_max_bandwidth_out = 100
  allocate_public_ip         = true
  count                      = 1
  orderly_security_groups    = [tencentcloud_security_group.web_sg.id]
  password                   = var.password

  //data_disks {
  // data_disk_type = "CLOUD_PREMIUM"
  // data_disk_size = 50
  //}

}
