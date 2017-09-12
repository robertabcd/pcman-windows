git clone -q --branch=master https://github.com/Microsoft/vcpkg.git vcpkg
if (Test-Path -Path 'cache\vcpkg-installed') {
	New-Item -Type dir vcpkg\installed
	Copy-Item cache\vcpkg-installed\* vcpkg\installed -recurse
}
Copy-Item hack\portfile.cmake vcpkg\ports\libwebsockets\portfile.cmake -Force
pwd
.\vcpkg\bootstrap-vcpkg.bat
.\vcpkg\vcpkg integrate install
.\vcpkg\vcpkg install libwebsockets
pwd
if (Test-Path -Path 'cache\vcpkg-installed') {
	Remove-Item cache\vcpkg-installed -Force -Recurse
}
New-Item -Type dir cache\vcpkg-installed
Copy-Item vcpkg\installed\* cache\vcpkg-installed -Recurse -Force
[Net.ServicePointManager]::SecurityProtocol = 'Tls, Tls11, Tls12'
Start-FileDownload 'https://curl.haxx.se/ca/cacert.pem'
Copy-Item cacert.pem 'Combo\Debug\PCMan Combo\'
Copy-Item cacert.pem 'Combo\Release\PCMan Combo\'
Copy-Item cacert.pem 'Lite\Debug\PCMan\'
Copy-Item cacert.pem 'Lite\Release\PCMan\'

Start-FileDownload 'https://go.microsoft.com/fwlink/?LinkId=746572' -FileName 'vc_redist.x64.exe'
Start-FileDownload 'https://go.microsoft.com/fwlink/?LinkId=746571' -FileName 'vc_redist.x86.exe'
