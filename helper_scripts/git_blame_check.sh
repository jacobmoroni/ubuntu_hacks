#!/bin/bash

# Check for the --by-dir argument
BY_DIR=false
if [[ "$1" == "--by-dir" ]]; then
    BY_DIR=true
fi

declare -A authors

# Function to process files
process_files() {
    while read -r file; do
        git blame --line-porcelain "$file" 2>/dev/null | LC_ALL=C awk '
            /^author / {author = $2}
            /^[^\t]/ {next} # Skip lines that are not actual code lines
            { code = substr($0, 2) } # Extract actual code (skip leading tab)
            code ~ /^[[:space:]]*$/ {next} # Skip blank or whitespace-only lines
            { authors[author]++ }
            END {
                for (a in authors) {
                    print a, authors[a]
                }
            }
        '
    done | LC_ALL=C awk -v prefix="$1" '
        { count[$1] += $2 }
        END {
            for (a in count) {
                print prefix, count[a], a
            }
        }
    '
}

if $BY_DIR; then
    # Process by directory
    for dir in $(git ls-files | awk -F'/' '{print $1}' | sort -u); do
        echo "Processing directory: $dir"
        git ls-files "$dir" | process_files "$dir"
    done
else
    # Process the entire repo
    echo "Processing entire repository..."
    git ls-files | process_files "TOTAL"
fi | sort -k1,1 -k2,2nr

