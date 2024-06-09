#!/bin/bash

# Define the path to the README file
README="README.md"

# Define the start and end markers for the Layout section
LAYOUT_START="## Layout"
LAYOUT_END="\`\`\` -- end --"

# Generate the file tree, excluding hidden files and directories
FILE_TREE=$(find . -not -path '*/\.*' | sed -e "s/[^-][^\/]*\//  |/g" -e "s/|\([^ ]\)/|-\1/")

# Read the contents of the README file
README_CONTENT=$(cat "$README")

# Extract the content before the Layout section
PRE_LAYOUT=$(echo "$README_CONTENT" | sed -n "1,/$LAYOUT_START/p" | sed '$d')

# Extract the content after the Layout section
POST_LAYOUT=$(echo "$README_CONTENT" | sed -n "/$LAYOUT_END/,\$p" | sed '1d')

# Combine the content before, the new Layout section, and the content after
NEW_README_CONTENT="${PRE_LAYOUT}

$LAYOUT_START
\`\`\`plaintext
$FILE_TREE
$LAYOUT_END
${POST_LAYOUT}"

# Write the new content to the README file
printf "%s" "$NEW_README_CONTENT" > "$README"

echo "README.md Layout section updated successfully."
