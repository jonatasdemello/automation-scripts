# get file types

gci -recurse | foreach { $_.extension } | unique | clip

gci -recurse | foreach { $_.extension } | sort | unique

gci -recurse | foreach { $_.extension } | sort | unique | clip

