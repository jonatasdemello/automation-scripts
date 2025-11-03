#clean-up VS folders

write-host "gci bin -directory -recurse | remove-item -recurse -force"
gci bin -directory -recurse | remove-item -recurse -force

write-host "gci obj -directory -recurse | remove-item -recurse -force"
gci obj -directory -recurse | remove-item -recurse -force

write-host "gci TestResults -directory -recurse | remove-item -recurse -force"
gci TestResults -directory -recurse | remove-item -recurse -force

write-host "gci node_modules -directory -recurse | remove-item -recurse -force"
gci node_modules -directory -recurse | remove-item -recurse -force

write-host "done!"
