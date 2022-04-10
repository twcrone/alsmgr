echo "Building alsmgr"
crystal build alsmgr.cr --release
echo "Copying to ~/bin"
cp alsmgr ~/bin/.
cp alsmgr ~/bin/am
echo "Done"
