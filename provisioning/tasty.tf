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
  name = "master"
  image = "${var.image}"
  region = "${var.region}"
  size = "${var.size}"
  ssh_keys = ["${var.ssh_key}"]
}
resource "digitalocean_droplet" "kitty" {
  name = "kitty"
  image = "${var.image}"
  region = "${var.region}"
  size = "${var.size}"
  ssh_keys = ["${var.ssh_key}"]
}
resource "digitalocean_droplet" "puppy" {
  name = "puppy"
  image = "${var.image}"
  region = "${var.region}"
  size = "${var.size}"
  ssh_keys = ["${var.ssh_key}"]
}

output "master ip" {
    value = "${digitalocean_droplet.master.ipv4_address}"
}
output "kitty ip" {
    value = "${digitalocean_droplet.kitty.ipv4_address}"
}
output "puppy ip" {
    value = "${digitalocean_droplet.puppy.ipv4_address}"
}
