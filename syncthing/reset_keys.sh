#!/bin/sh

# Check if a path is provided as an argument
if [ -z "$1" ]; then
    echo "Usage: $0 <base_path>"
    exit 1
fi

# Define the path to be used
TARGET_PATH="$1"
SYNC_DIR="$(dirname "$TARGET_PATH")/sync"

# Define color codes
BOLD_YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Confirm the action with the user
echo -e "${BOLD_YELLOW}WARNING:${NC}"
echo -e "${BOLD_YELLOW}This script will reset the keys, all your connected devices will stop to syncronize!${NC}"
echo -e "${BOLD_YELLOW}This action is not recoverable.${NC}"
echo -e "${BOLD_YELLOW}Are you sure to proceed?${NC}"
echo ""
echo -e "${BOLD_YELLOW}Before erasing the keys you could take a copy of the current${NC}"
echo -e "$SYNC_DIR ${BOLD_YELLOW}for future usage,${NC}"
echo -e "${BOLD_YELLOW}you have to do it manually, before resetting the keys.${NC}"
echo -e "${BOLD_YELLOW}Restoring the keys saved in sync is the unique way to restore the current keys.${NC}"
echo ""
echo -e "${BOLD_YELLOW}Please enter [Y/n] in order to proceed with the keys reset${NC}"

# Read the user's response
read -r response

# Check the user's response
if [ "$response" = "Y" ] || [ "$response" = "y" ]; then
    # Kill all syncthing processes
    /usr/bin/killall syncthing

    # Remove the directory
    /bin/rm -rf "$SYNC_DIR"

    echo "Keys have been reset and the directory has been removed."
else
    echo "Keys are still available."
fi


