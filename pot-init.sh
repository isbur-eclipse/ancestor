echo "Enter new workspace name (with no spaces):" ; \
# read $(WORKSPACE_NAME) ; \
# export it? ; \
echo "Creating new git repo..." ; \
echo $WORKSPACE_NAME >> .gitignore ; \
mkdir $WORKSPACE_NAME
cp ./makefile ./$WORKSPACE_NAME/makefile
cd $WORKSPACE_NAME ; \
git init ; \
git remote add origin https://github.com/isbur-eclipse/$WORKSPACE_NAME
git push --set-upstream origin/master
make git m="Initial commit" ; \
mkdir .s2i
cd .s2i
mkdir bin
cd ..
cp ../.s2i/bin/run ./.s2i/bin/run
make git m="Second commit"

echo "Initiating Openshift Online session..."
oc login