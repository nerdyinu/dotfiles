#!/bin/bash

# Find all .conf files in the current directory and its subdirectories
find . -type f -name "*.conf" -exec sh -c '
  for file do
    # Remove the BOM from each file
    sed -i "1s/^\xEF\xBB\xBF//" "$file"
  done
' sh {} +

