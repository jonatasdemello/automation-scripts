#/bin/bash

sed -i '
s/test/tes123/g
s/temp/tmp/g
' "$@"
