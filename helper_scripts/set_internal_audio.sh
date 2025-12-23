#!/bin/bash
# set a keyboard shortcut to run this script (SHIFT + F1) is what i use

# to find these options, set the audio settings the way you want them then run pactl get-default-sink and get-default-source. then apply those values to this script
eval $(pactl set-default-sink alsa_output.pci-0000_00_1f.3.analog-stereo) 
eval $(pactl set-default-source alsa_input.pci-0000_00_1f.3.analog-stereo) 
