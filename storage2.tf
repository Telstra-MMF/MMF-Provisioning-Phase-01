resource "opc_compute_storage_volume" "storage-2" {
	name                = "storage-2"
	size                = "30"
	bootable 			= true
	image_list          = "/oracle/public/OL_6.8_UEKR4_x86_64"    
	image_list_entry 	= 2
}