#!/bin/bash

# Update submodules
git submodule init
git submodule update

# Make 'extract.sh' executable
chmod +x extract.sh

# Check for the presence of the NTDS files
if [ -e NTDS/NTDS.dit ] && [ -e NTDS/SYSTEM ] && [ -e NTDS/SAM ]
then
	echo "Extracting libesedb..."
	tar xzf libesedb-experimental-20140406.tar.gz
    rm -f libesedb-experimental-20140406.tar.gz
	cd libesedb-20140406
	echo "Building libesedb..."
	CFLAGS="-g -O2 -Wall -fgnu89-inline" ./configure --enable-static-executables >/dev/null 2>&1
	make >/dev/null 2>&1
	cd ..
	echo "Preparing datafiles using esedbexport..."
	./libesedb-20140406/esedbtools/esedbexport -t NTDS NTDS/NTDS.dit >/dev/null 2>&1
    echo "Done! Please execute 'extract.sh' to extract the hashes into the NTDS folder"
else
	echo ""
	echo "Error: NTDS.dit, SYSTEM and SAM are not all present in the NTDS folder"
	echo ""
	echo ""
fi