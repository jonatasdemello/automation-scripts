#-------------------------------------------------------------------------------------------------------------------------------
# Encoding

file *.sql | grep -v "ASCII"

file *.sql | grep -v ASCII | grep BOM

# -v, --invert-match        select non-matching lines