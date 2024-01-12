#!/bin/bash

# Set the script to exit immediately if any command fails
set -e

ROADMAP="https://neetcode.io/roadmap"
LEETCODENOTES="https://docs.google.com/spreadsheets/d/14xdtVdBHRXI2thUCdcIiq0E-C1gLPzHMGUZl31hw6gc/edit#gid=1336779853"
JAVANOTES="https://docs.google.com/document/d/1JSchYJH05EUrNvdm1mI50um1R79Pi9bkoH9SmEWy_b8/edit#heading=h.pvt1ihed3m2z"
PYTHONNOTES="https://docs.google.com/document/d/1XsxxR_XPK1vzl34HlFVM3gcrlO7_wKDmG_36vxqn03Y/edit#heading=h.pvt1ihed3m2z"

# Launch browser in the background
setsid google-chrome $ROADMAP > /dev/null 2>&1 &
setsid google-chrome $LEETCODENOTES > /dev/null 2>&1 &
setsid google-chrome $JAVANOTES > /dev/null 2>&1 &
setsid google-chrome $PYTHONNOTES > /dev/null 2>&1 &

cd /home/kunalchand/Desktop/Projects/LeetCode
code .

# Get the PID of the terminal
TERMINAL_PID=$(ps -o ppid= -p $$)

# Close the terminal
kill -9 "$TERMINAL_PID"
