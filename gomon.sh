#!/bin/bash

initial_run=true

start_server() {

    if [ "$initial_run" = false ]; then
        echo -e "\033[38;5;208mChanges made, restarting server...\033[0m"
    else
        figlet "Starting server ..." | lolcat
    fi

    pkill main
    sleep 2
    go run main.go &

    initial_run=false
}

start_server

while true; do
    inotifywait -r -e modify,create,delete,move ./ >> /dev/null 2>&1
    start_server
done

