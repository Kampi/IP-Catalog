# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  set INPUT_SIZE [ipgui::add_param $IPINST -name "INPUT_SIZE" -widget comboBox]
  set_property tooltip {Input signal color components size.} ${INPUT_SIZE}
  set OUTPUT [ipgui::add_param $IPINST -name "OUTPUT" -widget comboBox]
  set_property tooltip {Output data width.} ${OUTPUT}
  set RED_END [ipgui::add_param $IPINST -name "RED_END"]
  set_property tooltip {Last bit position of color RED used in output vector.} ${RED_END}
  set GREEN_END [ipgui::add_param $IPINST -name "GREEN_END"]
  set_property tooltip {Last bit position of color GREEN used in output vector.} ${GREEN_END}
  set BLUE_END [ipgui::add_param $IPINST -name "BLUE_END"]
  set_property tooltip {Last bit position of color BLUE used in output vector.} ${BLUE_END}
  set COLOR_SIZE [ipgui::add_param $IPINST -name "COLOR_SIZE" -widget comboBox]
  set_property tooltip {Input signal color components size.} ${COLOR_SIZE}

}

proc update_PARAM_VALUE.BLUE_END { PARAM_VALUE.BLUE_END } {
	# Procedure called to update BLUE_END when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BLUE_END { PARAM_VALUE.BLUE_END } {
	# Procedure called to validate BLUE_END
	return true
}

proc update_PARAM_VALUE.COLOR_SIZE { PARAM_VALUE.COLOR_SIZE } {
	# Procedure called to update COLOR_SIZE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.COLOR_SIZE { PARAM_VALUE.COLOR_SIZE } {
	# Procedure called to validate COLOR_SIZE
	return true
}

proc update_PARAM_VALUE.GREEN_END { PARAM_VALUE.GREEN_END } {
	# Procedure called to update GREEN_END when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.GREEN_END { PARAM_VALUE.GREEN_END } {
	# Procedure called to validate GREEN_END
	return true
}

proc update_PARAM_VALUE.INPUT_SIZE { PARAM_VALUE.INPUT_SIZE } {
	# Procedure called to update INPUT_SIZE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INPUT_SIZE { PARAM_VALUE.INPUT_SIZE } {
	# Procedure called to validate INPUT_SIZE
	return true
}

proc update_PARAM_VALUE.OUTPUT { PARAM_VALUE.OUTPUT } {
	# Procedure called to update OUTPUT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.OUTPUT { PARAM_VALUE.OUTPUT } {
	# Procedure called to validate OUTPUT
	return true
}

proc update_PARAM_VALUE.RED_END { PARAM_VALUE.RED_END } {
	# Procedure called to update RED_END when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.RED_END { PARAM_VALUE.RED_END } {
	# Procedure called to validate RED_END
	return true
}


proc update_MODELPARAM_VALUE.OUTPUT { MODELPARAM_VALUE.OUTPUT PARAM_VALUE.OUTPUT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.OUTPUT}] ${MODELPARAM_VALUE.OUTPUT}
}

proc update_MODELPARAM_VALUE.INPUT_SIZE { MODELPARAM_VALUE.INPUT_SIZE PARAM_VALUE.INPUT_SIZE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INPUT_SIZE}] ${MODELPARAM_VALUE.INPUT_SIZE}
}

proc update_MODELPARAM_VALUE.RED_END { MODELPARAM_VALUE.RED_END PARAM_VALUE.RED_END } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.RED_END}] ${MODELPARAM_VALUE.RED_END}
}

proc update_MODELPARAM_VALUE.GREEN_END { MODELPARAM_VALUE.GREEN_END PARAM_VALUE.GREEN_END } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.GREEN_END}] ${MODELPARAM_VALUE.GREEN_END}
}

proc update_MODELPARAM_VALUE.BLUE_END { MODELPARAM_VALUE.BLUE_END PARAM_VALUE.BLUE_END } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BLUE_END}] ${MODELPARAM_VALUE.BLUE_END}
}

proc update_MODELPARAM_VALUE.COLOR_SIZE { MODELPARAM_VALUE.COLOR_SIZE PARAM_VALUE.COLOR_SIZE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.COLOR_SIZE}] ${MODELPARAM_VALUE.COLOR_SIZE}
}

