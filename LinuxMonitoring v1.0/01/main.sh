#!/bin/bash

# Включаем файл с функцией check
. ./check.sh

# Проверяем, что скрипт был вызван с одним параметром
if [ $# -ne 1 ]; then
    echo "Usage: $0 <parameter>"
    exit 1
fi

# Проверяем параметр с помощью функции check
check $1

# Выводим значение параметра
echo "Parameter: $1"
