#!/bin/bash

FA="$1"

# Save the pwd before we run anything
PRE_PWD=`pwd`

# Determine the build script's actual directory, following symlinks
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ] ; do SOURCE="$(readlink "$SOURCE")"; done
BUILD_DIR="$(cd -P "$(dirname "$SOURCE")" && pwd)"


# Derive the project name from the directory
PROJECT="$(basename $BUILD_DIR)"

# Build the project
cd $BUILD_DIR
rm -rf bin
mkdir -p bin
if [ "$FA" != "-t" ];
then
    OUTPUT=$PROJECT
    export GOOS=linux
else
    OUTPUT="$PROJECT"_test_mac_os
fi
go get ./...
go build -o bin/$OUTPUT $PROJECT/main

EXIT_STATUS=$?

if [ $EXIT_STATUS == 0 ]; then
  echo "Build succeeded"
else
  echo "Build failed"
fi

# Change back to where we were
cd $PRE_PWD

exit $EXIT_STATUS