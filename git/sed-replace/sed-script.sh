#/bin/bash

sed -i '
s/cc3_cms/db/g
s/,/ /
' "$@"
