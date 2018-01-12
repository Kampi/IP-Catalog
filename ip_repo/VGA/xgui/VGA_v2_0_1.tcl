# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "Char_Size" -parent ${Page_0} -widget comboBox
  ipgui::add_param $IPINST -name "Max_Char_x" -parent ${Page_0} -widget comboBox
  ipgui::add_param $IPINST -name "Max_Char_y" -parent ${Page_0} -widget comboBox
  ipgui::add_param $IPINST -name "ROM_Address_Width" -parent ${Page_0} -widget comboBox
  ipgui::add_param $IPINST -name "ROM_Data_Width" -parent ${Page_0} -widget comboBox
  ipgui::add_param $IPINST -name "COLOR" -parent ${Page_0} -widget comboBox


}

proc update_PARAM_VALUE.COLOR { PARAM_VALUE.COLOR } {
	# Procedure called to update COLOR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.COLOR { PARAM_VALUE.COLOR } {
	# Procedure called to validate COLOR
	return true
}

proc update_PARAM_VALUE.Char_Size { PARAM_VALUE.Char_Size } {
	# Procedure called to update Char_Size when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.Char_Size { PARAM_VALUE.Char_Size } {
	# Procedure called to validate Char_Size
	return true
}

proc update_PARAM_VALUE.Max_Char_x { PARAM_VALUE.Max_Char_x } {
	# Procedure called to update Max_Char_x when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.Max_Char_x { PARAM_VALUE.Max_Char_x } {
	# Procedure called to validate Max_Char_x
	return true
}

proc update_PARAM_VALUE.Max_Char_y { PARAM_VALUE.Max_Char_y } {
	# Procedure called to update Max_Char_y when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.Max_Char_y { PARAM_VALUE.Max_Char_y } {
	# Procedure called to validate Max_Char_y
	return true
}

proc update_PARAM_VALUE.ROM_Address_Width { PARAM_VALUE.ROM_Address_Width } {
	# Procedure called to update ROM_Address_Width when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ROM_Address_Width { PARAM_VALUE.ROM_Address_Width } {
	# Procedure called to validate ROM_Address_Width
	return true
}

proc update_PARAM_VALUE.ROM_Data_Width { PARAM_VALUE.ROM_Data_Width } {
	# Procedure called to update ROM_Data_Width when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ROM_Data_Width { PARAM_VALUE.ROM_Data_Width } {
	# Procedure called to validate ROM_Data_Width
	return true
}


proc update_MODELPARAM_VALUE.ROM_Address_Width { MODELPARAM_VALUE.ROM_Address_Width PARAM_VALUE.ROM_Address_Width } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ROM_Address_Width}] ${MODELPARAM_VALUE.ROM_Address_Width}
}

proc update_MODELPARAM_VALUE.ROM_Data_Width { MODELPARAM_VALUE.ROM_Data_Width PARAM_VALUE.ROM_Data_Width } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ROM_Data_Width}] ${MODELPARAM_VALUE.ROM_Data_Width}
}

proc update_MODELPARAM_VALUE.Char_Size { MODELPARAM_VALUE.Char_Size PARAM_VALUE.Char_Size } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.Char_Size}] ${MODELPARAM_VALUE.Char_Size}
}

proc update_MODELPARAM_VALUE.Max_Char_x { MODELPARAM_VALUE.Max_Char_x PARAM_VALUE.Max_Char_x } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.Max_Char_x}] ${MODELPARAM_VALUE.Max_Char_x}
}

proc update_MODELPARAM_VALUE.Max_Char_y { MODELPARAM_VALUE.Max_Char_y PARAM_VALUE.Max_Char_y } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.Max_Char_y}] ${MODELPARAM_VALUE.Max_Char_y}
}

proc update_MODELPARAM_VALUE.COLOR { MODELPARAM_VALUE.COLOR PARAM_VALUE.COLOR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.COLOR}] ${MODELPARAM_VALUE.COLOR}
}

