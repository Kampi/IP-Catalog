# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  set BOUNCETIME [ipgui::add_param $IPINST -name "BOUNCETIME" -parent ${Page_0}]
  set_property tooltip {Bouncing time in clock cycles.} ${BOUNCETIME}


}

proc update_PARAM_VALUE.BOUNCETIME { PARAM_VALUE.BOUNCETIME } {
	# Procedure called to update BOUNCETIME when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BOUNCETIME { PARAM_VALUE.BOUNCETIME } {
	# Procedure called to validate BOUNCETIME
	return true
}


proc update_MODELPARAM_VALUE.BOUNCETIME { MODELPARAM_VALUE.BOUNCETIME PARAM_VALUE.BOUNCETIME } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BOUNCETIME}] ${MODELPARAM_VALUE.BOUNCETIME}
}

