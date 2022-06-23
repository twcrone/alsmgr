echo "Building alsmgr"
crystal build alsmgr.cr --release
echo "Creating a ~/bin directory if it does not already exist"
mkdir ~/bin
echo "Copying to ~/bin"
cp alsmgr ~/bin/.
cp alsmgr ~/bin/am
echo "Done"
