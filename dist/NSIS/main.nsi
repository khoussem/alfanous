; Script generated by the HM NIS Edit Script Wizard.

; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "Alfanous"
!define PRODUCT_VERSION "0.4"
!define PRODUCT_PUBLISHER "Assem.ch"
!define PRODUCT_WEB_SITE "http://alfanous.sf.net/cms"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\Gui.exe"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

; MUI 1.67 compatible ------
!include "MUI.nsh"

; MUI Settings
!define MUI_ABORTWARNING
!define MUI_ICON "Alfanous.ico"
!define MUI_UNICON "Alfanous.ico"

; Language Selection Dialog Settings
!define MUI_LANGDLL_REGISTRY_ROOT "${PRODUCT_UNINST_ROOT_KEY}"
!define MUI_LANGDLL_REGISTRY_KEY "${PRODUCT_UNINST_KEY}"
!define MUI_LANGDLL_REGISTRY_VALUENAME "NSIS:Language"

; Welcome page
!insertmacro MUI_PAGE_WELCOME
; License page
!insertmacro MUI_PAGE_LICENSE "license.txt"
; Components page
!insertmacro MUI_PAGE_COMPONENTS
; Directory page
!insertmacro MUI_PAGE_DIRECTORY
; Instfiles page
!insertmacro MUI_PAGE_INSTFILES
; Finish page
!define MUI_FINISHPAGE_RUN "$INSTDIR\Gui.exe"
!insertmacro MUI_PAGE_FINISH

; Uninstaller pages
!insertmacro MUI_UNPAGE_INSTFILES

; Language files
!insertmacro MUI_LANGUAGE "Arabic"
!insertmacro MUI_LANGUAGE "English"
!insertmacro MUI_LANGUAGE "French"

; MUI end ------

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "alfanousInstaller.exe"
InstallDir "$PROGRAMFILES\Alfanous"
InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""
ShowInstDetails hide
ShowUnInstDetails hide

Function .onInit
  !insertmacro MUI_LANGDLL_DISPLAY
FunctionEnd

Section "Application" SEC01
  SetOutPath "$INSTDIR"
  SetOverwrite ifnewer
  File "..\..\Interfaces\desktop\dist\mingwm10.dll"
  SetOverwrite try
  File "..\..\Interfaces\desktop\dist\bz2.pyd"
  File "..\..\Interfaces\desktop\dist\Gui.exe"
  CreateDirectory "$SMPROGRAMS\Alfanous"
  CreateShortCut "$SMPROGRAMS\Alfanous\Alfanous.lnk" "$INSTDIR\Gui.exe"
  CreateShortCut "$DESKTOP\Alfanous.lnk" "$INSTDIR\Gui.exe"
  File "..\..\Interfaces\desktop\dist\*"

  SetOverwrite ifnewer
  File "..\..\alfanous\GPL.txt"
  CreateShortCut "$STARTMENU.lnk" "$INSTDIR\GPL.txt"
SectionEnd

Section "Main indexes" SEC02
  SetOutPath "$INSTDIR\indexes\main"
  SetOverwrite try
  File "..\..\Interfaces\desktop\indexes\main\*"

SectionEnd

Section "Fonts" SEC03
  SetOutPath "$FONTS"
  
  SetOverwrite ifnewer
  File "..\..\Interfaces\desktop\fonts\*"

  
SectionEnd

Section "Extend indexes" SEC04
  SetOutPath "$INSTDIR\indexes\extend"
  SetOverwrite try
  File "..\..\Interfaces\desktop\indexes\extend\*"
 
SectionEnd

Section -AdditionalIcons
  SetOutPath $INSTDIR
  WriteIniStr "$INSTDIR\${PRODUCT_NAME}.url" "InternetShortcut" "URL" "${PRODUCT_WEB_SITE}"
  CreateShortCut "$SMPROGRAMS\Alfanous\Website.lnk" "$INSTDIR\${PRODUCT_NAME}.url"
  CreateShortCut "$SMPROGRAMS\Alfanous\Uninstall.lnk" "$INSTDIR\uninst.exe"
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR\Gui.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\Gui.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
SectionEnd

; Section descriptions
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC01} "required"
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC02} "required"
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC03} "recommended"
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC04} "optional"
!insertmacro MUI_FUNCTION_DESCRIPTION_END


Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) a �t� d�sinstall� avec succ�s de votre ordinateur."
FunctionEnd

Function un.onInit
!insertmacro MUI_UNGETLANGUAGE
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "�tes-vous certains de vouloir d�sinstaller totalement $(^Name) et tous ses composants ?" IDYES +2
  Abort
FunctionEnd

Section Uninstall
  Delete "$INSTDIR\${PRODUCT_NAME}.url"
  Delete "$INSTDIR\uninst.exe"
  Delete "$INSTDIR\indexes\extend\*"
  Delete "$INSTDIR\indexes\main\*"

  Delete "$INSTDIR\*"


  Delete "$SMPROGRAMS\Alfanous\Uninstall.lnk"
  Delete "$SMPROGRAMS\Alfanous\Website.lnk"
  Delete "$STARTMENU.lnk"
  Delete "$DESKTOP\Alfanous.lnk"
  Delete "$SMPROGRAMS\Alfanous\Alfanous.lnk"

  RMDir "$INSTDIR\indexes\main"
  RMDir "$INSTDIR\indexes\extend"
  RMDir "$SMPROGRAMS\Alfanous"
  RMDir "$INSTDIR"
  RMDir ""

  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"
  SetAutoClose true
SectionEnd