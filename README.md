**Changing known fixed talkgroups to TalkGroup names**
Certain TalkGroups have already some .wav files 
If you want to add further talkgroups to the list, then go to the /etc/svxlink/svxlink.d/TalkGroups.sh and add in the format shown. Do not add the .wav suffix here, but in 
/usr/share/svxlink/sounds/en_GB/Custom/ folder with the same name plus .wav suffix.

First run:

sudo git clone https://github.com/f5vmr/SpeakSvxLinkTalkGroups

sudo ./SpeakSvxLinkTalkGroups/install.sh 

This will install all the code. The file /usr/share/svxlink/events.d/LogicBase.tcl will be changed, but a backup created in case of error.

For future additional TalkGroups

The sample should have been contructed in 48000 and 16kHz.

each subsequant change will require sudo system restart svxlink