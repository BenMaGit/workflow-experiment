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


# Output the array of directory names under the "modules" directory that have changed files
echo "modules=${MODULE_DIRS}"