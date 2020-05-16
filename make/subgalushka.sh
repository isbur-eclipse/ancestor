echo "Enter new branch/tag name:"
read TAGNAME
if [ ! -d ~/vars ]; then
    mkdir ~/vars
fi
echo "$TAGNAME" > ~/vars/TAGNAME
git branch $TAGNAME
git checkout $TAGNAME
git push -u origin $TAGNAME