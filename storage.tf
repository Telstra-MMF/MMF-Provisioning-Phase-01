### STORAGE ###
###############
resource "opc_compute_storage_volume" "storage-1" {
	name                = "storage-1"
	size                = "30"
	bootable 			= true
	image_list          = "/oracle/public/OL_6.8_UEKR4_x86_64"
}