#!/bin/bash

# Libesedb extraction of NTDS.dit
# Script written by: Rob Emmerson
# Tested and working in Kali 2017.1
# Created: 21/09/2017


if [ -e NTDS/NTDS.dit ] && [ -e NTDS/NTDS.dit ] && [ -e NTDS/NTDS.dit ]
then
	echo "Extracting libesedb..."
	tar xvzf libesedb-experimental-20140406.tar.gz
	cd libesedb-20140406
	clear
	echo "Building libesedb..."
	CFLAGS="-g -O2 -Wall -fgnu89-inline" ./configure --enable-static-executables
	make
	cd ..
	clear
	echo "Preparing datafiles using esedbexport..."
	./libesedb-20140406/esedbtools/esedbexport -t NTDS NTDS/NTDS.dit
	clear
	echo "Extracting hashes..."
	python ntdsxtract/dsusers.py NTDS.export/datatable.4 NTDS.export/link_table.7 NTDS.export --syshive NTDS/SYSTEM --ntoutfile ../NTDS/extracted_hashes.txt --pwdformat ophc --passwordhashes --passwordhistory
else
	echo ""
	echo "Error: NTDS.dit, SYSTEM and SAM are not all present in the NTDS"
	echo ""
	echo ""
fi
