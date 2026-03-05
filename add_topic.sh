#!/bin/bash
# Add a new topic to materials site
# Usage: ./add_topic.sh <folder_name> <display_name>
# Example: ./add_topic.sh prompt-eng "Prompt Engineering"

set -e

VAULT="/Users/makino/Library/Mobile Documents/iCloud~md~obsidian/Documents/makinote/Materials"
DOCS="$(dirname "$0")/docs"

if [ $# -lt 2 ]; then
  echo "Usage: $0 <folder_name> <display_name>"
  echo "Example: $0 prompt-eng \"Prompt Engineering\""
  exit 1
fi

FOLDER="$1"
NAME="$2"

# 1. Create folder in vault
if [ -d "$VAULT/$FOLDER" ]; then
  echo "Vault folder already exists: $VAULT/$FOLDER"
else
  mkdir -p "$VAULT/$FOLDER"
  cat > "$VAULT/$FOLDER/index.md" << EOF
# $NAME

---

*内容待补充*
EOF
  echo "Created: $VAULT/$FOLDER/index.md"
fi

# 2. Create symlink
if [ -L "$DOCS/$FOLDER" ]; then
  echo "Symlink already exists: $DOCS/$FOLDER"
else
  ln -s "$VAULT/$FOLDER" "$DOCS/$FOLDER"
  echo "Symlinked: $DOCS/$FOLDER -> $VAULT/$FOLDER"
fi

# 3. Remind about mkdocs.yml
echo ""
echo "Done! Now add to mkdocs.yml nav section:"
echo ""
echo "  - $NAME:"
echo "    - $FOLDER/index.md"
echo ""
echo "Then run ./deploy.sh to publish."
