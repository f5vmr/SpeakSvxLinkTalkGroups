###############################################################################
# Spoken TalkGroups override for ReflectorV2LogicType
# Should be sourced after LogicBase.tcl in the reflector namespace
###############################################################################

# Preserve the original say_talkgroup if it exists
if {[info procs say_talkgroup] ne ""} {
    rename say_talkgroup say_talkgroup_default
}

# Table of custom TG → WAV path
variable spokenTgTable
array set spokenTgTable {}

proc loadSpokenTalkGroups {} {
    variable spokenTgTable
    set cfg [Config::new "TalkGroups.conf"]
    if {[$cfg sectionExists "SpokenTalkGroups"]} {
        foreach tg [$cfg listKeys "SpokenTalkGroups"] {
            set spokenTgTable($tg) [$cfg get "SpokenTalkGroups" $tg]
        }
    }
}

# Load the table immediately
loadSpokenTalkGroups

# Override say_talkgroup
proc say_talkgroup {tg} {
    variable spokenTgTable
    if {[info exists spokenTgTable($tg)]} {
        playMsg $spokenTgTable($tg) "" 0
        return
    }

    # fallback to original
    if {[info procs say_talkgroup_default] ne ""} {
        say_talkgroup_default $tg
    } else {
        spellNumber $tg
    }
}
