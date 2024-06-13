#!/bin/sh
PATH_SRC=$1 #/mnt/HD/HD_a2/Nas_Prog/_install/
PATH_DES=$2 #/mnt/HD/HD_a2/Nas_Prog/syncthing


# PARENT_DIR=$(/usr/bin/dirname "$PATH")

# Log file path
LOG_FILE="$PATH_DES/log"
LOG_INITIAL_FILE=$(/usr/bin/dirname "$PATH")


# home path
# HOME="$PATH_DES/sync"

# Get the current date and time
DATA=$(date '+%Y-%m-%d %H:%M:%S')

# Read the content of the verbose file
VERBOSE="$PATH_DES/verbose"

# Get the user who invoked the script
USER=${USER:-$(id -un)}

# Get the name of the script
SCRIPT=$(basename "$0")

# Function to log messages
log_message() {
#if [ -f "$VERBOSE" ]; then
#    VERBOSE_MODE=$(cat "$VERBOSE")
#    if [ "$VERBOSE_MODE" = "enabled" ]; then
        PADDING=$(printf '%*s' 0)
        /bin/touch /mnt/HD/HD_a2/Nas_Prog/log
        echo "$DATA $USER $SCRIPT: $PADDING $1" >> $LOG_FILE
        echo "$DATA $USER $SCRIPT: $PADDING $1" >> /mnt/HD/HD_a2/Nas_Prog/log
        echo -e "\033[0;32m$DATA $USER $SCRIPT: $1\033[0m"
#    fi
#fi
}


/bin/mv $PATH_SRC $PATH_DES

/bin/chmod 775 $PATH_DES

log_message "syncthing installed"
