if [[ "${ENVONLY:-0}" -eq 1 ]]; then unsetopt zle; fi

d=~/Biochem/diss
s=/usr/local/snd

LANG="en_US.UTF-8"; export LANG

if [ "$OSTYPE" = "cygwin" ]; then
	export PATH=$PATH:$HOME/bin:/cygdrive/c/Programme/Impressive
	PRINTER=//prshbm00/MUC2; export PRINTER

        #    export ANT_HOME=/usr/local/ant
	#    export JAVA_HOME=/cygdrive/c/java/j2sdk1.4.2_02
	#    export PATH=$JAVA_HOME/bin:$ANT_HOME/bin:$PATH
else
        export PATH=$PATH:$HOME/bin:/sbin:/usr/sbin:/opt/MaXX/bin
        XCURSOR_THEME=redSGI
        export XCURSOR_THEME
fi
OSFONTDIR=~/.local/share/fonts; export OSFONTDIR
#JAVA_HOME=/usr/lib/java; export JAVA_HOME
_JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd_hrgb -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'; export _JAVA_OPTIONS
