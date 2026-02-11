###############################################################################
# Spoken TalkGroups override
###############################################################################

# Preserve original say_talkgroup
if {[info procs say_talkgroup] ne ""} {
    rename say_talkgroup say_talkgroup_default
}

variable spokenTgTable
variable spokenTgLoaded 0
array set spokenTgTable {}

proc loadSpokenTalkGroups {} {
    variable spokenTgTable
    variable spokenTgLoaded

    # Guard: load only once
    if {$spokenTgLoaded} {
        return
    }

    set spokenTgLoaded 1

    # Config is now guaranteed to exist
    set cfg [Config::new "TalkGroups.conf"]

    if {[$cfg sectionExists "SpokenTalkGroups"]} {
        foreach tg [$cfg listKeys "SpokenTalkGroups"] {
            set spokenTgTable($tg) [$cfg get "SpokenTalkGroups" $tg]
        }
    }
}

proc say_talkgroup {tg} {
    variable spokenTgTable

    # Lazy-load config on first use
    loadSpokenTalkGroups
puts "SpokenTG: TG=$tg custom=[info exists spokenTgTable($tg)]"

    if {[info exists spokenTgTable($tg)]} {
        playMsg $spokenTgTable($tg) "" 0
        return
    }

    # Fallback
    if {[info procs say_talkgroup_default] ne ""} {
        say_talkgroup_default $tg
    } else {
        spellNumber $tg
    }
}
