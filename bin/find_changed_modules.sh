#!/bin/bash

# Store the hash of the previous commit
PREVIOUS_COMMIT=$(git rev-parse HEAD^)

# Store the hash of the current commit
CURRENT_COMMIT=$(git rev-parse HEAD)


# Use Git to show the changes between the previous and current commits
# and store the directories containing changed files in an array
CHANGED_DIRS=($(git diff --name-only $PREVIOUS_COMMIT $CURRENT_COMMIT | xargs -I{} dirname {} | sort | uniq))

MODULE_DIRS=('test_1','test_2')


# Output the array of directory names under the "modules" directory that have changed files
echo "${MODULE_DIRS[*]}" 