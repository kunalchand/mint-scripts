#!/bin/bash

# Set the script to exit immediately if any command fails
set -e

cd /home/kunalchand/Desktop/Projects/Others/Random/p

# Initialize the maximum file index to 0
max_index=0

# Loop through files that match the pattern "test_*.py"
for file in test_*.py; do
  # Check if the file name matches the expected pattern
  if [[ $file =~ test_([0-9]+)\.py ]]; then
    # Extract the number from the file name and compare it to max_index
    index="${BASH_REMATCH[1]}"
    if (( index > max_index )); then
      max_index=$index
    fi
  fi
done

# Increment the maximum index by 1 for the new file
let new_index=max_index+1

# Create a new file with the incremented index
new_file_name="test_${new_index}.py"
touch "$new_file_name"

# Open VSCode with the current directory and focus on the new file
code -r . "$new_file_name"

# Get the PID of the terminal
TERMINAL_PID=$(ps -o ppid= -p $$)

# Close the terminal
kill -9 "$TERMINAL_PID"
