#clean-up VS folders

gci bin -directory -recurse | remove-item -recurse -force
gci obj -directory -recurse | remove-item -recurse -force

gci node_modules -directory -recurse | remove-item -recurse -force
gci TestResults -directory -recurse | remove-item -recurse -force
