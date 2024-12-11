#!/bin/bash

# Check if the list file exists
if [ ! -f "list_package.list" ]; then
  echo "Package list file not found!"
  exit 1
fi

# Read the package list and install each package marked as "install"
while IFS= read -r line; do
  # Trim leading and trailing spaces from the line
  line=$(echo "$line" | xargs)

  # Split the line into package name and status
  package=$(echo "$line" | cut -d' ' -f1)
  status=$(echo "$line" | cut -d' ' -f2)

  # Print for debugging
  echo "Processing package: $package with status: $status"

  # Install only if the status is "install"
  if [ "$status" == "install" ]; then
    echo "Installing $package..."
    sudo apt install -y "$package"
  fi
done < "list_package.list"

echo "All packages have been processed."
