#!/bin/bash

function print_system_info {
    echo "HOSTNAME = $(hostname)"
    echo "TIMEZONE = $(cat /etc/timezone) $(date +"%:::z")"
    echo "USER = $(whoami)"
    echo "OS = $(lsb_release -d | awk -F"\t" '{print $2}')"
    echo "DATE = $(date +"%d %b %Y %T")"
    echo "UPTIME = $(uptime -p)"
    echo "UPTIME_SEC = $(cat /proc/uptime | awk '{print $1}')"
    echo "IP = $(hostname -I | awk '{print $1}')"
    echo "MASK = $(ifconfig | grep -m1 inet | awk '{print $4}')"
    echo "GATEWAY = $(ip r | grep default | awk '{print $3}')"
    echo "RAM TOTAL = $(free -m | awk 'NR==2{printf "%.3f GB\n", $2/1024}')"
    echo "RAM USED = $(free -m | awk 'NR==2{printf "%.3f GB\n", $3/1024}')"
    echo "RAM FREE = $(free -m | awk 'NR==2{printf "%.3f GB\n", $4/1024}')"
    echo "SPACE_ROOT = $(df -k /root | tail -n1 | awk '{printf "%.2f", ($2 / 1024.0)}') MB"
    echo "SPACE_ROOT_USED = $(df -k /root | tail -n1 | awk '{printf "%.2f", ($3 / 1024.0)}') MB"
    echo "SPACE_ROOT_FREE = $(df -k /root | tail -n1 | awk '{printf "%.2f", ($4 / 1024.0)}') MB"
}

function ask_to_create_log {
    result=0
    read -p "Do you want to save it in file? Y/N: " answer

    if [[ "$answer" != "Y" && "$answer" != "y" ]]
    then
        result=1
    fi
    echo $result
}

function write_to_file {
    filename="`date +%d_%m_%y_%H_%M_%S`.status"
    touch $filename
    # Задаем разделителем полей \n
    IFS=$'\n'

    for var in $(print_system_info)
    do
       echo $var >> $filename
    done

    echo -en '\n'
    echo "File is in the current directory"
}