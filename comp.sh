#!/bin/bash

# File to modify
FILE="syncthing/apkg.rc"

# Function to increment the minor version
increment_minor_version() {
    local version=$1
    local major=$(echo $version | cut -d '.' -f 1)
    local minor=$(echo $version | cut -d '.' -f 2)
    
    new_minor=$((minor + 1))
    
    echo "$major.$new_minor"
}

# Read the file line by line
while IFS= read -r line
do
    if [[ $line == Version:* ]]; then
        current_version=$(echo $line | cut -d ' ' -f 2)
        new_version=$(increment_minor_version $current_version)
        echo "Version: $new_version"
    else
        echo "$line"
    fi
done < "$FILE" > temp_file && mv temp_file "$FILE"

echo "Version updated successfully."




cd syncthing
../MyCloudOS5_mksapkg -E -s -m WDMyCloud
cd ..





