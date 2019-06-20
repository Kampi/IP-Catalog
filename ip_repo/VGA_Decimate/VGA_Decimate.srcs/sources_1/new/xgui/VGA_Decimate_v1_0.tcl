# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  set INPUT [ipgui::add_param $IPINST -name "INPUT"]
  set_property tooltip {Input data width.} ${INPUT}
  set INPUT_SIZE [ipgui::add_param $IPINST -name "INPUT_SIZE"]
  set_property tooltip {Size of color components from input vector.} ${INPUT_SIZE}
  set OUTPUT [ipgui::add_param $IPINST -name "OUTPUT"]
  set_property tooltip {Output data width.} ${OUTPUT}
  set RED_END [ipgui::add_param $IPINST -name "RED_END"]
  set_property tooltip {Last bit position of color RED in output vector.} ${RED_END}
  set GREEN_END [ipgui::add_param $IPINST -name "GREEN_END"]
  set_property tooltip {Last bit position of color GREEN in output vector.} ${GREEN_END}
  set BLUE_END [ipgui::add_param $IPINST -name "BLUE_END"]
  set_property tooltip {Last bit position of color BLUE in output vector.} ${BLUE_END}

}

proc update_PARAM_VALUE.BLUE_END { PARAM_VALUE.BLUE_END } {
	# Procedure called to update BLUE_END when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BLUE_END { PARAM_VALUE.BLUE_END } {
	# Procedure called to validate BLUE_END
	return true
}

proc update_PARAM_VALUE.GREEN_END { PARAM_VALUE.GREEN_END } {
	# Procedure called to update GREEN_END when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.GREEN_END { PARAM_VALUE.GREEN_END } {
	# Procedure called to validate GREEN_END
	return true
}

proc update_PARAM_VALUE.INPUT { PARAM_VALUE.INPUT } {
	# Procedure called to update INPUT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INPUT { PARAM_VALUE.INPUT } {
	# Procedure called to validate INPUT
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


proc update_MODELPARAM_VALUE.INPUT { MODELPARAM_VALUE.INPUT PARAM_VALUE.INPUT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INPUT}] ${MODELPARAM_VALUE.INPUT}
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

