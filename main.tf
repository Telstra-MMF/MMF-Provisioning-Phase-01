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

### STORAGE ###
###############
resource "opc_compute_storage_volume" "app-volume1" {
	name                = "app-volume1-boot"
	size                = "30"
	storage_type        = "/oracle/public/storage/latency"
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
	