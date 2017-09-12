pushd Lite\Release
7z a PCMan.7z PCMan
popd
pushd Combo\Release
7z a PCManCB.7z 'PCMan Combo'
popd

md Release
& 'C:\Program Files (x86)\NSIS\makensis.exe' .\Installer.nsi
& 'C:\Program Files (x86)\NSIS\makensis.exe' /D_COMBO_ .\Installer.nsi
