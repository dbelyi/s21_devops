#!/bin/bash

# Включаем файл с функцией check_input
. ./check.sh
# Включаем файл с функциями print_system_info, ask_to_create_log и write_to_file
. ./print.sh

# В переменную check записываем результат работы функции check_input
check=$(check_input $#)

# Если user ввел аргументы, выводим сообщение об ошибке
if [[ $check -eq 1 ]]
    then
    echo "Error: wrong parameters"
else
    # Выводим информацию о системе
    print_system_info
    # В переменную check записываем результат работы функции ask_to_create_log
    check=$(ask_to_create_log)
    # Если ответ пользователя отрицательный, не сохраняем файл и выводим сообщение
    if [[ $check -eq 1 ]]
        then
        echo "No saving"
    else
        # Сохраняем информацию о системе в файл
        write_to_file
    fi
fi