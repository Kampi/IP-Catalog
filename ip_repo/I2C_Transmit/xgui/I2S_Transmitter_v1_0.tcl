# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "CLOCK_PRESCALER" -parent ${Page_0}
  ipgui::add_param $IPINST -name "DATA_WIDTH_PER_CHANNEL" -parent ${Page_0}


}

proc update_PARAM_VALUE.CLOCK_PRESCALER { PARAM_VALUE.CLOCK_PRESCALER } {
	# Procedure called to update CLOCK_PRESCALER when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.CLOCK_PRESCALER { PARAM_VALUE.CLOCK_PRESCALER } {
	# Procedure called to validate CLOCK_PRESCALER
	return true
}

proc update_PARAM_VALUE.DATA_WIDTH_PER_CHANNEL { PARAM_VALUE.DATA_WIDTH_PER_CHANNEL } {
	# Procedure called to update DATA_WIDTH_PER_CHANNEL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DATA_WIDTH_PER_CHANNEL { PARAM_VALUE.DATA_WIDTH_PER_CHANNEL } {
	# Procedure called to validate DATA_WIDTH_PER_CHANNEL
	return true
}


proc update_MODELPARAM_VALUE.DATA_WIDTH_PER_CHANNEL { MODELPARAM_VALUE.DATA_WIDTH_PER_CHANNEL PARAM_VALUE.DATA_WIDTH_PER_CHANNEL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DATA_WIDTH_PER_CHANNEL}] ${MODELPARAM_VALUE.DATA_WIDTH_PER_CHANNEL}
}

proc update_MODELPARAM_VALUE.CLOCK_PRESCALER { MODELPARAM_VALUE.CLOCK_PRESCALER PARAM_VALUE.CLOCK_PRESCALER } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.CLOCK_PRESCALER}] ${MODELPARAM_VALUE.CLOCK_PRESCALER}
}

