# If no parameter is passed, open Microsoft Edge
setsid microsoft-edge > /dev/null 2>&1 &

# Get the PID of the terminal
TERMINAL_PID=$(ps -o ppid= -p $$)

# Close the terminal
kill -9 "$TERMINAL_PID"