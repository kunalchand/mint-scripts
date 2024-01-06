#!/bin/bash

# Set the script to exit immediately if any command fails
set -e

# Get the directory of the current script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Define an associative array to map commands to websites
declare -A COMMAND_TO_WEBSITE

# Read the commands.txt file and populate the associative array
while IFS=':' read -r command url
do
   COMMAND_TO_WEBSITE["$command"]="$url"
done < "$SCRIPT_DIR/commands.txt"

if [ -z "$1" ]; then
    # If no parameter is passed, open Google Chrome
    setsid google-chrome > /dev/null 2>&1 &
    
    # Get the PID of the terminal
    TERMINAL_PID=$(ps -o ppid= -p $$)

    # Close the terminal
    kill -9 "$TERMINAL_PID"
else
    # Get the command that was passed as a parameter to the script
    COMMAND=$1

    # Check if the command is "list"
    if [[ "$COMMAND" == "list" ]]; then
        # If the command is "list", print the list of commands and their respective website links
        for COMMAND in "${!COMMAND_TO_WEBSITE[@]}"; do
            # ANSI escape codes for text formatting
            BOLD=$(tput bold)
            RESET=$(tput sgr0)
            COLOR_COMMAND=$(tput setaf 6)  # Set color to cyan, you can change this to another color
            echo "${BOLD}${COLOR_COMMAND}$COMMAND${RESET}: ${COMMAND_TO_WEBSITE[$COMMAND]}"
        done
    else
        # If the command is not "list", use the associative array to determine the website
        WEBSITE=${COMMAND_TO_WEBSITE[$COMMAND]}

        # Launch browser in the background
        setsid google-chrome $WEBSITE > /dev/null 2>&1 &

        # Get the PID of the terminal
        TERMINAL_PID=$(ps -o ppid= -p $$)

        # Close the terminal
        kill -9 "$TERMINAL_PID"
    fi
fi

