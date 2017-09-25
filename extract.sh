#!/bin/bash

# Libesedb extraction of NTDS.dit
# Script written by: Rob Emmerson
# Tested and working in Kali 2017.1
# Created: 21/09/2017


if [ -e NTDS/NTDS.dit ] && [ -e NTDS/SYSTEM ] && [ -e NTDS/SAM ]
then
	echo "Extracting libesedb..."
	tar xzf libesedb-experimental-20140406.tar.gz
	cd libesedb-20140406
	echo "Building libesedb..."
	CFLAGS="-g -O2 -Wall -fgnu89-inline" ./configure --enable-static-executables >/dev/null 2>&1
	make >/dev/null 2>&1
	cd ..
	echo "Preparing datafiles using esedbexport..."
	./libesedb-20140406/esedbtools/esedbexport -t NTDS NTDS/NTDS.dit >/dev/null 2>&1
	echo "Extracting hashes..."
	python ntdsxtract/dsusers.py NTDS.export/datatable.4 NTDS.export/link_table.7 NTDS.export --syshive NTDS/SYSTEM --ntoutfile ../NTDS/extracted_hashes.txt --pwdformat ophc --passwordhashes --passwordhistory >/dev/null 2>&1
	echo "Done!"
else
	echo ""
	echo "Error: NTDS.dit, SYSTEM and SAM are not all present in the NTDS folder"
	echo ""
	echo ""
fi
