#clean-up VS folders

gci bin -directory -recurse | remove-item -recurse -force
gci obj -directory -recurse | remove-item -recurse -force