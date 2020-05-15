git:
	git add .
	git commit -m "$m"
	git push


kitchen-init:
	echo "We are going to check whether everything in your Openshift Online account is set up to be used in this Galushkas Pot workflow"
	# не в этой жизни...


pot-init: ./assemble
	echo "Enter new workspace name (with no spaces):" ; \
	read WORKSPACE_NAME
	# export it?
	
	echo "Creating new git repo..."
	add $WORKSPACE_NAME to .gitignore
	mkdir $WORKSPACE_NAME
	cd $WORKSPACE_NAME
	
	git init
	git set remote origin
	make git m="Initial commit"
	
	mkdir .s2i
	cd .s2i
	mkdir bin
	cd ..
	cp ../.s2i/bin/run ./.s2i/bin/run
	make git m="Second commit"
	
	echo "Initiating Openshift Online session..."
	oc login
	


pot-add:
	# Get list of commands of present bash session
	history | cut -c 8- > ./$WORKSPACE_NAME/.s2i/bin/assemble

pot-cook:
	oc build
