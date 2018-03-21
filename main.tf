### ENVIRONMENT ###
###################
provider "opc" {
   user                = "${var.ociUser}"
   password            = "${var.ociPass}"
   identity_domain     = "${var.idDomain}"
   endpoint            = "${var.apiEndpoint}"
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
}