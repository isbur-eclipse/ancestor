git:
	git add .
	git commit -m "$m"
	git push


pot-init:
	echo "Enter new workspace name (with no spaces):" ; \
	read WORKSPACE_NAME
	# export it?

pot-add:
	# Get list of commands of present bash session
	history | cut -c 8-

pot-cook:
