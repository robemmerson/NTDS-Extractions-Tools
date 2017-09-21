#!/bin/bash

# Libesedb extraction of NTDS.dit
# Script written by: Rob Emmerson
# Tested and working in Kali 2017.1
# Created: 21/09/2017


if [ -e NTDS/NTDS.dit ] && [ -e NTDS/NTDS.dit ] && [ -e NTDS/NTDS.dit ]
then
	tar xvzf libesedb-experimental-20140406.tar.gz
	cd libesedb-20140406
	CFLAGS="-g -O2 -Wall -fgnu89-inline" ./configure --enable-static-executables
	make
	cd ..
	mkdir extracted/work
	./libesedb-20140406/esedbtools/esedbexport -t extracted NTDS/NTDS.dit
	python ntdsxtract/dsusers.py extracted.export/datatable.4 extracted.export/link_table.7 extracted/work --syshive NTDS/SYSTEM --lmoutfile extracted/lm_hashes.txt --ntoutfile extracted/nt_hashes.txt --pwdformat ocl --passwordhashes --passwordhistory --certificates --supplcreds --membership
else
	echo ""
	echo "Error: NTDS.dit, SYSTEM and SAM are not all present in the NTDS"
	echo ""
	echo ""
fi
