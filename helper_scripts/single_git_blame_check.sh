filetypes="\.cpp\|\.h"
git ls-files | grep $filetypes | while read -r file; do
    git blame --line-porcelain "$file" 2>/dev/null || continue
done | awk '/^author /{authors[$2]++} END{for (a in authors) print authors[a], a}' | sort -nr
