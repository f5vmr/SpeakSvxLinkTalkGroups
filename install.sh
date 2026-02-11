#!/bin/bash
#here we install the talkgroup project first
sudo cp /usr/share/svxlink/events.d/LogicBase.tcl /usr/share/svxlink/events.d/LogicBase.tcl.orig
sudo sed -i '/# End of namespace Logic/i \
# --- Spoken TalkGroup support ----------------------------\n\
variable spokenTgTable\n\
array set spokenTgTable {}\n\
\n\
proc loadSpokenTalkGroups {} {\n\
    variable spokenTgTable\n\
    set cfg [Config::new "TalkGroups.conf"]\n\
    if {[$cfg sectionExists "SpokenTalkGroups"]} {\n\
        foreach tg [$cfg listKeys "SpokenTalkGroups"] {\n\
            set spokenTgTable($tg) [$cfg get "SpokenTalkGroups" $tg]\n\
        }\n\
    }\n\
}\n\
\n\
loadSpokenTalkGroups\n\
\n\
if {[info procs say_talkgroup] ne ""} {\n\
    rename say_talkgroup say_talkgroup_default\n\
}\n\
\n\
proc say_talkgroup {tg} {\n\
    variable spokenTgTable\n\
    if {[info exists spokenTgTable($tg)]} {\n\
        playMsg $spokenTgTable($tg) "" 0\n\
        return\n\
    }\n\
    if {[info procs say_talkgroup_default] ne ""} {\n\
        say_talkgroup_default $tg\n\
    } else {\n\
        spellNumber $tg\n\
    }\n\
}\n\
# --- End Spoken TalkGroup support -------------------------\
' /usr/share/svxlink/events.d/LogicBase.tcl
# that's the logic that adds our code to the LogicBase.tcl
# now we move the talkgroup wav files to a good location
sudo mkdir -p /usr/share/svxlink/en_GB/sounds/Custom
sudo cp -r SpeakSvxLinkTalkGroups/talkgroup/sounds/* /usr/share/svxlink/en_GB/sounds/Custom/
sudo cp -r SpeakSvxLinkTalkGroups/talkgroup/TalkGroups.conf /etc/svxlink/svxlink.d/
sudo systemctl restart svxlink

