#!/bin/bash

# Set the script to exit immediately if any command fails
set -e

redshift -x
redshift -O 3800

# Get the PID of the terminal
TERMINAL_PID=$(ps -o ppid= -p $$)

# Close the terminal
kill -9 "$TERMINAL_PID"