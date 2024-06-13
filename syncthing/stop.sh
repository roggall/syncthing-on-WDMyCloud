#!/bin/sh
#stop daemon

# main path
PATH=$1

# Log file path
LOG_FILE="$PATH/log"

# home path
HOME="$(/usr/bin/dirname "$1")/sync"

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
        PADDING=$(printf '%*s' 1)
        echo "$DATA $USER $SCRIPT: $PADDING $1" >> $LOG_FILE
        echo -e "\033[0;32m$DATA $USER $SCRIPT: $1\033[0m"
    fi
fi
}


# Check if Syncthing is running
is_syncthing_running() {
    if /usr/sbin/pgrep -x "syncthing" > /dev/null; then
        echo "is running"
        return 1
    else
        echo "is not running"
        return 0
    fi
}


# Main script logic
is_syncthing_running
if [ $? -eq 1 ]; then
    /usr/bin/killall syncthing
    log_message "syncthing stopped"
else
    log_message "syncthing is not working, nothing to do"
fi


