#!/bin/bash

# Проверяем является ли параметр числом
check() {
    if [ "$1" -eq "$1" ] 2>/dev/null; then
        echo "Error: parameter must be a text"
        exit 1
    fi
}
