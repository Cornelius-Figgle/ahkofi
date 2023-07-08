/************************************************************************
 * @description Command-line arguement parser for Autohotkey
 * @file ArgsParser.ahk
 * @author Cornelius-Figgle
 * @date 2023-07-02
 * @version 0.1.0.0
************************************************************************/

; ===== flags & globals ======================================================

#Requires AutoHotkey v2.0
#SingleInstance Force
KeyHistory(0)

; Persistent(true)

; ===== includes =============================================================

; ===== main class ===========================================================

class CLIParse extends object {
	; loop over `Aargs`
	;	 if next item doesnt start with `Delims`, it is value for current flag
	;	 if flag has no value, it is switch (and is assigned as a bool)
	; these are saved in a map and returned

	__New(P_Aargs, P_Delims := ["-", "--"]) {
		; note: sets class attributes
		This.Aargs := P_Aargs
		This.Delims := P_Delims

		Return This.LoopArgs()
	}
	__Delete() {
	}
	
	LoopArgs() {
		AargsMap := Map()

		Loop(This.Aargs.Length) {
			If (This.IsDelim(This.Aargs[A_Index])) {
				If (This.IsDelim(This.Aargs[A_Index+1])) {
					; arg is switch
					AargsMap[This.Aargs[A_Index]] := True
				} Else {
					; arg has value
					If (IsFloat(This.Aargs[A_Index]))
						AargsMap[This.Aargs[A_Index]] := Float(This.Aargs[A_Index+1])  ; convert to float
					Else If (IsInteger(This.Aargs[A_Index]))
						AargsMap[This.Aargs[A_Index]] := Integer(This.Aargs[A_Index+1])  ; convert to integer
					Else
						AargsMap[This.Aargs[A_Index]] := This.Aargs[A_Index+1]  ; leave as string
					A_Index := A_Index++  ; increment this to avoid having to the the 'value' one again
				}
			}
		}
	
		Return AargsMap
	}

	IsDelim(P_ArgToCheck) {
		Loop (This.Delims.Length) {
			If (SubStr(P_ArgToCheck, 1, StrLen(This.Delims[A_index])) = This.Delims[A_Index])
				Return True
			Else
				continue
			Return False
		}
	}
}