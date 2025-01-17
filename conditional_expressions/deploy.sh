#!/bin/bash

# deploy.sh
# v1.0.1
# Changes:
#   run comments added

# Deploy conditional expressions library into the user's ~/bin folder

# Run:
#   ./deploy.sh
#   ./deploy.sh; cel -l -v
#   ./deploy.sh; celt -ut

# Prerequisites:
#   echo "$PATH" | grep -o "\/home\/$USER\/bin"
#   vi ~/.profile


cp ./conditional_expressions_lib.sh ~/bin/
cp ./conditional_expressions_lib_test.sh ~/bin/
[ -L ~/bin/cel ] && rm ~/bin/cel
[ -L ~/bin/celt ] && unlink ~/bin/celt
ln -s ~/bin/conditional_expressions_lib.sh ~/bin/cel
ln -s ~/bin/conditional_expressions_lib_test.sh ~/bin/celt

# shellcheck source=/dev/null
. ~/bin/cel -c
# shellcheck source=/dev/null
. ~/bin/cel
