/************************************************************************
 * @description The main script for Ahkofi
 * @file Main.ahk
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
bin_path := A_Temp . "\Ahkofi"
if A_IsCompiled
	base_path := bin_path
else
	base_path := src_path
TraySetIcon(base_path . "\.." . "\ico\Ahkofi.ico")

/*@Ahk2Exe-Keep
if ! DirExist(A_Temp . "\Ahkofi")
	DirCreate(A_Temp . "\Ahkofi")
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
;@Ahk2Exe-SetName Ahkofi
;@Ahk2Exe-SetOrigFilename Main.ahk
;@Ahk2Exe-SetVersion 0.1.0.0

; ===== includes =============================================================

#Include ArgsParser.ahk

; ===== main functions =======================================================

LoadMenuFile(AargsMap) {
	Loop Files base_path . "\Menus\*.ini", "FR" {
		SplitPath(A_LoopFileName, &OutFileName, &OutDir, &OutExtension, &OutNameNoExt, &OutDrive)
		MenuName := OutNameNoExt

		If (MenuName == "Default") {
			Continue
		} Else If (AargsMap[MenuName]) {
			If (Integer(IniRead(base_path . "\Menus\" . MenuName . ".ini", "config", "usePowershellList")))
				ListCmd := "powershell.exe /c "
			Else
				ListCmd := "cmd.exe /C "
			ListCmd := ListCmd . IniRead(base_path . "\Menus\" . MenuName . ".ini", "config", "listCmd")
		
			If (Integer(IniRead(base_path . "\Menus\" . MenuName . ".ini", "config", "usePowershellCmd")))
				RunCmd := "powershell.exe /c "
			Else
				RunCmd := "cmd.exe /C "
			RunCmd := ListCmd . IniRead(base_path . "\Menus\" . MenuName . ".ini", "config", "runCmd")

			Return [ListCmd, RunCmd]
		} Else {
			Continue
		}
	}
}

CreateGUI(MenuCfg) {
	MainBox := Gui("+AlwaysOnTop +ToolWindow", "Ahkofi")
	MainBox.Add("ComboBox", "vTestChoice simple", MenuCfg[1])
	return MainBox
}

Main() {
	AargsMap := CLIParse(A_Args).LoopArgs()

	MainBox := CreateGUI(LoadMenuFile(AargsMap))
	MainBox.Show()
}

; ===== function call ========================================================

if (!A_IsCompiled and A_LineFile == A_ScriptFullPath) or A_IsCompiled  ; only call function if it was ran directly (ie not #Include'd)
	Main()