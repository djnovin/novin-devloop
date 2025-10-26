#!/bin/zsh

SCRIPT_DIR="${0:A:h}"

for script in $SCRIPT_DIR/scripts/*.zsh; do
    zsh "${script}"
done
