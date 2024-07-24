#!/bin/bash

# Check if the argument is provided and is a directory
if [ -z "$1" ] || [ ! -d "$1" ]; then
  echo "Usage: $0 <directory>"
  exit 1
fi

# Create the biped and quad directories if they don't exist
mkdir -p biped
mkdir -p quad
mkdir -p tripod
mkdir -p lam

# Initialize counters
biped_count=0
quad_count=0
tripod_count=0
lam_count=0

# Search for .mtf files and process them
readarray -d '' files < <(find "$1" -type f -name "*.mtf" -print0)
for file in "${files[@]}"; do
  if grep -iq "Config:Biped" "$file"; then
    dest_file="biped/$(basename "$file" | tr ' ' '_')"
    cp "$file" "$dest_file" && echo "$file -> $dest_file"
    ((biped_count++))
  elif grep -iq "Config:Quad" "$file"; then
    dest_file="quad/$(basename "$file" | tr ' ' '_')"
    cp "$file" "$dest_file" && echo "$file -> $dest_file"
    ((quad_count++))
  elif grep -iq "Config:Tripod" "$file"; then
    dest_file="tripod/$(basename "$file" | tr ' ' '_')"
    cp "$file" "$dest_file" && echo "$file -> $dest_file"
    ((tripod_count++))
  elif grep -iq "Config:LAM" "$file"; then
    dest_file="lam/$(basename "$file" | tr ' ' '_')"
    cp "$file" "$dest_file" && echo "$file -> $dest_file"
    ((lam_count++))
  else
    echo "Error: $file is none of 'Biped', 'Quad', 'Tripod' or 'LAM'"
    exit 1
  fi
done

# Print the counters
echo "Biped mechs copied: $biped_count"
echo "Quad mechs copied: $quad_count"
echo "Tripod mechs copied: $tripod_count"
echo "LAM mechs copied: $lam_count"
