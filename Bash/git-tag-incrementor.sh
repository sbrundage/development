#!/bin/bash

# This script will read in a tag in the form of X.X.X
# Where X can be a number from 0-99
# We will separate each number using a deliminator '.'
# Then increment each number by 1
# Join each incremented number using awk
# Return the newly formed git tag

# Read in git tag
read -p 'Enter the git tag to increment: ' GIT_TAG

echo "Git tag you entered: ${GIT_TAG}"

echo 'Separating git tag by '.' deliminator'

# Separate each tag section using '.' deliminator
TAG_FIRST=$(cut -d '.' -f 1 <<< $GIT_TAG)
TAG_SECOND=$(cut -d '.' -f 2 <<< $GIT_TAG)
TAG_THIRD=$(cut -d '.' -f 3 <<< $GIT_TAG)

echo $TAG_FIRST
echo $TAG_SECOND
echo $TAG_THIRD

TAG_FIRST=$((TAG_FIRST+1))
TAG_SECOND=$((TAG_SECOND+1))
TAG_THIRD=$((TAG_THIRD+1))

echo
echo 'Incremented Tag:'

# Need to check to make sure the new incremented tag doesn't roll over

# Use awk to join the tag back together

echo "$TAG_FIRST $TAG_SECOND $TAG_THIRD" | awk -F ' ' -v OFS='.' '{print $1,$2,$3}'
