git:
	git add .
	git commit -m "$m"
	git push


kitchen-init:
	echo "We are going to check whether everything in your Openshift Online account is set up to be used in this Galushkas Pot workflow"
	# не в этой жизни...


pot-init:
	echo "Enter new workspace name (with no spaces):" ; \
	read WORKSPACE_NAME
	# export it?

pot-add:
	# Get list of commands of present bash session
	history | cut -c 8-

pot-cook:
