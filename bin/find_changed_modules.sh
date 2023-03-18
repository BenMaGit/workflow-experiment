#!/bin/bash

# Store the hash of the previous commit
PREVIOUS_COMMIT=$(git rev-parse HEAD^)

# Store the hash of the current commit
CURRENT_COMMIT=$(git rev-parse HEAD)


# Output the hashes of the previous and current commits for reference
echo "Previous commit hash: $PREVIOUS_COMMIT"
echo "Current commit hash: $CURRENT_COMMIT"

# Use Git to show the changes between the previous and current commits
# and store the directories containing changed files in an array
CHANGED_DIRS=($(git diff --name-only $PREVIOUS_COMMIT $CURRENT_COMMIT | xargs -I{} dirname {} | sort | uniq))

MODULE_DIRS=('test_1','test_2')
# Loop through the array of changed directories and check if any of them are subdirectories of the "modules" directory
'for DIR in "${CHANGED_DIRS[@]}"
do
    if [[ "$DIR" == "modules/"* && $(echo "$DIR" | tr -cd '/' | wc -c) -eq 2 ]]; then
        # Get the name of the subdirectory under "modules"
        DIR_NAME=$(echo "$DIR" | cut -d'/' -f2)

        # Add the name of the subdirectory to the MODULE_DIRS array
        MODULE_DIRS+=("$DIR_NAME")
    fi
done'

# Output the array of directory names under the "modules" directory that have changed files
echo "modules=${MODULE_DIRS}" >> $GITHUB_OUTPUT