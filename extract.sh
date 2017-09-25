#!/bin/bash

# Libesedb extraction of NTDS.dit
# Script written by: Rob Emmerson
# Tested and working in Kali 2017.1
# Created: 21/09/2017


if [ -e NTDS.export/datatable.4 ] && [ -e NTDS.export/link_table.7 ] && [ -e NTDS/SYSTEM ]
then
	echo "Extracting hashes..."
	python ntdsxtract/dsusers.py NTDS.export/datatable.4 NTDS.export/link_table.7 NTDS.export --syshive NTDS/SYSTEM --ntoutfile ../NTDS/extracted_hashes.txt --pwdformat ophc --passwordhashes --passwordhistory >/dev/null 2>&1
	echo "Done!"
else
	echo ""
	echo "Error: NTDS.export/datatable.4, NTDS.export/link_table.7 and NTDS/SYSTEM are not all present"
	echo ""
	echo ""
fi
