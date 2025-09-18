# sed 's/,\(.*china\)/,Tomas_proxy.lt\/\1/' FF-bookmarks.html > FF-bookmarks1.html

# or using a sed script file:
# --- rules.sed ---
# s/ ADD_DATE=\"[0-9]+\"//g
# s/ LAST_MODIFIED=\"[0-9]+\"//g
# s/ ICON_URI=".+"//g
# s/ ICON=".+"//g

# sed -f sed-rules.sed FF-bookmarks.html > FF-bookmarks1.html

# -i in-place

find . -type f -exec sed -f sed-rules.sed {} \;

# all files
# find . -type f -exec sed -i 's/old_text/new_text/g' {} \;

# trim trailing space
# find . -type f -exec sed -i -E 's/[ \t]+$//g' {} \;
