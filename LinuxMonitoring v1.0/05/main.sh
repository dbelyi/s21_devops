#!/bin/bash

. ./functions.sh

START_TIME=$(date +%s)
path=0
if [[ $# != 1  || ${1: -1} != "/" || !(-d $1) ]]; then
	echo "Parameters wrong"
	exit
else
    path=$1
fi

echo "Total number of folders (including all nested ones) = $(total_folders $path)"
echo "TOP 5 folders of maximum size arranged in descending order (path and size):"
top_5 $path
echo "Total number of files = $(total_files $path)"
echo "Number of:  
Configuration files (with the .conf extension) = `find $path -type f -name "*.conf" | wc -l`"
echo "Text files = `find $path -type f -name "*.txt" | wc -l`"
echo "Executable files = `find $path -type f -perm /a=x | wc -l`"
echo "Log files (with the extension .log) = `find $path -type f -name "*.log" | wc -l`"
echo "Archive files = `find $path -type f -name "*.zip" -o -name "*.7z" -o -name "*.ar" -o -name "*.gz" | wc -l`"
echo "Symbolic links = `find $path -type l | wc -l`"
echo "TOP 10 files of maximum size arranged in descending order (path, size and type):"
top_10_size $path
echo "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file)"
top_10_exe $path
END_TIME=$(date +%s)
difference=$(( $END_TIME - $START_TIME ))
echo "Script execution time (in seconds) = $difference"