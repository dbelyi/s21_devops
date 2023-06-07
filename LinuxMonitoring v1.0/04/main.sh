#!/bin/bash

. ./functions.sh

# check_input

check=$(check_input)
declare -a arr
arr=($check)

if [[ ${#arr[@]} -eq 1 ]]; then
    if [[ $check -eq 0 ]]; then
    echo "Wrong parameters, change them in file"
    elif [[ $check -eq 3 ]]; then
    echo "Backgroung and text cannot be of same colour, change file"
    fi
else
    system_paint ${arr[@]}
fi