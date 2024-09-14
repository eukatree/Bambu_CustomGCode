# Custom G-Code for Bambu Studio

Repository for custom g-code for Bambu Studio. It also contains original g-code for reference - in the case that the code needs to be reverted to the stock, check Bambu Studio's repository for the latest available g-code.

Custom g-code to change the filament on a BambuLab P1P printer without an AMS. This makes it so changing filament in the slicer (instead of just pausing) will unload the filament and pause. Previously, the g-code for changing filament would be ignored if there was no AMS and would continue the print.

I couldn't find the actual g-code to cut the filament and unload the filament anywhere, so I just added G1 codes to try to mimic the motion that occurs when pressing the unload filament button. I also added the code to extrude forward a bit, and then back it out. 

Use at your own risk!

# Installation Instructions

Find the "Change filament G-code" section. To get here, click the edit button here:
|![Edit Button Location](https://preview.redd.it/change-filament-g-code-without-ams-v0-rfihlq0jxgla1.png?width=507&format=png&auto=webp&s=1231c5613077f4d77bacf2cc5e725c57a27e11c0)

Click the "Machine G-Code tab", and then scroll down to the section "Change filament G-code". The most common error is that the wrong section is used, so make sure you find the section labeled "Change filament G-code".
|![Change Filament G-Code Location](https://preview.redd.it/change-filament-g-code-without-ams-v0-uk4z121qxgla1.png?width=744&format=png&auto=webp&s=43d8a159ba1e2c5aad9c308fe28a026fff891362)

Replace the code in "Change filament G-code" with the code from this file:
P1P/change_filament_noAMS_P1P_0.4nozzle_v1.9.5.gcode

Replace the code in Bambu Studio for "Change filament G-code" with the code from: 
This code would replace the code in Bambu Studio. Click to edit the preset circled below, and then replace all the code in the highlighted box under "Change filament G-code" 

See reddit thread here: https://www.reddit.com/r/BambuLab/comments/11gtlfp/change_filament_gcode_without_ams/

# Copyright & License

Copyright (c) 2023 eukadesigns
|![gplv3-only](https://www.gnu.org/graphics/gplv3-with-text-136x68.png) |![gplv3-or-later](https://www.gnu.org/graphics/gplv3-or-later.png)|
|-|-|

# Donate

[![Donate](https://www.paypalobjects.com/en_US/i/btn/btn_donate_LG.gif)](https://www.paypal.com/donate/?hosted_button_id=E4KPLLP23T2NL)
