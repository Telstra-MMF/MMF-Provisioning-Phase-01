### STORAGE ###
###############
resource "opc_compute_storage_volume" "storage-2" {
	name                = "storage-2"
	size                = "30"
	image_list          = "/oracle/public/OL_6.8_UEKR4_x86_64"
}


### COMPUTE ###
###############
resource "opc_compute_instance" "lxapp14002" {
	name                = "lxapp14002"
	label               = "CAT RMS app server 2"
	shape               = "oc3"
	storage {
		index 			= 1
		volume          = "${opc_compute_storage_volume.storage-2.name}"
	}
	
	networking_info {
		index             = 0
		shared_network    = false
		ip_network        = "cla-npintocm-wloc-mmf001"
		ip_address        = "10.195.77.12"
		dns               = ["lxapp14002.ocmint.corp.telstra.com"]
	}
	
#	ssh_keys            = ["${opc_compute_ssh_key.ocsk-public-key1.name}"]
	boot_order          = [ 1 ]
}
	