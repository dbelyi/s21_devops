#!/bin/bash

# Compiles the server.c file and links the FastCGI library
gcc server.c -lfcgi -o server
# Starts a FastCGI process on port 8080 using the compiled server binary
spawn-fcgi -p 8080 ./server
service nginx start

# Creates a loop that waits for the processes to exit
while true; do
    wait
done

/bin/bash
