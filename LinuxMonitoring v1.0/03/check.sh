#!/bin/bash

function check_input {
    count=$1
    shift

    if [[ $count -ne 4 ]]
    then
        echo 1
    else
        for var in $@
        do
            if [[ !$var =~ ^([1-6])$ ]]; then
            echo 1
            exit
            fi
        done
        if [[ $1 -eq $2 || $3 -eq $4 ]]
        then
           echo 3
        else
           echo 0
        fi
    fi
}