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

# Get the command that was passed as a parameter to the script
COMMAND=$1

# Check if the command is "list"
if [[ "$COMMAND" == "list" ]]; then
 # If the command is "list", print the list of commands and their respective website links
 for COMMAND in "${!COMMAND_TO_WEBSITE[@]}"; do
   echo "$COMMAND: ${COMMAND_TO_WEBSITE[$COMMAND]}"
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

