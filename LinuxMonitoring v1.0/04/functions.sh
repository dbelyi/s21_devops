#!/bin/bash

# Определяет, соответствует ли содержимое файла test1 заданным требованиям, и возвращает определенное значение в зависимости от того, прошел ли файл проверку.
function check_input {
    # lines устанавливаем равным количеству строк в файле test1
    lines="`wc -l test1 | awk '{print $1}'`"
    front1=0
    front1_col=0
    front2=0
    front2_col=0
    back1=0
    back1_col=0
    back2=0
    back2_col=0

    # Содержит ли файл test1 более 4 строк? Если да, то возвращаем 0 и завершает выполнение
    if [[ $lines -gt 4 ]]
        then
        echo 0
        exit
    else
        # Открываем файл test1 и начинаем читать его содержимое построчно
        # В каждой строке ищем соответствие с определенными регулярными выражениями, которые определяют наличие заданных параметров для разных столбцов.
        # Если скрипт находит соответствие, он увеличивает соответствующий счетчик и сохраняет значение цвета.
        exec 0< test1
        while read line
        do
            if [[ $line =~ ^(column1_background=) ]]; then
                let "back1+=1"
                back1_col=${line: -2}
            fi
            if [[ $line =~ ^(column1_font_color=) ]]; then
                let "front1+=1"
                front1_col=${line: -2}
            fi
            if [[ $line =~ ^(column2_background=) ]]; then
                let "back2+=1"
                back2_col=${line: -2}
            fi
            if [[ $line =~ ^(column2_font_color=) ]]; then
                let "front2+=1"
                front2_col=${line: -2}
            fi
        done

        # Суммируем значения счетчиков и проверяем, равна ли эта сумма количеству строк в файле
        sum=$(( $front1 + $back1 + $front2 + $back2 ))
        if [[ $sum -ne $lines ]]; then
            echo 0
            exit
        fi

        # Проверяем, не превышает ли количество параметров заданных значений в каждом из столбцов единицу
        if [[ $front1 -gt 1 || $back1 -gt 1 || $front2 -gt 1 || $back2 -gt 1 ]]
        then
            echo 0
            exit
        fi

        # Вызываем функцию check_colour, передавая ей значения цветов, которые были сохранены в переменных
        # Если функция check_colour возвращает значение отличное от 1, скрипт возвращает это значение и завершает выполнение
        # Если функция check_colour возвращает 1, скрипт выводит значения цветов и завершает выполнение
        back_front_check=$(check_colour $front1_col $back1_col $front2_col $back2_col)
        if [[ $back_front_check -ne 1 ]]; then
            echo $back_front_check
            exit
        fi 
    fi

    echo "${front1_col: -1} ${back1_col: -1} ${front2_col: -1} ${back2_col: -1}"
}

# Принимает несколько аргументов и проверяет, соответствуют ли они заданным условиям цветовых кодов
function check_colour {
    # Используем цикл for для итерации по переданным аргументам
    for var in $@
    do
        # Если символ в позиции $i не равен = и значение переменной не равно 0, функция выводит 0 и завершает свою работу
        if [[ ${var:$i:1} != "=" && $var -ne 0 ]]; then
            echo 0
            exit
        # Если последний символ в значении переменной не является цифрой от 1 до 6 и значение переменной не равно 0, функция выводит 0 и завершает свою работу
        elif [[ (! ${var: -1} =~ ^([1-6])$) && $var -ne 0 ]]; then
            echo 0
            exit
        fi
    done

    # Если все аргументы проходят проверки, функция сравнивает последние цифры первых двух аргументов и последние цифры последних двух аргументов
    # Если две последние цифры совпадают и не равны 0, функция выводит 3, в противном случае 1
    if [[ (${1: -1} -eq ${2: -1} && ${1: -1} -ne 0) ||
         (${3: -1} -eq ${4: -1}  && ${3: -1}  -ne 0) ]]; then
        echo 3
    else
        echo 1
    fi
}

# Принимаем четыре параметра $1, $2, $3 и $4. Проверяем параметры на их соответствие определенным условиям и используем их для
# установки цветов переднего и заднего плана для двух колонок в терминале
function system_paint {
    # Массив colours, содержащий коды цветов ANSI для шести различных цветов
    colours=(37 91 32 96 95 30)
    # Массив output, содержащий строковые значения этих цветов
    output=(white red green blue purple black)
    # Присваиваем значения переданных параметров в переменные check_front1, check_back1, check_front2 и check_back2
    check_front1=$1
    check_back1=$2
    check_front2=$3
    check_back2=$4

    # Проверяем каждый из параметров и, если он равен 0, устанавливает значение по умолчанию или вычисляем значение на основе другого параметра
    # Например, если $1 равен 0, то функция проверит $2. Если $2 также равен 0, то функция установит $check_front1 равным 1 (белый) и $check_back1 равным 2 (красный)
    # В противном случае функция установит $check_front1 равным остатку от $2 при делении на 6 плюс 1 (чтобы получить один из шести цветов из массива colours), а $check_back1 будет равен $2
    if [[ $1 -eq 0 ]]; then
        if [[ $2 -eq 0 ]]; then
            check_front1=1
            check_back1=2
        else
            check_front1=$(( $2 % 6 + 1 ))
            check_back1=$2
        fi
    fi

    if [[ $2 -eq 0 && $check_back1 -eq 0 ]]; then
        check_front1=$1
        check_back1=$(( $1 % 6 + 1 ))
    fi

    if [[ $3 -eq 0 ]]; then
        if [[ $4 -eq 0 ]]; then
            check_front2=3
            check_back2=4
        else
            check_front2=$(( $4 % 6 + 1 ))
            check_back2=$4
        fi
    fi

    if [[ $4 -eq 0 && $check_back2 -eq 0 ]]; then
        check_front2=$3
        check_back2=$(( $3 % 6 + 1 ))
    fi

    # Вычисляем код для переднего и заднего плана для каждой колонки, используя значения $check_front1, $check_back1, $check_front2 и $check_back2,
    # и сохраняем их в переменные front1, back1, front2 и back2
    front1=${colours[$check_front1 - 1]}
    back1=$(( ${colours[$check_back1 - 1]} + 10 ))
    first="\033[${front1}m\033[${back1}m"

    front2=${colours[$check_front2 - 1]}
    back2=$(( ${colours[$check_back2 - 1]} + 10 ))
    sec="\033[${front2}m\033[${back2}m"
    reset="\033[0m"

    # Используем эти коды для установки цвета переднего и заднего плана для двух колонок в терминале
    paint $first $sec $reset

    # Выводим сообщения о том, какие цвета были установлены для каждой колонки, используя значения в массивах
    # output и $check_front1, $check_back1, $check_front2 и $check_back2.
    if [[ $2 -eq 0 ]]; then
        echo "Column 1 background = default (${output[$check_back1 - 1]})"
    else
        echo "Column 1 background = $check_back1 (${output[$check_back1 - 1]})"
    fi

    if [[ $1 -eq 0 ]]; then
        echo "Column 1 font color = default (${output[$check_front1 - 1]})"
    else
        echo "Column 1 font color = $check_front1 (${output[$check_front1 - 1]})"
    fi

    if [[ $4 -eq 0 ]]; then
        echo "Column 2 background = default (${output[$check_back2 - 1]})"
    else
        echo "Column 2 background = $check_back2 (${output[$check_back2 - 1]})"
    fi

    if [[ $3 -eq 0 ]]; then
        echo "Column 2 font color = default (${output[$check_front2 - 1]})"
    else
        echo "Column 2 font color = $check_front2 (${output[$check_front2 - 1]})"
    fi
}

function paint {
    echo -en '\n'
    printf "${1}HOSTNAME${3} = ${2}$(hostname)${3}\n"
    printf "${1}TIMEZONE${3} = ${2}$(cat /etc/timezone) $(date +"%:::z")${3}\n"
    printf "${1}USER${3} = ${2}$(whoami)${3}\n"
    printf "${1}OS${3} = ${2}$(lsb_release -d | awk -F"\t" '{print $2}')${3}\n"
    printf "${1}DATE${3} = ${2}$(date +"%d %b %Y %T")${3}\n"
    printf "${1}UPTIME${3} = ${2}$(uptime -p)${3}\n"
    printf "${1}UPTIME_2${3} = ${2}$(cat /proc/uptime | awk '{print $1}')${3}\n"
    printf "${1}IP${3} = ${2}$(hostname -I | awk '{print $1}')${3}\n"
    printf "${1}MASK${3} = ${2}$(ifconfig | grep -m1 inet | awk '{print $4}')${3}\n"
    printf "${1}GATEWAY${3} = ${2}$(ip r | grep default | awk '{print $3}')${3}\n"
    printf "${1}RAM TOTAL${3} = ${2}$(free -m | awk 'NR==2{printf "%.3f GB\n", $2/1024}')${3}\n"
    printf "${1}RAM USED${3} = ${2}$(free -m | awk 'NR==2{printf "%.3f GB\n", $3/1024}')${3}\n"
    printf "${1}RAM FREE${3} = ${2}$(free -m | awk 'NR==2{printf "%.3f GB\n", $4/1024}')${3}\n"
    printf "${1}SPACE_ROOT${3} = ${2}$(df -k /root | tail -n1 | awk '{printf "%.2f", ($2 / 1024.0)}') MB${3}\n"
    printf "${1}SPACE_ROOT_USED${3} = ${2}$(df -k /root | tail -n1 | awk '{printf "%.2f", ($3 / 1024.0)}') MB${3}\n"
    printf "${1}SPACE_ROOT_FREE${3} = ${2}$(df -k /root | tail -n1 | awk '{printf "%.2f", ($4 / 1024.0)}') MB${3}\n"
    echo -en '\n'
}