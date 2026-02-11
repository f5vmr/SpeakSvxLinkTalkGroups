#!/bin/bash
#here we install the talkgroup project first
sudo cp /usr/share/svxlink/events.d/ReflectorV2LogicType.tcl /usr/share/svxlink/events.d/ReflectorV2LogicType.tcl.orig
grep -q 'SpokenTG.tcl' /usr/share/svxlink/events.d/ReflectorV2LogicType.tcl || \
sudo cp SpeakSvxLinkTalkGroups/configs/SpokenTG.tcl /usr/share/svxlink/events.d/ && 
# that's the logic that adds our code to the LogicBase.tcl
# now we move the talkgroup wav files to a good location
sudo mkdir -p /usr/share/svxlink/sounds/en_GB/Custom
sudo cp -rup SpeakSvxLinkTalkGroups/customTG/* /usr/share/svxlink/sounds/en_GB/Custom/
sudo cp -rup SpeakSvxLinkTalkGroups/configs/TalkGroups.conf /etc/svxlink/svxlink.d/
sudo systemctl restart svxlink

