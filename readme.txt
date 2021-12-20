Simple ptcollab installer script for NSIS.

Compile time requirements:
	- NSIS plugins "Nsisunz" & "Inetc", for unzip & https respectively.
	- Predefined upstream URL & version number, located in config.txt.

Runtime requirements:
	- Upstream zip has a subfolder called "ptcollab".

The compilation of ptcollab.nsi creates a file "ptcollab-install-(version).exe" when compiled.

Ewan Green 2021