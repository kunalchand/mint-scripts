#!/bin/bash

# Set the script to exit immediately if any command fails
set -e

# Define an associative array to map commands to websites
declare -A COMMAND_TO_WEBSITE
COMMAND_TO_WEBSITE["gpt"]="https://chat.openai.com/"
COMMAND_TO_WEBSITE["phind"]="https://www.phind.com/"
COMMAND_TO_WEBSITE["google"]="https://www.google.com/"
COMMAND_TO_WEBSITE["roadmap"]="https://neetcode.io/roadmap"
COMMAND_TO_WEBSITE["leetcodenotes"]="https://docs.google.com/spreadsheets/d/14xdtVdBHRXI2thUCdcIiq0E-C1gLPzHMGUZl31hw6gc/edit#gid=1336779853"
COMMAND_TO_WEBSITE["javanotes"]="https://docs.google.com/document/d/1JSchYJH05EUrNvdm1mI50um1R79Pi9bkoH9SmEWy_b8/edit#heading=h.pvt1ihed3m2z"
COMMAND_TO_WEBSITE["whatsapp"]="https://web.whatsapp.com/"
COMMAND_TO_WEBSITE["youtube"]="https://www.youtube.com/channel/UCOnFr4jtlNNwHk5ERjsJ54Q/playlists?view=1&sort=lad"
COMMAND_TO_WEBSITE["gmail"]="https://mail.google.com/mail/u/0/#inbox"
COMMAND_TO_WEBSITE["tracker"]="https://docs.google.com/spreadsheets/d/1G4kL5vfjjpOjM6wQHF3YPOZsD1FGpF0v9oAscTS7Ky4/edit#gid=625126536"
COMMAND_TO_WEBSITE["portfolio"]="https://kunalchand.github.io/portfolio/"
COMMAND_TO_WEBSITE["linkedin"]="https://www.linkedin.com/in/kunal-chand/"
COMMAND_TO_WEBSITE["github"]="https://github.com/kunalchand"
COMMAND_TO_WEBSITE["leetcode"]="https://leetcode.com/kunalchand234/"
COMMAND_TO_WEBSITE["music"]="https://music.youtube.com/"
COMMAND_TO_WEBSITE["ubmail"]="https://outlook.office.com/mail/"

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

