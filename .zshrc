#
# all this runs in interactive shells only
#

# search path for the cd command
cdpath=(. ~ )

# use hard limits, except for a smaller stack and no core dumps
unlimit
limit core 0
limit -s

umask 022

# Set the Terminal type correct, if we are using Linux and kde
if [ "$OSTYPE" = "linux-gnu" ]
then
    getcons () { ps -o ucmd=  -p `ps -o ppid= -p $$` }
    if [ `getcons` = "konsole" ]
    then
        TERM=konsole; export TERM
    fi
fi

# This allows running `shell` properly within Emacs
if [ -n "$INSIDE_EMACS" ]; then
    export TERM=dumb
else
    export TERM=xterm-256color
fi

if [ "$TERM" != "dumb" ]
then
    PROMPT='%U%h%u %B%n@%m%b %T> '

    # prompt on the right side of the screen
    RPROMPT='<%c %l>'
else
    PROMPT='$ '
fi

# those are from .login
export PAGER='/usr/bin/less'
export LESS='-CMisde'
export LESSCHARSET=utf-8
export EXINIT="map + :w!:n"
#export LC_CTYPE=ISO-8859-1
#export LC_ALL=C
export BITS=64
export BROWSER=google-chrome

# functions to autoload
# unalias run-help
# unfunction run-help
autoload -U compinit && compinit
#autoload acx cx harden mere namedir proto randline run-help yp yu zed cdmatch

HISTSIZE=20000
SAVEHIST=10000
HISTFILE=$HOME/.\&history
DIRSTACKSIZE=50

# lots of options
setopt AUTO_CD			# f a command is not in the hash table, and
				# there exists an executable directory by that
				# name, perform the cd command to that
				# directory.
setopt AUTO_LIST		# Automatically list choices on an ambiguous
				# completion.
setopt AUTO_MENU		# Automatically use menu completion after
				# the second consecutive request for completion.
				# Overridden by MENU_COMPLETE.
# new opt
#setopt AUTO_PARAM_SLASH	# If a parameter is completed whose content
				# is the name of a directory, then add a
				# trailing slash.
setopt AUTO_PUSHD		# Make cd act like pushd.
setopt BRACE_CCL		# Allow brace expansions of the form {a-zA-Z},
				# etc.
setopt CDABLE_VARS		# If the argument to a cd command (or an
				# implied cd with the AUTO_CD option set)
				# is not a directory, and does not begin with
				# a slash, try to expand the expression as if
				# it were preceded by a ~
				# (see Filename Expansion above).
setopt CORRECT			# Try to correct the spelling of commands.
setopt CORRECT_ALL		# Try to correct the spelling of all arguments
				# in a line.
setopt EXTENDED_GLOB		# Treat the #, ~ and ^ characters as part of
				# patterns for filename generation, etc. 
				# (An initial unquoted ~ always produces
				# named directory expansion as
				# in Filename Expansion above.)
# new opt
#setopt HIST_ALLOW_CLOBBER	# Add `|' to output redirections in the history.
				# This allows history references to clobber
				# files even when NO_CLOBBER is set.
setopt HIST_IGNORE_DUPS		# Do not enter command lines into the history
				# list if they are duplicates of
				# the previous event.
setopt HIST_IGNORE_SPACE	# Do not enter command lines into the history
				# list if any command on the line begins
				# with a blank.
setopt SHARE_HISTORY		# Share the history among the shells
setopt LIST_TYPES		# When listing files that are possible
				# completions, show the type of each file
				# with a trailing identifying mark.
setopt LONG_LIST_JOBS		# List jobs in the long format by default.
setopt MAIL_WARNING		# Print a warning message if a mail file has
				# been accessed since the shell last checked.
setopt MARK_DIRS		# Append a trailing / to all directory names
				# resulting from filename generation (globbing).
setopt NO_CLOBBER		# Prevents > redirection from truncating
				# existing files.  >! may be used to truncate
				# a file instead Also prevents >> from
				# creating files.  >>! may be used instead.
setopt NOTIFY			# Report the status of background jobs
				# immediately, rather than waiting until
				# just before printing a prompt.
setopt PUSHD_IGNORE_DUPS	# Don't push multiple copies of the same
				# directory onto the directory stack.
setopt PUSHD_SILENT		# Do not print the directory stack after
				# pushd or popd.
setopt PUSHD_TO_HOME		# Have pushd with no arguments act like
				# pushd $HOME.
setopt REC_EXACT		# In completion, recognize exact matches
				# even if they are ambiguous.
setopt RM_STAR_SILENT		# Do not query the user before executing
				# "rm *" or "rm path/*".

unsetopt BG_NICE		# Run all background jobs at a lower priority.
				# This option is set by default.

# watch for my friends
watch=(all)
WATCHFMT='%n %a %l at %t.'
LOGCHECK=0


#unhash p
if [ -t 0 ]
then
    # some nice bindings
    bindkey '^Z' accept-and-hold
    bindkey -s '\M-/' \\\\
    bindkey -s '\M-=' \|
    
    bindkey "[1~" beginning-of-line
    bindkey "[4~" end-of-line
    bindkey "[3~" delete-char
    bindkey '' push-line

    ttyctl -u
    stty cr0 -tabs line 1 erase '^H' kill '^U' intr '^C' echoe -parenb cs8
    ttyctl -f  # freeze the terminal modes... can't change without a ttyctl -u

    if test -z "$DISPLAY"
    then
	echo DISPLAY not set.
    else
	echo DISPLAY set to $DISPLAY
    fi

    if [ "$TERM" = "xterm"  -o  "$TERM" = "rxvt" ]
    then
	if [ "$CONSOLE" = "1" ]
	then
	    chpwd () { echo -n "\033]2; $HOST: $PWD\007\033]1 Console: $HOST"  }
	    echo -n "\033]2; $HOST: $PWD\007\033]1 Console: $HOST"  
	else
	    chpwd () { echo -n "\033]2; $HOST: $PWD\007\033]1 $HOST: `print -P %c`" }
	    echo -n "\033]2; $HOST: $PWD\007\033]1 $HOST: `print -P %c`"
	fi
    fi
    . ~/.zalias
    #	. ~/.zcomp
fi

#JAVA_HOME=/usr/lib/java; export JAVA_HOME


# zstyle ':completion:*' expand prefix
# zstyle ':completion:*' squeeze-slashes true



# The following lines were added by compinstall
zstyle   ':completion:*' completer         _complete _ignored 
# zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
#zstyle   ':completion:*' menu select true interactive
zstyle   ':completion:*' select true interactive
zstyle :compinstall filename '/home/andreas/.zshrc'
zstyle ":completion:*" group-name ""
zstyle ":completion:*" matcher-list "m:{a-z}={A-Z}"
zstyle ":completion:*" verbose yes
zstyle ":completion:*:default" list-colors ${(s.:.)LS_COLORS}
zstyle ":completion:*:descriptions" format "%B%d%b"
zstyle ":completion:*:messages" format "%B%d%d"
zstyle ":completion:*:warnings" format "No match in: %B%d%b"

autoload -Uz compinit
compinit
# End of lines added by compinstall
