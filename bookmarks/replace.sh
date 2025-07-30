# sed 's/,\(.*china\)/,Tomas_proxy.lt\/\1/' FF-bookmarks.html > FF-bookmarks1.html

# or using a sed script file:
# --- rules.sed ---
# s/ ADD_DATE=\"[0-9]+\"//g
# s/ LAST_MODIFIED=\"[0-9]+\"//g
# s/ ICON_URI=".+"//g
# s/ ICON=".+"//g

sed -f rules.sed FF-bookmarks.html > FF-bookmarks1.html
