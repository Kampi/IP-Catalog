

proc generate {drv_handle} {
	xdefine_include_file $drv_handle "xparameters.h" "Axivga" "NUM_INSTANCES" "DEVICE_ID" "C_BASEADDR" "C_HIGHADDR"
	xdefine_config_file $drv_handle "axivga_g.c" "Axivga" "DEVICE_ID" "C_BASEADDR"
}
