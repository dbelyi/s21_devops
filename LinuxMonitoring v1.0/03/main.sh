#!/bin/bash

# Включаем файл с функцией print_system_info
. ./print.sh
# Включаем файл с функцией check_input
. ./check.sh

# В переменную check записываем результат работы функции check_input
check=$(check_input $# $@)

# Объявляем переменную answer как массив (-a)
declare -a answer
flag=0

# Пока пользователь не введет корректные параметры, запрашиваем ввод и выводим сообщения о ошибках
while [[ $check -ne 0 ]]
do
    flag=1
    if [[ $check -eq 3 ]]
    then
        echo -n "Background and text can't be of same color, try again: "
    else
        echo -n "Wrong parameters, try again: "
    fi

    read -a answer
    # ${#answer[@]} — количество элементов в массиве
    # ${answer[@]} — все элемнты массива
    check=$(check_input ${#answer[@]} ${answer[@]})
done

# Если пользователь ввел корректные параметры, выводим информацию о системе
if [[ $flag -eq 1 ]]
then
    print_system_info ${answer[@]}
else
    # $@ используется для раскрытия всех аргументов командной строки и передачи их в качества массива
    print_system_info $@
fi
