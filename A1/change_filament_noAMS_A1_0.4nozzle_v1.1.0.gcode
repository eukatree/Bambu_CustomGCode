;===== machine: A1 =========================
;===== date: 20260124 =======================
G392 S0
M204 S9000
{if toolchange_count > 1}
G17
G2 Z{max_layer_z + 0.4} I0.86 J0.86 P1 F10000 ; spiral lift a little from second lift
G1 Z{max_layer_z + 3.0} F1200
{else}
G1 Z{max_layer_z + 3.0} F1200 ; lift on first toolchange too
{endif}

M400
M106 P1 S0
M106 P2 S0
{if old_filament_temp > 142 && next_extruder < 255}
M104 S[old_filament_temp]
{endif}

G1 X256 F18000
G1 X273 F500
G1 X256 F500
M620.1 E F[old_filament_e_feedrate] T{nozzle_temperature_range_high[previous_extruder]}
M620.10 A0 F[old_filament_e_feedrate]
T[next_extruder]
M620.1 E F[new_filament_e_feedrate] T{nozzle_temperature_range_high[next_extruder]}
M620.10 A1 F[new_filament_e_feedrate] L[flush_length] H[nozzle_diameter] T[nozzle_temperature_range_high]

G1 Y128 F9000
G1 X-48.2 F9000
G1 X-48.2 F900

; pause for user to load and press resume
M400 U1