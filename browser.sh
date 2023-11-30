#!/bin/bash

# Set the script to exit immediately if any command fails
set -e

# Define the default website
DEFAULT_WEBSITE="https://chat.openai.com/"

# Check if a parameter was passed to the script
if [ -z "$1" ]
then
 # If no parameter was passed, open the default website
 WEBSITE=$DEFAULT_WEBSITE
else
 # If a parameter was passed, use it to determine the website
 case $1 in
   "phind")
     WEBSITE="https://www.phind.com/"
     ;;
   "google")
     WEBSITE="https://www.google.com/"
     ;;
   "roadmap")
     WEBSITE="https://neetcode.io/roadmap"
     ;;
   *)
     WEBSITE=$DEFAULT_WEBSITE
     ;;
 esac
fi

# Launch browser in the background
setsid google-chrome $WEBSITE > /dev/null 2>&1 &

# Get the PID of the terminal
TERMINAL_PID=$(ps -o ppid= -p $$)

# Close the terminal
kill -9 "$TERMINAL_PID"