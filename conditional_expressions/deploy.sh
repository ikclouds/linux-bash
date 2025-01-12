#!/bin/bash

# deploy.sh
# v1.0.0

# Deploy conditional expressions library into the user's ~/bin folder

cp ./conditional_expressions_lib.sh ~/bin/
cp ./conditional_expressions_lib_test.sh ~/bin/
[ -L ~/bin/cel ] && unlink ~/bin/cel
[ -L ~/bin/celt ] && unlink ~/bin/celt
ln -s ~/bin/conditional_expressions_lib.sh ~/bin/cel
ln -s ~/bin/conditional_expressions_lib_test.sh ~/bin/celt

# shellcheck source=/dev/null
. ~/bin/cel -c
# shellcheck source=/dev/null
. ~/bin/cel
