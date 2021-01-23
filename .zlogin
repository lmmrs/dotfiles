if [ -t 0 ]
then
	mesg y
	echo
	uptime
	echo
	log
	echo
	/usr/local/bin/calendar -f ~/.agenda
fi
