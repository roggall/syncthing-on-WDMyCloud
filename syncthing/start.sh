#!/bin/sh

# main path
PATH=$1

#Log file path
LOG_="log"
LOG_FILE="${PATH}${LOG_}"

#bin path containing the syncthing executable file
BIN_="bin"
BIN_DIR="${PATH}${BIN_}"

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

#profile for the ash with the defaults
PROFILE_FILE="/home/root/.profile"


# Function to log messages
log_message() {
if [ -f "$VERBOSE" ]; then
    VERBOSE_MODE=$(/bin/cat "$VERBOSE")
    if [ "$VERBOSE_MODE" = "enabled" ]; then
        PADDING=$(printf '%*s' )
        echo "$DATA $USER $SCRIPT: $PADDING $1" >> $LOG_FILE
        echo -e "\033[0;32m$DATA $USER $SCRIPT: $1\033[0m"
    fi
fi
}


# Check if Syncthing is running
is_syncthing_running() {
    if /usr/sbin/pgrep -x "syncthing" > /dev/null; then
        echo "running"
        return 1
    else
        echo "not running"
        return 0
    fi
}

#Function to remove old release of syncthing present after update
clean_bin() {
# File to keep
GOOD_FILE="syncthing"

# Check if syncthing exists
if [ -e "$BIN_DIR/$GOOD_FILE" ]; then
    #echo "$GOOD_FILE found in $BIN_DIR."

    # Find and delete other files starting with syncthing
    /usr/bin/find "$BIN_DIR" -type f -name "${GOOD_FILE}*" ! -name "$GOOD_FILE" -exec /bin/rm -f {} \;
    #echo "All files starting with ${GOOD_FILE} but not ${GOOD_FILE} have been deleted."
else
    echo "$FILE_TO_KEEP not found in $BIN_DIR. No action taken."
fi
}

# Function to launch syncthing
launch_syncthing() {
    /usr/bin/sudo -u syncthing /usr/bin/syncthing --home=$HOME --gui-address=0.0.0.0:8384 & #launch syncthing as user sy# fix profile                                                                                                           # Check if the .profile file exists
if [ ! -f "$PROFILE_FILE" ]; then
    # Create the .profile file
    /bin/touch "$PROFILE_FILE"

    # Add the aliases to the .profile file
    /bin/grep -qxF 'alias ll="ls -l"' "$PROFILE_FILE" || echo 'alias ll="ls -l"' >> "$PROFILE_FILE"
    /bin/grep -qxF 'alias la="ls -la"' "$PROFILE_FILE" || echo 'alias la="ls -la"' >> "$PROFILE_FILE"

    source $PROFILE_PATH

    log_message "Created $PROFILE_FILE"
fi
# end fix profile
}

# Main script logic

clean_bin

is_syncthing_running
if [ $? -eq 1 ]; then
    log_message "syncthing server is already running, nothing to do"
else
    if [ ! -d "$HOME" ]; then
        /bin/mkdir -p "$HOME" #/created directory /mnt/HD/HD_a2/sync
        /bin/chown -R syncthing:share sync #/mnt/HD/HD_a2/sync assigned to user syncthing group share
        log_message "syncthing launched for the first time, new keys have been generated"
    else
        log_message "syncthing launched with the already available keys"
    fi
    launch_syncthing
fi


