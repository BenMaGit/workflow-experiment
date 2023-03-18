#!/bin/bash

# Store the hash of the previous commit
PREVIOUS_COMMIT=$(git rev-parse HEAD^)

# Store the hash of the current commit
CURRENT_COMMIT=$(git rev-parse HEAD)


# Use Git to show the changes between the previous and current commits
# and store the directories containing changed files in an array
CHANGED_DIRS=($(git diff --name-only $PREVIOUS_COMMIT $CURRENT_COMMIT | xargs -I{} dirname {} | sort | uniq))

MODULE_DIRS=()
# Loop through the array of changed directories and check if any of them are subdirectories of the "modules" directory
for DIR in "${CHANGED_DIRS[@]}"
do
    if [[ "$DIR" == "modules/"* && $(echo "$DIR" | tr -cd '/' | wc -c) -gt 0 ]]; then
        # Get the name of the subdirectory under "modules"
        DIR_NAME=$(echo "$DIR" | cut -d'/' -f2)
      
        # Add the name of the subdirectory to the MODULE_DIRS array
        MODULE_DIRS+=("$DIR_NAME")
    fi
done

# Output the array of directory names under the "modules" directory that have changed files
echo "${MODULE_DIRS[@]}"