echo "Building alsmgr"
crystal build alsmgr.cr --release
echo "Copying to ~/bin"
cp alsmgr ~/bin/.
echo "Done"
