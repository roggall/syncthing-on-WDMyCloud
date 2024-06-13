#!/bin/sh


if [ -z "$1" ]; then
    echo "Usage: $0 <path>"
    exit 1
fi


PATH=$1

# Log file path
LOG_FILE="$PATH/log"

# Get the current date and time
DATA=$(date '+%Y-%m-%d %H:%M:%S')

# Read the content of the verbose file
VERBOSE="$PATH/verbose"

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

#create link
/bin/ln -s $PATH/bin/syncthing /usr/bin/syncthing
# crea una directory simbolica chiamata /usr/bin/syncthing
# uguale a /mnt/HD/HD_a2/Nas_Prog/sbin/syncthing

log_message "/usr/bin/syncthing link created"


/bin/ln -s $PATH/www /var/www/syncthing

log_message "/var/www/syncthing link created"

#cmd on pre-install
idx=0
while [ $idx -lt 7 ]; do
    mknod /dev/ptyp$idx c 2 $idx 2>/dev/null
    mknod /dev/ttyp$idx c 3 $idx 2>/dev/null
    idx=`expr $idx + 1`
done

#touch $PATH/verbose


log_message " has been launched"





