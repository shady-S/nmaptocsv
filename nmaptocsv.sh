#!/bin/bash

# Check if the script received an argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <nmap_file>"
    exit 1
fi

# Input file from the argument
input_file="$1"

# Check if the input file exists
if [ ! -f "$input_file" ]; then
    echo "Error: File '$input_file' not found!"
    exit 1
fi

# Output CSV file
output_file="scan_results.csv"
echo "Host,Port,Protocol,State,Service" > "$output_file"

# Process the .nmap file
current_host=""
while IFS= read -r line; do
    # Detect the host line
    if [[ "$line" == Nmap\ scan\ report\ for* ]]; then
        raw_host=$(echo "$line" | awk '{print $NF}')
        # Strip any special characters except '.'
        current_host=$(echo "$raw_host" | sed 's/[^0-9\.]//g')
    # Skip the "PORT" header
    elif [[ "$line" == PORT* ]]; then
        continue
    # Process port information
    elif [[ "$current_host" != "" && "$line" =~ ^[0-9]+/ ]]; then
        port_protocol=$(echo "$line" | awk '{print $1}')
        port=$(echo "$port_protocol" | cut -d'/' -f1)
        protocol=$(echo "$port_protocol" | cut -d'/' -f2)
        state=$(echo "$line" | awk '{print $2}')
        service=$(echo "$line" | awk '{print $3}')
        echo "$current_host,$port,$protocol,$state,$service" >> "$output_file"
    fi
done < "$input_file"

# Print success message
echo "Parsing completed. Results saved in $output_file."
