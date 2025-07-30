#-------------------------------------------------------------------------------------------------------------------------------
# sort

find . -type f -print0 | sort -z | xargs -r0 sha256sum > sha256SumOutput

#   -print0
#        True; print the full file name on the standard output, followed
#        by a null character (instead of the newline character that -print
#        uses). This allows file names that contain newlines or other
#        types of white space to be  correctly  interpreted by programs
#        that process the find output.  This option corresponds to the -0
#        option of xargs.
#   -z, --zero-terminated
#        line delimiter is NUL, not newline
#   -r
#        If the standard input does not contain any nonblanks, do not run
#        the command. Normally, the command is run once even if there is
#        no input. This option is a GNU extension.
#   -0
#        Input items are terminated by a null character instead of by
#        whitespace, and the quotes and backslash are not special (every
#        character is taken literally).  Disables the end of file string,
#        which is treated like any  other  argument. Useful when input
#        items might contain white space, quote marks, or backslashes.
#        The GNU find -print0 option produces input suitable for this mode.

