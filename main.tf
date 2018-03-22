### ENVIRONMENT ###
###################
provider "opc" {
   user                = "${var.ociUser}"
   password            = "${var.ociPass}"
   identity_domain     = "${var.idDomain}"
   endpoint            = "${var.apiEndpoint}"
}

### IP Network : Network Exchange ###
resource "opc_compute_ip_network_exchange" "cla-npintocm-ipx001" {
	name                = "cla-npintocm-ipx001"
	description			= "Prod OCM -IP Exchange No 1 - IP Exchange for Clayton NpIntocm non prod network"
	tags 				= [ "cla-npintocm-nonprod" ]
}

### IP Network : IP Networks ###
resource "opc_compute_ip_network" "cla-npintocm-wloc-mmf001" {
  name                = "cla-npintocm-wloc-mmf001"
  description         = "cla-npintocm-wloc-mmf001"
  ip_address_prefix   = "10.13.32.0/23"
  ip_network_exchange = "${opc_compute_ip_network_exchange.cla-npintocm-ipx001.name}"
  public_napt_enabled = false
}

### STORAGE ###
###############
resource "opc_compute_storage_volume" "storage-1" {
	name                = "app-volume1-boot"
	size                = "30"
	image_list          = "/oracle/public/OL_6.8_UEKR4_x86_64"
}

resource "opc_compute_storage_volume" "storage-1+1" {
	name                = "app-volume1-boot"
	size                = "30"
	bootable            = true
	image_list          = "/oracle/public/OL_6.8_UEKR4_x86_64"
}

### COMPUTE ###
###############
resource "opc_compute_instance" "lxapp14001" {
	name                = "lxapp14001"
	label               = "CAT RMS app server (+additional 300GB storage)"
	shape               = "OC3M"
	storage {
		index 			= 1
		volume          = "${opc_compute_storage_volume.storage-1.name}"
	}
	
#	ssh_keys            = ["${opc_compute_ssh_key.ocsk-public-key1.name}"]
	boot_order          = [ 1 ]
}
	