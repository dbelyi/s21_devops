#!/bin/bash

function print_system_info {
    colors=(97 91 32 96 95 30)
    # Получаем значение цветового кода из массива colors с помощью переменной $2, которая содержит порядковый номер цвета для фона названий значений
    # Операция -1 вычитает единицу, чтобы получить индекс массива, который начинается с 0
    front1=${colors[$2 - 1]}
    # Получаем значение цветового кода из массива colors с помощью переменной $1, которая содержит порядковый номер цвета для шрифта названий значений
    # Операция -1 вычитает единицу, чтобы получить индекс массива, который начинается с 0
    # Затем к этому значению добавляется 10, чтобы получить код цвета фона
    back1=$(( ${colors[$1 - 1]} + 10 ))
    # Формируем строку, которая содержит управляющие символы ANSI, указывающие на цвет переднего плана и фона, полученные из переменных front1 и back1 соответственно
    first="\033[${front1}m\033[${back1}m"

    # $4 содержит порядковый номер цвета для фона значений (после знака '=')
    front2=${colors[$4 - 1]}
    # $3 содержит порядковый номер цвета для шрифта значений (после знака '=')
    back2=$(( ${colors[$3 - 1]} + 10 ))
    sec="\033[${front2}m\033[${back2}m"
    reset="\033[0m"

    printf "${first}HOSTNAME${reset} = ${sec}$(hostname)${reset}\n"
    printf "${first}TIMEZONE${reset} = ${sec}$(cat /etc/timezone) $(date +"%:::z")${reset}\n"
    printf "${first}USER${reset} = ${sec}$(whoami)${reset}\n"
    printf "${first}OS${reset} = ${sec}$(lsb_release -d | awk -F"\t" '{print $2}')${reset}\n"
    printf "${first}DATE${reset} = ${sec}$(date +"%d %b %Y %T")${reset}\n"
    printf "${first}UPTIME${reset} = ${sec}$(uptime -p)${reset}\n"
    printf "${first}UPTIME_SEC${reset} = ${sec}$(cat /proc/uptime | awk '{print $1}')${reset}\n"
    printf "${first}IP${reset} = ${sec}$(hostname -I | awk '{print $1}')${reset}\n"
    printf "${first}MASK${reset} = ${sec}$(ifconfig | grep -m1 inet | awk '{print $4}')${reset}\n"
    printf "${first}GATEWAY${reset} = ${sec}$(ip r | grep default | awk '{print $3}')${reset}\n"
    printf "${first}RAM TOTAL${reset} = ${sec}$(free -m | awk 'NR==2{printf "%.3f GB\n", $2/1024}')${reset}\n"
    printf "${first}RAM USED${reset} = ${sec}$(free -m | awk 'NR==2{printf "%.3f GB\n", $3/1024}')${reset}\n"
    printf "${first}RAM FREE${reset} = ${sec}$(free -m | awk 'NR==2{printf "%.3f GB\n", $4/1024}')${reset}\n"
    printf "${first}SPACE_ROOT${reset} = ${sec}$(df -k /root | tail -n1 | awk '{printf "%.2f", ($2 / 1024.0)}') MB${reset}\n"
    printf "${first}SPACE_ROOT_USED${reset} = ${sec}$(df -k /root | tail -n1 | awk '{printf "%.2f", ($3 / 1024.0)}') MB${reset}\n"
    printf "${first}SPACE_ROOT_FREE${reset} = ${sec}$(df -k /root | tail -n1 | awk '{printf "%.2f", ($4 / 1024.0)}') MB${reset}\n"
}
