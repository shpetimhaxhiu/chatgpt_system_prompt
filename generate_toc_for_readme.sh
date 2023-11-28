#!/bin/bash

generate_toc() {
    local base_dir=$(pwd)
    local exclude_dir="knowledge"

    # Find all Markdown files excluding the specified directory
    find "$1" -type f -name '*.md' -not -path "./$exclude_dir/*" | while read -r file; do
        local title=$(basename "${file%.md}")

        # Sanitize title: replace Windows incompatible characters with '_'
        local safe_title=$(echo "$title" | sed 's/[<>:："\|?*]/_/g')

        # Rename file if necessary
        if [[ "$title" != "$safe_title" ]]; then
            mv "$file" "$(dirname "$file")/$safe_title.md"
        fi

        # Create relative Markdown link
        local relative_link="${file#"$base_dir/"}"
        local encoded_link=$(echo "$relative_link" | sed 's/ /%20/g')

        echo " - [$safe_title]($encoded_link)"
    done
}

generate_toc .
