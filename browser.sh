#!/bin/bash

# Set the script to exit immediately if any command fails
set -e

# Launch browser in the background
setsid google-chrome https://chat.openai.com/ > /dev/null 2>&1 &

# Get the PID of the terminal
TERMINAL_PID=$(ps -o ppid= -p $$)

# Close the terminal
kill -9 "$TERMINAL_PID"