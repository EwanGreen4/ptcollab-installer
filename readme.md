## ptcollab-installer
Simple ptcollab installer script for NSIS.

Compile time requirements
- NSIS plugins "[Nsisunz](https://nsis.sourceforge.io/Nsisunz_plug-in)" & "[Inetc](https://nsis.sourceforge.io/Inetc_plug-in)", for unzip & https respectively.
- Predefined upstream URL & version number, located in config.txt.

Runtime requirements
- Upstream zip has a subfolder called "ptcollab".

The compilation of ptcollab.nsi creates a file "ptcollab-install-(version).exe".

Ewan Green 2021
