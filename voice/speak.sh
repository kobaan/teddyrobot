#/usr/bin/pico2wave --lang=de-DE --wave=/tmp/$$.wav $1 && /usr/bin/play /tmp/$$.wav tempo 0.8 pitch 400 && rm /tmp/$$.wav
/usr/bin/pico2wave --lang=de-DE --wave=/tmp/$$.wav "$1" && sync && sync && AUDIODEV="plughw:Device" /usr/bin/play /tmp/$$.wav tempo 0.8 pitch 400 && rm /tmp/$$.wav
