#!/bin/bash
# use "." for all files
filetypes="\.cpp\|\.h"
seperate_dirs="true"

# Iterate over top-level directories
for dir in $(git ls-files | grep $filetypes |awk -F'/' '{print $1}' | sort -u); do
    
    declare -A authors # Reset author count per directory

    # Process files within the directory
    while read -r file; do
        git blame --line-porcelain "$file" 2>/dev/null | LC_ALL=C awk '
            /^author / {author = $2}
            /^[^\t]/ {next} # Skip lines that are not actual code lines (those starting without a tab)
            { code = substr($0, 2) } # Extract the actual code (skip the leading tab)
            code ~ /^[[:space:]]*$/ {next} # Skip blank or whitespace-only lines
            { authors[author]++ }
            END {
                for (a in authors) {
                    print a, authors[a]
                }
            }
        '
    done < <(git ls-files "$dir") | LC_ALL=C awk -v dir="$dir" '
        { count[$1] += $2 }
        END {
            for (a in count) {
                print dir, count[a], a
            }
        }
    '
done | sort -k1,1 -k2,2nr

