;NSIS installer script for ptcollab based on Modern UI 2
;Written by Ewan Green, based off example script by Joost Verburg

!include "MUI2.nsh"
!include 'FileFunc.nsh'

!insertmacro Locate

!include ".\MoveFileFolder.nsh"
!include ".\config.txt"

Name "ptcollab ${version}"
OutFile "ptcollab-install-${version}.exe"
Unicode True
InstallDir "$PROGRAMFILES\ptcollab"
RequestExecutionLevel user

!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP ".\header.bmp" ; optional
!define MUI_HEADERIMAGE_BITMAP_STRETCH AspectFitHeight

!define MUI_ICON ".\icon.ico"
!define MUI_UNICON ".\icon.ico"

;!macro VerifyUserIsAdmin
;UserInfo::GetAccountType
;pop $0
;${If} $0 != "admin" ;Require admin rights on NT4+
;        messageBox mb_iconstop "Administrator rights required!"
;        setErrorLevel 740 ;ERROR_ELEVATION_REQUIRED
;        quit
;${EndIf}
;!macroend
; 
;function .onInit
;	setShellVarContext all
;	!insertmacro VerifyUserIsAdmin
;functionEnd

!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES

!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

!insertmacro MUI_LANGUAGE "English"
RequestExecutionLevel admin

Section "Install"

    SetOutPath "$INSTDIR"
    
    inetc::get "${upstream}" "$INSTDIR\ptcollab.zip" /END
    nsisunz::Unzip "$INSTDIR\ptcollab.zip" "$INSTDIR"
    !insertmacro MoveFolder "$INSTDIR\ptcollab\" "$INSTDIR\" ""
    
    Delete "$INSTDIR\ptcollab.zip"
    WriteUninstaller "$INSTDIR\uninstall.exe"

    InitPluginsDir
    File icon.ico
    CopyFiles "$PLUGINSDIR\icon.ico" "$INSTDIR\icon.ico"

    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ptcollab" "DisplayName" "ptcollab"
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ptcollab" "DisplayIcon" "$\"$INSTDIR\icon.ico$\""
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ptcollab" "InstallLocation" "$\"$INSTDIR$\""
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ptcollab" "UninstallString" "$\"$INSTDIR\uninstall.exe$\""
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ptcollab" "URLInfoAbout" "https://yuxshao.github.io/ptcollab/"
    WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ptcollab" "NoModify" 1
    WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ptcollab" "NoRepair" 1
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ptcollab" "DisplayVersion" "${version}"

	CreateDirectory "$SMPROGRAMS\ptcollab"
	CreateShortCut "$SMPROGRAMS\ptcollab\ptcollab.lnk" "$INSTDIR\ptcollab.exe" "" "$INSTDIR\icon.ico"
    CreateShortCut "$SMPROGRAMS\ptcollab\uninstall.lnk" "$INSTDIR\uninstall.exe"

    CreateShortcut "$DESKTOP\ptcollab.lnk" "$INSTDIR\ptcollab.exe" "" "$INSTDIR\icon.ico"
    
SectionEnd

Section "Uninstall"

    Delete "$INSTDIR\uninstall.exe"
    Delete "$DESKTOP\ptcollab.lnk"
    RMDir /r "$SMPROGRAMS\ptcollab"
    RMDir /r "$INSTDIR"
    DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ptcollab"

SectionEnd
