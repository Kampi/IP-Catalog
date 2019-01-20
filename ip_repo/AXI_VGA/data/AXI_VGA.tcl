

proc generate {drv_handle} {
	xdefine_include_file $drv_handle "xparameters.h" "AxiVga" "NUM_INSTANCES" "DEVICE_ID" "C_BASEADDR" "C_HIGHADDR"
	xdefine_config_file $drv_handle "AxiVga_g.c" "AxiVga" "DEVICE_ID" "C_BASEADDR"
}
