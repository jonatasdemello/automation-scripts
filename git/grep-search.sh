#/bin/bash

# grep search 
# 	paramter is dest path

SCRIPT_PATH="$(readlink -f "$0")"
echo "Script absolute: $SCRIPT_PATH"

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
echo "Script directory: $SCRIPT_DIR"

DEST="${1:-.}"
echo "Script dest: $DEST"

grep -i -E -f $SCRIPT_DIR/grep-search.txt -r $DEST

