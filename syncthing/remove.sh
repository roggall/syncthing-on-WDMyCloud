#!/bin/sh

# Check if the path is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <full_path>"
    exit 1
fi

PATH=$1

# Function to extract and echo the parent directory
extract_parent_directory() {
    PARENT_DIR=$(/usr/bin/dirname "$PATH")
    WORK_DIR=$(/usr/bin/basename "$PATH")
}

# Function to log messages
log_message() {
        PADDING=$(printf '%*s' 1)
        echo "$DATA $USER $SCRIPT: $PADDING $1" >> $LOG_FILE
        echo -e "\033[0;32m$DATA $USER $SCRIPT: $1\033[0m"
}

# Get the current date and time
DATA=$(/bin/date '+%Y-%m-%d %H:%M:%S')

# Get the user who invoked the script
USER=${USER:-$(id -un)}

# Get the name of the script
SCRIPT=$(/usr/bin/basename "$0")

extract_parent_directory
# echo "path is $PATH"
# echo "parent dir is $PARENT_DIR"
# echo "working dir is $WORK_DIR"

# Define the log file path
/bin/touch $PARENT_DIR/log
LOG_FILE="$PARENT_DIR/log"


# Add date, time, and text to the log file
log_message "$WORK_DIR removed"

/bin/rm -f /usr/bin/syncthing 2> /dev/null
/bin/rm -f /var/www/syncthing >/dev/null
/bin/rm -rf $PATH



