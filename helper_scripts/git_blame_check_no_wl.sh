filetypes="\.cpp\|\.h"
git ls-files | grep $filetypes | while read -r file; do
  git blame --line-porcelain "$file" 2>/dev/null | LC_ALL=C awk '
      /^author / {author = $2}
      /^[^\t]/ {next}
      { code = substr($0, 2) }
      code ~ /^[[:space:]]*$/ {next}
      { authors[author]++ }
      END {
          for (a in authors) {
              print authors[a], a
          }
      }
  '
done | sort -nr
