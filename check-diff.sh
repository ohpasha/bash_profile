#!/bin/bash
type=$1
currentCommitHash=$(git rev-parse HEAD)
beforeCommitHash=$(git rev-parse @~)
isChanged=false
echo "check $type docker build"
echo "current hash commit: $currentCommitHash"
echo "hash commit before: $beforeCommitHash"

changedFiles=$(git diff $currentCommitHash $beforeCommitHash --name-only)
changedStr=$(echo $changedFiles | grep -oh "$type/[0-9a-zA-Z_/.]\+" || true)

if [ ! -z "$changedStr" -a "$changedStr" != " " ]; then
    isChanged=true
    echo "Need to build new image of $type type"
else
    echo "There are no changes in $type type"
fi
