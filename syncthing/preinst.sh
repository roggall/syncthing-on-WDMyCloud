
#!/bin/sh
path_src=$1
path_des=$2
#we do nothing here for syncthing

# Log file path
LOG_FILE="/mnt/HD/HD_a2/Nas_Prog/syncthing/log"

# home path
HOME="/mnt/HD/HD_a2/Nas_Prog/syncthing/sync"

# Get the current date and time
DATA=$(date '+%Y-%m-%d %H:%M:%S')

# Read the content of the verbose file
VERBOSE="/mnt/HD/HD_a2/Nas_Prog/syncthing/verbose"

# Get the user who invoked the script
USER=${USER:-$(id -un)}

# Get the name of the script
SCRIPT=$(basename "$0")

# Function to log messages
log_message() {
if [ -f "$VERBOSE" ]; then
    VERBOSE_MODE=$(cat "$VERBOSE")
    if [ "$VERBOSE_MODE" = "enabled" ]; then
        PADDING=$(printf '%*s' 1)
        echo "$DATA $USER $SCRIPT: $PADDING $1" >> $LOG_FILE
        echo -e "\033[0;32m$DATA $USER $SCRIPT: $1\033[0m"
    fi
fi
}

log_message "has been invoked, nothing to do"

