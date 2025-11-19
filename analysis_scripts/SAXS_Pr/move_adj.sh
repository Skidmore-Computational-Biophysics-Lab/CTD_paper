#!/bin/bash

# --- Configuration ---
# The list of numbers provided by the user.
numbers=(9 30 49 55 69 88 94 105 126 145 151 165 184 190 201 222 241 247 261 280 286)

# --- Script Logic ---

# Check if the correct number of arguments (source and destination directories) were provided.
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <source_directory> <destination_directory>"
    echo "Example: ./move_files.sh ./my_data ./processed_data"
    exit 1
fi

# Assign the command-line arguments to variables for clarity.
SOURCE_DIR="$1"
DEST_DIR="$2"

# Check if the source directory actually exists.
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: Source directory '$SOURCE_DIR' not found."
    exit 1
fi

# Create the destination directory if it doesn't already exist.
# The '-p' flag ensures that no error is reported if the directory already exists.
echo "Ensuring destination directory '$DEST_DIR' exists..."
mkdir -p "$DEST_DIR"

echo "Starting to process files..."

# Get the total number of elements in the 'numbers' array.
num_count=${#numbers[@]}

# Loop through the array from the first element to the second-to-last element.
# We stop at num_count-1 because we need to access the next element (i+1) in each iteration.
for (( i=0; i<num_count-1; i++ )); do
    # Get the current number and the next number in the list.
    num1=${numbers[i]}
    num2=${numbers[i+1]}

    # Construct the expected filenames, in both possible orders.
    filename_forward="${num1}-${num2}.dat"
    filename_reverse="${num2}-${num1}.dat"
    
    # Construct the full path for both potential source files.
    source_filepath_forward="${SOURCE_DIR}/${filename_forward}"
    source_filepath_reverse="${SOURCE_DIR}/${filename_reverse}"

    # Check if a file with the constructed name exists in the source directory, in either order.
    if [ -f "$source_filepath_forward" ]; then
        echo "Found: '$filename_forward'. Moving to '$DEST_DIR'..."
        # If the file exists in the forward order, move it.
        mv "$source_filepath_forward" "$DEST_DIR/"
    elif [ -f "$source_filepath_reverse" ]; then
        echo "Found: '$filename_reverse'. Moving to '$DEST_DIR'..."
        # If the file exists in the reverse order, move it.
        mv "$source_filepath_reverse" "$DEST_DIR/"
    else
        # If the file does not exist in either order, print a message and continue.
        echo "Skipping: Neither '$filename_forward' nor '$filename_reverse' found."
    fi
done

echo "---------------------------------"
echo "Script finished. All matching files have been moved."

