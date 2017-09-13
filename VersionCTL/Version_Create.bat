
SET VersionFile_In="%1"
SET VersionFile_Out="%2"
SET VersionFile_tmp="version.h.tmp"
SET VersionFile_tmp2="version.h.tmp2"

if exist Version_Path.bat (
	call Version_Path.bat
)

if %VersionFile_In% == "" (
	echo no input version file
	goto exit
)

if %VersionFile_tmp% == "" (
	echo no output version header file
	goto exit
)

REM �]�w�Ҧ��ѨϥΪ̳]�w�������Ѽ�
call %VersionFile_In%

REM ���� version.h���Ȧs��

REM echo #pragma once > %VersionFile_tmp%

echo //Generated from Version_Create.bat %VersionFile_In% >> %VersionFile_tmp%


REM echo #pragma once > %Update_File_Path%
REM �����������X��update.txt
if exist %Update_File_Path% (
	del /f /q %Update_File_Path%
)
echo %MajorVersion%.%MinorVersion%.%PatchLevel%. > %Update_File_Path%

echo // >> %VersionFile_tmp%
echo #define FILEVER            %MajorVersion%,%MinorVersion%,%PatchLevel%,%BuildNumber% >> %VersionFile_tmp%
echo #define FILEVER_STRA       "%MajorVersion%,%MinorVersion%,%PatchLevel%,%BuildNumber%\0" >> %VersionFile_tmp%
echo #define FILEVER_DOT_STRA       "%MajorVersion%.%MinorVersion%.%PatchLevel%.%BuildNumber%\0" >> %VersionFile_tmp%
echo #define FILEVER_DOT_STRW       L"%MajorVersion%.%MinorVersion%.%PatchLevel%.%BuildNumber%\0" >> %VersionFile_tmp%

echo // >> %VersionFile_tmp%
echo #define PRODUCTVER         %MajorVersion%,%MinorVersion%,%PatchLevel%,%BuildNumber% >> %VersionFile_tmp%
echo #define PRODUCTVER_STRA    "%MajorVersion%,%MinorVersion%,%PatchLevel%,%BuildNumber%\0" >> %VersionFile_tmp%
echo #define PRODUCTVER_DOT_STRA    "%MajorVersion%.%MinorVersion%.%PatchLevel%.%BuildNumber%\0" >> %VersionFile_tmp%
echo #define PRODUCTVER_DOT_STRW    L"%MajorVersion%.%MinorVersion%.%PatchLevel%.%BuildNumber%\0" >> %VersionFile_tmp%

echo // >> %VersionFile_tmp%
echo #define Version_Major %MajorVersion% >> %VersionFile_tmp%
echo #define Version_Minor %MinorVersion% >> %VersionFile_tmp%
echo #define Version_PatchLevel %PatchLevel% >> %VersionFile_tmp%
echo #define Version_BuildNumber   %BuildNumber% >> %VersionFile_tmp%

echo // >> %VersionFile_tmp%
echo #define Version_RevDateA   "%BuildNumber_Date%" >> %VersionFile_tmp%
echo #define Version_RevDateW   "%BuildNumber_Date%" >> %VersionFile_tmp%

echo // >> %VersionFile_tmp%
echo #define Version_CompanyNameA   %CompanyName% >> %VersionFile_tmp%
echo #define Version_CompanyNameW   L%CompanyName% >> %VersionFile_tmp%
echo #define Version_ProductNameA   %ProductName% >> %VersionFile_tmp%
echo #define Version_ProductNameW   L%ProductName% >> %VersionFile_tmp%
echo #define Version_InternalNameA   %InternalName% >> %VersionFile_tmp%
echo #define Version_InternalNameW   L%InternalName% >> %VersionFile_tmp%
echo #define Version_LegalCopyrightA   %LegalCopyright% >> %VersionFile_tmp%
echo #define Version_LegalCopyrightW   L%LegalCopyright% >> %VersionFile_tmp%
echo #define Version_OriginalFilenameA   %OriginalFilename% >> %VersionFile_tmp%
echo #define Version_OriginalFilenameW   L%OriginalFilename% >> %VersionFile_tmp%
echo #define Version_FileDescriptionA   %FileDescription% >> %VersionFile_tmp%
echo #define Version_FileDescriptionW   L%FileDescription% >> %VersionFile_tmp%
echo #define Version_CommentsA   %Comments% >> %VersionFile_tmp%
echo #define Version_CommentsW   L%Comments% >> %VersionFile_tmp%

REM ���s��version.h �A�Y�O���@�ˡA�~copy�L�h
fc %VersionFile_tmp% %VersionFile_Out% 2>&1
if not "%ERRORLEVEL%"=="0" (
	copy /y %VersionFile_tmp% %VersionFile_Out%
)

:exit

if exist %VersionFile_tmp% (
	del /f /q %VersionFile_tmp%
)

if exist %VersionFile_tmp2% (
	del /f /q %VersionFile_tmp2%
)


SET MajorVersion=
SET MinorVersion=
SET PatchLevel=
SET CompanyName=
SET ProductName=
SET InternalName=
SET OriginalFilename=
SET FileDescription=
SET LegalCopyright=
