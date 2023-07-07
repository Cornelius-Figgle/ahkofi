/************************************************************************
 * @description A rofi alternative for Windows (written in AutoHotkey v2)
 * @file ahkofi
 * @author Cornelius-Figgle
 * @date 2023-07-02
 * @version 0.1.0.0
************************************************************************/

; ===== flags & globals ======================================================

#Requires AutoHotkey v2.0
#SingleInstance Force
KeyHistory(0)

; Persistent(true)

src_path := "."
bin_path := A_Temp . "\ahkofi"
if A_IsCompiled
	path_base := bin_path
else
	path_base := src_path
TraySetIcon(path_base . "\ico\ahkofi.ico")

/*@Ahk2Exe-Keep
if ! DirExist(A_Temp . "\ahkofi")
	DirCreate(A_Temp . "\ahkofi")
*/

; ===== Ahk2Exe Directives ===================================================

;@Ahk2Exe-Base v2.0.2 U64 AutoHotkey64.exe
;@Ahk2Exe-ExeName ahkofi
;@Ahk2Exe-PostExec "UPX.exe" "%A_WorkFileName%"
;@Ahk2Exe-Cont  -q --all-methods --compress-icons=0, 0,, 1
;@Ahk2Exe-SetMainIcon ahkofi.ico
;@Ahk2Exe-UpdateManifest 0, ahkofi, 0.1.0.0, 0
;@Ahk2Exe-UseResourceLang 0x0809

;@Ahk2Exe-SetCompanyName Cornelius-Figgle
;@Ahk2Exe-SetCopyright MIT
;@Ahk2Exe-SetDescription 
;@Ahk2Exe-SetLanguage 0x0809
;@Ahk2Exe-SetName ahkofi
;@Ahk2Exe-SetOrigFilename ahkofi.ahk
;@Ahk2Exe-SetVersion 0.1.0.0

; ===== includes =============================================================

; ===== main functions =======================================================



; ===== function call ========================================================

if (!A_IsCompiled and A_LineFile == A_ScriptFullPath) or A_IsCompiled  ; only call function if it was ran directly (ie not #Include'd)
	MsgBox("hi")