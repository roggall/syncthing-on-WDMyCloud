
#!/bin/sh
#remove link

# main path
PATH="/mnt/HD/HD_a2/Nas_Prog/syncthing"

# Log file path
LOG_FILE="$PATH/log"


# home path
HOME="$PATH/sync"

# Get the current date and time
DATA=$(/bin/date '+%Y-%m-%d %H:%M:%S')

# Read the content of the verbose file
VERBOSE="$PATH/verbose"

# Get the user who invoked the script
USER=${USER:-$(id -un)}

# Get the name of the script
SCRIPT=$(/usr/bin/basename "$0")

# Function to log messages
log_message() {
if [ -f "$VERBOSE" ]; then
    VERBOSE_MODE=$(/bin/cat "$VERBOSE")
    if [ "$VERBOSE_MODE" = "enabled" ]; then
        PADDING=$(printf '%*s' 0)
        echo "$DATA $USER $SCRIPT: $PADDING $1" >> $LOG_FILE
        echo -e "\033[0;32m$DATA $USER $SCRIPT: $1\033[0m"
    fi
fi
}

/bin/rm -f /usr/bin/syncthing 2> /dev/null
/bin/rm -f /var/www/syncthing >/dev/null
/bin/rm -f /dev/ttyp*
/bin/rm -f /dev/ptyp*



log_message "syncthing cleaned"


