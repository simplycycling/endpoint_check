#!/bin/bash

# Declare an array to store the failed connections
failed_connections=()

# Read in a list of endpoints and ports from a file (one endpoint and port per line, separated by a space)
while read -r endpoint port; do
  # Use nc to check if the endpoint is reachable
  if nc -z "$endpoint" "$port"; then
    echo "Connection to $endpoint on port $port succeeded"
  else
    # If the connection failed, add the endpoint to the failed connections array
    failed_connections+=("$endpoint:$port")
    echo "Connection to $endpoint on port $port failed"
  fi
done < endpoints.txt

# If there were any failed connections, print them out
if [ ${#failed_connections[@]} -gt 0 ]; then
  echo "Failed connections: ${failed_connections[@]}"
fi

# Exit with appropriate status code
if [ ${#failed_connections[@]} -eq 0 ]
then
  exit 0
elif [ ${#failed_connections[@]} -eq 1 ]
then
  exit 1
else
  exit 2
fi
