
$folders = gci -Attributes Directory

ForEach-Object ($folder in $folders) {
	cd $folder
	git reset --hard HEAD && git clean -xdf
	cd ..
}
