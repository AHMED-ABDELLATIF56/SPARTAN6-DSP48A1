## This file is a general .xdc for the Basys3 rev B board
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

## Clock signal
set_property -dict {PACKAGE_PIN W5 IOSTANDARD LVCMOS33} [get_ports clk]
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports clk]


## Configuration options, can be used for all designs
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]


## SPI configuration mode options for QSPI boot, can be used for all designs
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]

create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list clk_IBUF_BUFG]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 18 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {bcout_OBUF[0]} {bcout_OBUF[1]} {bcout_OBUF[2]} {bcout_OBUF[3]} {bcout_OBUF[4]} {bcout_OBUF[5]} {bcout_OBUF[6]} {bcout_OBUF[7]} {bcout_OBUF[8]} {bcout_OBUF[9]} {bcout_OBUF[10]} {bcout_OBUF[11]} {bcout_OBUF[12]} {bcout_OBUF[13]} {bcout_OBUF[14]} {bcout_OBUF[15]} {bcout_OBUF[16]} {bcout_OBUF[17]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 48 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {c_IBUF[0]} {c_IBUF[1]} {c_IBUF[2]} {c_IBUF[3]} {c_IBUF[4]} {c_IBUF[5]} {c_IBUF[6]} {c_IBUF[7]} {c_IBUF[8]} {c_IBUF[9]} {c_IBUF[10]} {c_IBUF[11]} {c_IBUF[12]} {c_IBUF[13]} {c_IBUF[14]} {c_IBUF[15]} {c_IBUF[16]} {c_IBUF[17]} {c_IBUF[18]} {c_IBUF[19]} {c_IBUF[20]} {c_IBUF[21]} {c_IBUF[22]} {c_IBUF[23]} {c_IBUF[24]} {c_IBUF[25]} {c_IBUF[26]} {c_IBUF[27]} {c_IBUF[28]} {c_IBUF[29]} {c_IBUF[30]} {c_IBUF[31]} {c_IBUF[32]} {c_IBUF[33]} {c_IBUF[34]} {c_IBUF[35]} {c_IBUF[36]} {c_IBUF[37]} {c_IBUF[38]} {c_IBUF[39]} {c_IBUF[40]} {c_IBUF[41]} {c_IBUF[42]} {c_IBUF[43]} {c_IBUF[44]} {c_IBUF[45]} {c_IBUF[46]} {c_IBUF[47]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 36 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {m_OBUF[0]} {m_OBUF[1]} {m_OBUF[2]} {m_OBUF[3]} {m_OBUF[4]} {m_OBUF[5]} {m_OBUF[6]} {m_OBUF[7]} {m_OBUF[8]} {m_OBUF[9]} {m_OBUF[10]} {m_OBUF[11]} {m_OBUF[12]} {m_OBUF[13]} {m_OBUF[14]} {m_OBUF[15]} {m_OBUF[16]} {m_OBUF[17]} {m_OBUF[18]} {m_OBUF[19]} {m_OBUF[20]} {m_OBUF[21]} {m_OBUF[22]} {m_OBUF[23]} {m_OBUF[24]} {m_OBUF[25]} {m_OBUF[26]} {m_OBUF[27]} {m_OBUF[28]} {m_OBUF[29]} {m_OBUF[30]} {m_OBUF[31]} {m_OBUF[32]} {m_OBUF[33]} {m_OBUF[34]} {m_OBUF[35]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 48 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list {pcin_IBUF[0]} {pcin_IBUF[1]} {pcin_IBUF[2]} {pcin_IBUF[3]} {pcin_IBUF[4]} {pcin_IBUF[5]} {pcin_IBUF[6]} {pcin_IBUF[7]} {pcin_IBUF[8]} {pcin_IBUF[9]} {pcin_IBUF[10]} {pcin_IBUF[11]} {pcin_IBUF[12]} {pcin_IBUF[13]} {pcin_IBUF[14]} {pcin_IBUF[15]} {pcin_IBUF[16]} {pcin_IBUF[17]} {pcin_IBUF[18]} {pcin_IBUF[19]} {pcin_IBUF[20]} {pcin_IBUF[21]} {pcin_IBUF[22]} {pcin_IBUF[23]} {pcin_IBUF[24]} {pcin_IBUF[25]} {pcin_IBUF[26]} {pcin_IBUF[27]} {pcin_IBUF[28]} {pcin_IBUF[29]} {pcin_IBUF[30]} {pcin_IBUF[31]} {pcin_IBUF[32]} {pcin_IBUF[33]} {pcin_IBUF[34]} {pcin_IBUF[35]} {pcin_IBUF[36]} {pcin_IBUF[37]} {pcin_IBUF[38]} {pcin_IBUF[39]} {pcin_IBUF[40]} {pcin_IBUF[41]} {pcin_IBUF[42]} {pcin_IBUF[43]} {pcin_IBUF[44]} {pcin_IBUF[45]} {pcin_IBUF[46]} {pcin_IBUF[47]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
set_property port_width 48 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list {p_OBUF[0]} {p_OBUF[1]} {p_OBUF[2]} {p_OBUF[3]} {p_OBUF[4]} {p_OBUF[5]} {p_OBUF[6]} {p_OBUF[7]} {p_OBUF[8]} {p_OBUF[9]} {p_OBUF[10]} {p_OBUF[11]} {p_OBUF[12]} {p_OBUF[13]} {p_OBUF[14]} {p_OBUF[15]} {p_OBUF[16]} {p_OBUF[17]} {p_OBUF[18]} {p_OBUF[19]} {p_OBUF[20]} {p_OBUF[21]} {p_OBUF[22]} {p_OBUF[23]} {p_OBUF[24]} {p_OBUF[25]} {p_OBUF[26]} {p_OBUF[27]} {p_OBUF[28]} {p_OBUF[29]} {p_OBUF[30]} {p_OBUF[31]} {p_OBUF[32]} {p_OBUF[33]} {p_OBUF[34]} {p_OBUF[35]} {p_OBUF[36]} {p_OBUF[37]} {p_OBUF[38]} {p_OBUF[39]} {p_OBUF[40]} {p_OBUF[41]} {p_OBUF[42]} {p_OBUF[43]} {p_OBUF[44]} {p_OBUF[45]} {p_OBUF[46]} {p_OBUF[47]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
set_property port_width 18 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list {a_IBUF[0]} {a_IBUF[1]} {a_IBUF[2]} {a_IBUF[3]} {a_IBUF[4]} {a_IBUF[5]} {a_IBUF[6]} {a_IBUF[7]} {a_IBUF[8]} {a_IBUF[9]} {a_IBUF[10]} {a_IBUF[11]} {a_IBUF[12]} {a_IBUF[13]} {a_IBUF[14]} {a_IBUF[15]} {a_IBUF[16]} {a_IBUF[17]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
set_property port_width 8 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list {opmode_IBUF[0]} {opmode_IBUF[1]} {opmode_IBUF[2]} {opmode_IBUF[3]} {opmode_IBUF[4]} {opmode_IBUF[5]} {opmode_IBUF[6]} {opmode_IBUF[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
set_property port_width 18 [get_debug_ports u_ila_0/probe7]
connect_debug_port u_ila_0/probe7 [get_nets [list {b_IBUF[0]} {b_IBUF[1]} {b_IBUF[2]} {b_IBUF[3]} {b_IBUF[4]} {b_IBUF[5]} {b_IBUF[6]} {b_IBUF[7]} {b_IBUF[8]} {b_IBUF[9]} {b_IBUF[10]} {b_IBUF[11]} {b_IBUF[12]} {b_IBUF[13]} {b_IBUF[14]} {b_IBUF[15]} {b_IBUF[16]} {b_IBUF[17]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
set_property port_width 18 [get_debug_ports u_ila_0/probe8]
connect_debug_port u_ila_0/probe8 [get_nets [list {d_IBUF[0]} {d_IBUF[1]} {d_IBUF[2]} {d_IBUF[3]} {d_IBUF[4]} {d_IBUF[5]} {d_IBUF[6]} {d_IBUF[7]} {d_IBUF[8]} {d_IBUF[9]} {d_IBUF[10]} {d_IBUF[11]} {d_IBUF[12]} {d_IBUF[13]} {d_IBUF[14]} {d_IBUF[15]} {d_IBUF[16]} {d_IBUF[17]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe9]
set_property port_width 1 [get_debug_ports u_ila_0/probe9]
connect_debug_port u_ila_0/probe9 [get_nets [list cea_IBUF]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe10]
set_property port_width 1 [get_debug_ports u_ila_0/probe10]
connect_debug_port u_ila_0/probe10 [get_nets [list ceb_IBUF]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe11]
set_property port_width 1 [get_debug_ports u_ila_0/probe11]
connect_debug_port u_ila_0/probe11 [get_nets [list cec_IBUF]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe12]
set_property port_width 1 [get_debug_ports u_ila_0/probe12]
connect_debug_port u_ila_0/probe12 [get_nets [list cecarryin_IBUF]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe13]
set_property port_width 1 [get_debug_ports u_ila_0/probe13]
connect_debug_port u_ila_0/probe13 [get_nets [list ced_IBUF]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe14]
set_property port_width 1 [get_debug_ports u_ila_0/probe14]
connect_debug_port u_ila_0/probe14 [get_nets [list cem_IBUF]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe15]
set_property port_width 1 [get_debug_ports u_ila_0/probe15]
connect_debug_port u_ila_0/probe15 [get_nets [list ceopmode_IBUF]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe16]
set_property port_width 1 [get_debug_ports u_ila_0/probe16]
connect_debug_port u_ila_0/probe16 [get_nets [list cep_IBUF]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe17]
set_property port_width 1 [get_debug_ports u_ila_0/probe17]
connect_debug_port u_ila_0/probe17 [get_nets [list clk_IBUF]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe18]
set_property port_width 1 [get_debug_ports u_ila_0/probe18]
connect_debug_port u_ila_0/probe18 [get_nets [list rsta_IBUF]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe19]
set_property port_width 1 [get_debug_ports u_ila_0/probe19]
connect_debug_port u_ila_0/probe19 [get_nets [list rstb_IBUF]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe20]
set_property port_width 1 [get_debug_ports u_ila_0/probe20]
connect_debug_port u_ila_0/probe20 [get_nets [list rstc_IBUF]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe21]
set_property port_width 1 [get_debug_ports u_ila_0/probe21]
connect_debug_port u_ila_0/probe21 [get_nets [list rstcarryin_IBUF]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe22]
set_property port_width 1 [get_debug_ports u_ila_0/probe22]
connect_debug_port u_ila_0/probe22 [get_nets [list rstd_IBUF]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe23]
set_property port_width 1 [get_debug_ports u_ila_0/probe23]
connect_debug_port u_ila_0/probe23 [get_nets [list rstm_IBUF]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe24]
set_property port_width 1 [get_debug_ports u_ila_0/probe24]
connect_debug_port u_ila_0/probe24 [get_nets [list rstopmode_IBUF]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe25]
set_property port_width 1 [get_debug_ports u_ila_0/probe25]
connect_debug_port u_ila_0/probe25 [get_nets [list rstp_IBUF]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets clk_IBUF_BUFG]
