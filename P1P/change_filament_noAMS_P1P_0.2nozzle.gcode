; change filament without AMS g-code
{if toolchange_count > 1}
M204 S9000 ; set starting acceleration
G17 ; set CNC workspace plane
G2 Z{max_layer_z + 0.4} I0.86 J0.86 P1 F10000 ; spiral lift
G1 Z{max_layer_z + 3.0} F1200 ; vertical lift

; move to poop chute
G1 X70 F21000
G1 Y245
G1 Y265 F3000
M400

; turn off fans P1 and P2
M106 P1 S0
M106 P2 S0

; wipe?
G1 X90 F3000
G1 Y255 F4000
G1 X100 F5000
G1 X120 F15000

; move to position to prep for cutting filament
G1 X20 Y50 F21000
G1 Y-3

; cut filament
G1 X5 F300
G1 X20 F12000

; move to poop chute
G1 X70 F5000
G1 X165 F15000
G1 Y245 F21000
G1 X65 
G1 Y265 F3000

; push a little filament out and then retract
G1 E5 F200
G1 E-10 F200
G1 E-20 F500

; pause for user to load and press resume
; (Note: this causes the toolhead to move and open the door)
M400 U1

; close door before flushing
G1 X165 F15000
G1 Y245 F21000
G1 X65 
G1 Y265 F3000

; FLUSH_START
; always use highest temperature to flush
M400
{if filament_type[next_extruder] == "PETG"}
M109 S220
{else}
M109 S[nozzle_temperature_range_high]
{endif}

; don't know when next_extruder is >=255, so this may always activate?
{if next_extruder < 255}
M400

G92 E0
{if flush_length_1 > 1}
; FLUSH_START
{if flush_length_1 > 23.7}
G1 E23.7 F{old_filament_e_feedrate * 3} ; do not need pulsatile flushing for start part
G1 E{(flush_length_1 - 23.7) * 0.02} F50
G1 E{(flush_length_1 - 23.7) * 0.23} F{old_filament_e_feedrate * 3} ; Triple the speed, these are really slow with 0.2 nozzle
G1 E{(flush_length_1 - 23.7) * 0.02} F50
G1 E{(flush_length_1 - 23.7) * 0.23} F{new_filament_e_feedrate * 3}
G1 E{(flush_length_1 - 23.7) * 0.02} F50
G1 E{(flush_length_1 - 23.7) * 0.23} F{new_filament_e_feedrate * 3}
G1 E{(flush_length_1 - 23.7) * 0.02} F50
G1 E{(flush_length_1 - 23.7) * 0.23} F{new_filament_e_feedrate * 3}
{else}
G1 E{flush_length_1} F{old_filament_e_feedrate}
{endif}
; FLUSH_END
G1 E-[old_retract_length_toolchange] F1800
G1 E[old_retract_length_toolchange] F300
{endif}


;--- These additional flushes take a really long time with a 0.2 nozzle.  ---
; As long as you have a purge block, they aren't needed

; {if flush_length_2 > 1}
; ; FLUSH_START
; G1 E{flush_length_2 * 0.18} F{new_filament_e_feedrate}
; G1 E{flush_length_2 * 0.02} F50
; G1 E{flush_length_2 * 0.18} F{new_filament_e_feedrate}
; G1 E{flush_length_2 * 0.02} F50
; G1 E{flush_length_2 * 0.18} F{new_filament_e_feedrate}
; G1 E{flush_length_2 * 0.02} F50
; G1 E{flush_length_2 * 0.18} F{new_filament_e_feedrate}
; G1 E{flush_length_2 * 0.02} F50
; G1 E{flush_length_2 * 0.18} F{new_filament_e_feedrate}
; G1 E{flush_length_2 * 0.02} F50
; ; FLUSH_END
; G1 E-[new_retract_length_toolchange] F1800
; G1 E[new_retract_length_toolchange] F300
; {endif}

; {if flush_length_3 > 1}
; ; FLUSH_START
; G1 E{flush_length_3 * 0.18} F{new_filament_e_feedrate}
; G1 E{flush_length_3 * 0.02} F50
; G1 E{flush_length_3 * 0.18} F{new_filament_e_feedrate}
; G1 E{flush_length_3 * 0.02} F50
; G1 E{flush_length_3 * 0.18} F{new_filament_e_feedrate}
; G1 E{flush_length_3 * 0.02} F50
; G1 E{flush_length_3 * 0.18} F{new_filament_e_feedrate}
; G1 E{flush_length_3 * 0.02} F50
; G1 E{flush_length_3 * 0.18} F{new_filament_e_feedrate}
; G1 E{flush_length_3 * 0.02} F50
; ; FLUSH_END
; G1 E-[new_retract_length_toolchange] F1800
; G1 E[new_retract_length_toolchange] F300
; {endif}

; {if flush_length_4 > 1}
; ; FLUSH_START
; G1 E{flush_length_4 * 0.18} F{new_filament_e_feedrate}
; G1 E{flush_length_4 * 0.02} F50
; G1 E{flush_length_4 * 0.18} F{new_filament_e_feedrate}
; G1 E{flush_length_4 * 0.02} F50
; G1 E{flush_length_4 * 0.18} F{new_filament_e_feedrate}
; G1 E{flush_length_4 * 0.02} F50
; G1 E{flush_length_4 * 0.18} F{new_filament_e_feedrate}
; G1 E{flush_length_4 * 0.02} F50
; G1 E{flush_length_4 * 0.18} F{new_filament_e_feedrate}
; G1 E{flush_length_4 * 0.02} F50
; ; FLUSH_END
; {endif}

; FLUSH_START
M400
M109 S[new_filament_temp]
G1 E2 F{new_filament_e_feedrate} ;Compensate for filament spillage during waiting temperature
; FLUSH_END
M400
G92 E0
G1 E-[new_retract_length_toolchange] F1800
M106 P1 S255
M400
G1 X80 F15000
G1 X60 F15000
G1 X80 F15000
G1 X60 F15000; shake to put down garbage

G1 X70 F5000
G1 X90 F3000
G1 Y255 F4000
G1 X100 F5000
G1 Y265 F5000
G1 X70 F10000
G1 X100 F5000
G1 X70 F10000
G1 X100 F5000
G1 X165 F15000; wipe and shake
G1 Y256 ; move Y to aside, prevent collision
M400
G1 Z[z_after_toolchange] F3000
{if layer_z <= (initial_layer_print_height + 0.001)}
M204 S[initial_layer_acceleration]
{else}
M204 S[default_acceleration]
{endif}
{else}
G1 X[x_after_toolchange] Y[y_after_toolchange] Z[z_after_toolchange] F12000
{endif}

{endif}

; as there is no AMS, these next three lines only serve to hide T[next_extruder]
; if this was not included, the T[next_extruder] command is input after this
; code and will cause the system to hang as the toolchange command searches
; for the AMS
M620 S[next_extruder]A
T[next_extruder]
M621 S[next_extruder]A
