### STORAGE ###
###############
resource "opc_compute_storage_volume" "storage-1" {
	name                = "storage-1"
	size                = "30"
	image_list          = "/oracle/public/OL_6.8_UEKR4_x86_64"
}

resource "opc_compute_storage_volume" "storage-2" {
	name                = "storage-2"
	size                = "30"
	image_list          = "/oracle/public/OL_6.8_UEKR4_x86_64"
}

### COMPUTE ###
###############
resource "opc_compute_instance" "lxapp14001" {
	name                = "lxapp14001"
	label               = "CAT RMS app server (+additional 300GB storage)"
	shape               = "oc3"
	storage {
		index 			= 1
		volume          = "${opc_compute_storage_volume.storage-1.name}"
	}
	
	networking_info {
		index             = 0
		shared_network    = false
		vnic              = "vnic001"
		vnic_sets		  = "cla-npintocm-wloc-mmf001-vnic001"
		ip_network        = "cla-npintocm-wloc-mmf001"
		ip_address        = "10.195.77.11"
		dns               = ["lxapp14001.ocmint.corp.telstra.com"]
	}
	
#	ssh_keys            = ["${opc_compute_ssh_key.ocsk-public-key1.name}"]
	boot_order          = [ 1 ]
}
	
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
		vnic              = "vnic002"
		ip_network        = "cla-npintocm-wloc-mmf001"
		ip_address        = "10.195.77.12"
		dns               = ["lxapp14002.ocmint.corp.telstra.com"]
	}
	
#	ssh_keys            = ["${opc_compute_ssh_key.ocsk-public-key1.name}"]
	boot_order          = [ 1 ]
}
	