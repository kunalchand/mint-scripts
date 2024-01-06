#!/bin/bash

read -p "Enter command name: " command
read -p "Enter URL: " url

echo -e "\033[33m$command: $url\033[0m"

echo "Confirm? (y/n)"
read confirmation

git_push=false

if [ "$confirmation" = "y" ]; then
 # Get the directory of the current script
 SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

 # Initialize the boolean variable
 command_updated=false

 while IFS= read -r line
 do
     if [[ $line == *":"* ]]; then
         cmd=${line%%:*}
         if [ "$cmd" = "$command" ]; then
             url=${line#*:}
             echo -e "Existing Command: \033[36m$cmd: $url\033[0m"
             echo "Sure wanna update existing command? (y/n)"
             read -r confirmation < /dev/tty
             if [ "$confirmation" = "y" ]; then
              sed -i "/^$cmd:/c\\$command: $url" "$SCRIPT_DIR/commands.txt"
              echo "Command updated!"
              command_updated=true
              git_push=true
              break
             else
              command_updated=true # To NOT duplicate the command
              echo "Command updation aborted!"
              break
             fi
         fi
     fi
 done < "$SCRIPT_DIR/commands.txt"

  # Check if the command was updated
  if [ "$command_updated" = false ]; then
    # Count the number of lines in the file
    num_lines=$(wc -l < "$SCRIPT_DIR/commands.txt")
    # Count the number of newline characters in the file
    num_newlines=$(grep -c $'\n' "$SCRIPT_DIR/commands.txt")
    # If the number of lines is equal to the number of newline characters, the file ends with a newline
    if [ "$num_lines" -eq "$num_newlines" ]; then
      # The file ends with a newline, no need to append another
      echo "$command: $url" >> "$SCRIPT_DIR/commands.txt"
    else
      # The file does not end with a newline, append one before the command
      echo "" >> "$SCRIPT_DIR/commands.txt"
      echo "$command: $url" >> "$SCRIPT_DIR/commands.txt"
    fi

    # Count the number of lines in the file
    num_lines=$(wc -l < "$SCRIPT_DIR/bashrc_alias.txt")
    # Count the number of newline characters in the file
    num_newlines=$(grep -c $'\n' "$SCRIPT_DIR/bashrc_alias.txt")
    # If the number of lines is equal to the number of newline characters, the file ends with a newline
    if [ "$num_lines" -eq "$num_newlines" ]; then
      # The file ends with a newline, no need to append another
      echo "alias $command='~/Documents/mint-scripts/browser.sh $command'" >> "$SCRIPT_DIR/bashrc_alias.txt"
    else
      # The file does not end with a newline, append one before the command
      echo "" >> "$SCRIPT_DIR/bashrc_alias.txt"
      echo "alias $command='~/Documents/mint-scripts/browser.sh $command'" >> "$SCRIPT_DIR/bashrc_alias.txt"
    fi

    echo "Command added!"
    git_push=true
  fi

else
   echo "Aborted!"
fi

if [ "$git_push" = true ]; then
    cd /home/kunalchand/Documents/mint-scripts
    git add *
    git commit -m "Added new commands"
    git push
fi

source ~/.bashrc