# get one here:
#     https://cloud.digitalocean.com/settings/applications
# set it in terraform.tfvars file, or on command line, or TMTOWTDI...
variable "do_token" {
	description = "Digital Ocean personal access token"
}
variable "ssh_key" {
  description = "fingerprint/id of ssh key to install"
}
variable "image" {
  default = "ubuntu-14-04-x64"
  description = "image to use"
}
variable "region" {
  default = "sfo1"
  dscription = "region in which to create droplets"
}
variable "size" {
  default = "512mb"
  description = "Size of droplet"
}


# Either set this here or via the DIGITALOCEAN_TOKEN env var
provider "digitalocean" {
    token = "${var.do_token}"
}

# Create a droplets in the sfo1 region.
# region names here:
#   https://developers.digitalocean.com/documentation/v2/#regions
# ssh key fingerprints here:
#   https://cloud.digitalocean.com/settings/security
#
resource "digitalocean_droplet" "master" {
  name = "master.dev"
  image = "${var.image}"
  region = "${var.region}"
  size = "1gb"
  ssh_keys = ["${var.ssh_key}"]
  provisioner "remote-exec" {
    inline = [
      # this is for ubuntu 12, what's the 14 equivalent?
      # "wget https://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/12.04/x86_64/chef-server_11.0.8-1.ubuntu.12.04_amd64.deb",
      # "dpkg -i chef-server_11.0.8-1.ubuntu.12.04_amd64.deb",
      # "chef-server-ctl reconfigure",
    ]
    connection {
      user = "root"
      key_file = "/Users/georgewh/.ssh/id_rsa"
    }
  }
}
resource "digitalocean_droplet" "workstation" {
  name = "workstation.dev"
  image = "${var.image}"
  region = "${var.region}"
  size = "${var.size}"
  ssh_keys = ["${var.ssh_key}"]
  provisioner "remote-exec" {
    # up through the "Clone the `chef-repo`" line
    inline = [
      "curl -L https://www.opscode.com/chef/install.sh > /tmp/install.sh",
      "bash /tmp/install.sh -v 11",
      "echo 'export PATH=\"/opt/chef/embedded/bin:$PATH\"' >> ~/.profile",
      "source ~/.profile",
      "apt-get update",
      "apt-get install git -y",
      "git clone git://github.com/opscode/chef-repo.git",
    ]
    connection {
      user = "root"
      key_file = "/Users/georgewh/.ssh/id_rsa"
    }
  }
}
resource "digitalocean_droplet" "kitty" {
  name = "kitty.dev"
  image = "${var.image}"
  region = "${var.region}"
  size = "${var.size}"
  ssh_keys = ["${var.ssh_key}"]
}
resource "digitalocean_droplet" "puppy" {
  name = "puppy.dev"
  image = "${var.image}"
  region = "${var.region}"
  size = "${var.size}"
  ssh_keys = ["${var.ssh_key}"]
}

output "master ip" {
    value = "${digitalocean_droplet.master.ipv4_address}"
}
output "workstation ip" {
    value = "${digitalocean_droplet.workstation.ipv4_address}"
}
output "kitty ip" {
    value = "${digitalocean_droplet.kitty.ipv4_address}"
}
output "puppy ip" {
    value = "${digitalocean_droplet.puppy.ipv4_address}"
}
