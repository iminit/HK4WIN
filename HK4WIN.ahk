;				HK4WIN
;
;			 (Source Code)
;================================================================================
; NOTE:RUNNING THIS SCRIPT IN PRODUCTIVE ENVIRONMENT IS STRONGLY NOT RECOMMENDED
;================================================================================
;HK4WIN从4.0版本开始不再开源，但其主要源代码并未作大的改动，只是增加了用户交互界面
;使用上更为方便，如果您想查看某一功能的代码，参阅本文件即可，如有疑问请与作者联系。
; Version: 			1.0
; Finished Time:	2013-9-13 13:08:09
; Code:				UTF-8
; Platform:			1.PARTLY Tested on Windows XP Pro SP3 and Windows 8 Chinese-Simplified (32-bit)
;					2.FULLY Tested on Windows 7 Pro SP1 Chinese-Simplified (32-bit/64-bit)
;					  (Some function are available only on Windows 7 & 8)
; Author:			宋瑞华 (SONG Ruihua)
; Contact: 			hk4win@songruihua.com  &  QQ:273454295
; Website:			http://www.songruihua.com/hk4win
; 
DevCode=静怡
; 
; THIS SCRIPT HAS NOT BEEN TESTED ON OSs BELOW:
; 1. WINDOWS VISTA/2000/9X/ME
; 2. WINDOWS SERVER
; 3. OTHER WINDOWS
; 4. ANY 64-BIT OS EXCEPT WIN7&8 X64 CHS
; 5. ANY NON-SIMPLIFIED-CHINESE OS
; 6. ANY NON-WINDOWS OS
;================================================================================
; NOTE:PLEASE DO NOT REMOVE INFO ABOVE THIS LINE WHEN YOUR BUILD YOUR OWN SCRIPT
;================================================================================


























#InstallKeybdHook
#SingleInstance force
;#NoTrayIcon
#Hotstring ?
#MaxHotkeysPerInterval 3000
DisableWinKey=0

sleep,10
;s#ClipboardTimeout 2000
If(A_ScriptName!="HK4WIN.exe" && A_ScriptName!="HK4WIN.ahk" )
{
	MsgBox, 262144, HK4WIN 错误,当前主程序的文件名是：%A_ScriptName%`n主程序只能以HK4WIN.exe的文件名运行，否则可能导致 HK4WIN 出错。`n`n请您将主程序重命名为HK4WIN.exe之后重新运行。,20
	ExitApp
}

if A_ScriptDir contains %A_Temp%
{
	MsgBox, 262144, HK4WIN 错误,当前HK4WIN主程序位于：%A_ScriptDir%`n请不要在压缩包中直接运行本程序，需先将HK4WIN.exe解压缩到非系统盘。,20
	ExitApp
}


VerCurMain=1
VerCurSub=0
HK4WIN_build=2013-9-13
SysGet, MonFull, Monitor
CoordMode, Mouse, Screen
pausedbyhk=0
MOUSE_ESC_LOCK=0
DEL_ANOTHER_DEV=0
SCROLL_MENU=3
VIEW_MODE=1
AutoClick=0
kong=
WheelWaitUp=0
WheelWaitDown=0
SetTitleMatchMode 2
OSVER=%A_OSVersion%
;StartupDir=%A_AppData%\Microsoft\Windows\Start Menu\Programs\Startup
AutoShutdown_Run=0
AutoShutdown_Run_INI=0
HK4WIN_ver=%VerCurMain%.%VerCurSub%
HK4WIN_ver_build=v%HK4WIN_ver% Build %HK4WIN_build%
SetControlDelay, 50
SetKeyDelay , 50, , Play
SetKeyDelay , 50
SetMouseDelay, 50 , Play
SetMouseDelay, 50
SetWinDelay, 200
BeforRemoveToolTip=
;ReBuildIniNeed=1
TereIsIni=0
Gaming="0"
ImeClassLast=
ForbidWheel=0
SetUpBy=ZIP
Process, Exist
SelfPID = %ErrorLevel%
Process, Exist
DriveGet, OpenFDs, List , REMOVABLE
StringLen, OpenFDsOLDer_Len, OpenFDs



FileInstall, 最终用户许可协议.txt, %A_ScriptDir%\最终用户许可协议.txt , 1
;FileSetAttrib, +H, %A_ScriptDir%\最终用户许可协议.txt




If(!A_IsAdmin)
{


IfExist, %A_ScriptDir%\最终用户许可协议.txt
	{
		;FileDelete, %A_ScriptDir%\最终用户许可协议.txt
	}
	else
	{
		IfExist, %A_ScriptDir%\HK4WIN_SET.ini
			temp0=1
		IfExist, %A_ScriptDir%\hk4win-icon.ico
			temp1=1
		If(temp0="1" and temp1="1")
			goto,SkipUAC
		PlayWAV("notify")
		IfNotExist, D:\
		{
		MsgBox, 262192, HK4WIN 警告, HK4WIN 检测到当前的工作文件夹为：`n%A_ScriptDir%`n`n由于操作系统的限制（或相关文件缺失），HK4WIN 无法在该路径中以标准用户权限运行，您可以将 HK4WIN 转移到非系统分区（例如D:分区），或者如果在右键菜单中选择“以管理员身份运行”。,60
		Gosub, Exit_HK
		}
		else
		{
		;如果存在D盘开始
							FormatTime, CurrentDateTime,, yyyyMMdd_HHmmss
				NewWorkDir=D:\HK4WIN-%HK4WIN_ver%_%CurrentDateTime%
				MsgBox, 262148, HK4WIN 警告, HK4WIN 检测到当前的工作文件夹为：`n%A_ScriptDir%`n`n由于操作系统的限制（或相关文件缺失），HK4WIN 无法在该路径中以标准用户权限运行，您可以将 HK4WIN 转移到非系统分区（例如D:分区），或者在右键菜单中选择“以管理员身份运行”。`n`nHK4WIN 将自动新建文件夹%NewWorkDir%，否则您需要自己新建文件夹。`n`n　　　　　　　　　　　　　　　　　　　　　　　　　　　继续吗？
					IfMsgBox Yes
				{
					;msgbox, NewWorkDir=%NewWorkDir%
					IfNotExist, %NewWorkDir%
						FileCreateDir, %NewWorkDir%
					else
					{
						FormatTime, CurrentDateTime,, yyyyMMdd_HHmmss
						FileCreateDir, D:\HK4WIN-%HK4WIN_ver%_%CurrentDateTime%
						NewWorkDir=D:\HK4WIN-%HK4WIN_ver%_%CurrentDateTime%
						FileCreateDir, %NewWorkDir%
					}
					FileCopy, %A_ScriptDir%\HK4WIN.exe, %NewWorkDir% ,1
					sleep,2000
					IfNotExist, %NewWorkDir%\HK4WIN.exe
					{
						PlayWAV("notify")
						MsgBox, 262192, HK4WIN 警告,HK4WIN 无法完成操作，请重试！
						ExitApp
					}
					else
					{
					PlayWAV("notify")
					MsgBox, 262208,HK4WIN 警告,HK4WIN 已将自身复制到 %NewWorkDir% 中，即将重新启动！,10
					run,%NewWorkDir%\HK4WIN.exe
					ExitApp
					}
					
				}
				else
				{
					PlayWAV("notify")
					MsgBox, 262192, HK4WIN 警告, 请您新建文件夹（推荐非系统分区，例如D:），并将 HK4WIN.exe 转移到其中后，再次尝试。,60
						Gosub, Exit_HK
				}
		;如果存在D盘结束
		}
	}
SkipUAC:

}













;???????????????????????自启动 初始检查  开始??????????????????

;IfExist, C:\Windows\system32\wp.exe
;{
;If A_UserName=something
;SetTimer, wp, 30000
;}



if (A_Language = "0804")
	ProgramFolderName=程序
else
	ProgramFolderName=Programs


	
	

	
	
	
	
	
IfNotExist, %A_ScriptDir%\HK4WIN_SET.ini
{
	FileList =  ; Initialize to be blank.
Loop,%A_ScriptDir%\*
    FileList = %FileList%%A_LoopFileName%
StringReplace, FileList, FileList, HK4WIN.exe
StringReplace, FileList, FileList, HK4WIN.ahk
StringReplace, FileList, FileList, HK4WIN 使用说明.htm
StringReplace, FileList, FileList, HK4WIN_LU.exe
StringReplace, FileList, FileList, 最终用户许可协议.txt
StringReplace, FileList, FileList, hk4win-icon.ico
StringReplace, FileList, FileList, hk4win-logo.png
StringReplace, FileList, FileList, 更新详情.txt
StringReplace, FileList, FileList, Everything.lng
StringReplace, FileList, FileList, Everything.exe
StringReplace, FileList, FileList, Everything86.exe
StringReplace, FileList, FileList, Everything64.exe
StringReplace, FileList, FileList, Everything.ini
StringReplace, FileList, FileList, BingDesktopWallpapers
StringReplace, FileList, FileList, OlderVersion
StringReplace, FileList, FileList, HK4WIN_SET.ini
StringReplace, FileList, FileList, HK4WIN_LU_NEW.exe
StringReplace, FileList, FileList, HK4WIN_SD.vbs
StringReplace, FileList, FileList, olinfo.ini
StringReplace, FileList, FileList, LUTEMP
StringReplace, FileList, FileList, 最终用户许可协议.txt
	;msgbox,FileList=%FileList%
If (FileList="")
	{
	;msgbox,OK to be continue
	}
else
	{
	;msgbox,Opps,other files found
	FormatTime, CurrentDateTime,, yyyyMMdd_HHmmss
	NewWorkDir=%A_ScriptDir%\HK4WIN-%HK4WIN_ver%_%CurrentDateTime%
	MsgBox, 262148, HK4WIN 警告,HK4WIN 发现当前的工作文件夹 %A_ScriptDir% 中存在其他文件(夹)。`n这可能导致 HK4WIN 出错，请您新建一个独立的空白文件夹。`n`nHK4WIN 将自动新建文件夹：`n%NewWorkDir% `n`n　　　　　　　　　　　　　　　　　　　　　　　　　　　继续吗？
		IfMsgBox Yes
	{
		;msgbox, NewWorkDir=%NewWorkDir%
		IfNotExist, %NewWorkDir%
			FileCreateDir, %NewWorkDir%
		else
		{
			FormatTime, CurrentDateTime,, yyyyMMdd_HHmmss
			FileCreateDir, %A_ScriptDir%\HK4WIN-%HK4WIN_ver%_%CurrentDateTime%
			NewWorkDir=%A_ScriptDir%\HK4WIN-%HK4WIN_ver%_%CurrentDateTime%
			FileCreateDir, %NewWorkDir%
		}
		FileCopy, %A_ScriptDir%\HK4WIN.exe, %NewWorkDir% ,1
		sleep,2000
		IfNotExist, %NewWorkDir%\HK4WIN.exe
		{
			PlayWAV("notify")
			MsgBox, 262192, HK4WIN 警告,HK4WIN 无法完成操作，请重试！
			ExitApp
		}
		else
		{
		PlayWAV("notify")
		MsgBox, 262208,HK4WIN 警告,HK4WIN 已将自身复制到 %NewWorkDir% 中，即将重新启动！,10
		run,%NewWorkDir%\HK4WIN.exe
		ExitApp
		}
		
	}
	else
	{
		PlayWAV("notify")
		FileDelete, %A_ScriptDir%\最终用户许可协议.txt
		MsgBox, 262192, HK4WIN 警告, 请您新建独立文件夹，并将 HK4WIN.exe 转移到其中后，再次尝试。,60
			Gosub, Exit_HK
	}
	}
FileInstall, hk4win-icon.ico, %A_ScriptDir%\hk4win-icon.ico , 1
FileInstall, HK4WIN_LU.exe, %A_ScriptDir%\HK4WIN_LU.exe , 0
FileInstall, HK4WIN 使用说明.htm, %A_ScriptDir%\HK4WIN 使用说明.htm , 1
FileInstall, 更新详情.txt, %A_ScriptDir%\更新详情.txt , 1
FileInstall, Everything.lng, %A_ScriptDir%\Everything.lng
FileInstall, Everything64.exe, %A_ScriptDir%\Everything64.exe
FileInstall, Everything86.exe, %A_ScriptDir%\Everything86.exe
If(A_Is64bitOS)
{
FileMove, %A_ScriptDir%\Everything64.exe, %A_ScriptDir%\Everything.exe, 1
FileDelete, %A_ScriptDir%\Everything86.exe
;UrlDownloadToFile, http://www.songruihua.com/hk4win-everything-x64, %A_ScriptDir%\EVTtest\Everything64.exe
}
else
{
FileMove, %A_ScriptDir%\Everything86.exe, %A_ScriptDir%\Everything.exe, 1
FileDelete, %A_ScriptDir%\Everything64.exe
;UrlDownloadToFile, http://www.songruihua.com/hk4win-everything-x86, %A_ScriptDir%\EVTtest\Everything86.exe
}
FileInstall, Everything.ini, %A_ScriptDir%\Everything.ini
FileInstall, hk4win-logo.png, %A_ScriptDir%\hk4win-logo.png , 1
FileSetAttrib, +H, %A_ScriptDir%\hk4win-icon.ico
FileSetAttrib, +H, %A_ScriptDir%\HK4WIN_LU.exe
FileSetAttrib, +H, %A_ScriptDir%\hk4win-logo.png
	GoSub,CREATE_INI
Menu, Tray, NoStandard
Menu, Tray, Add, 使用说明,SHOW_README
Menu, Tray, Add
Menu, Tray, Add, 定时关机,ASD_START
if A_OSVersion not in WIN_8,WIN_9
{




	RegRead, HIDDEN_REG_1, HKEY_CURRENT_USER, SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\Folder\Hidden\SHOWALL , CheckedValue
	RegRead, HIDDEN_REG_2, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden
	if (HIDDEN_REG_1="1" and HIDDEN_REG_2="1")
	{
		Menu, Tray, Add, 不显示隐藏的文件和文件夹,ShowHide
		ShowHideStatus=0
	}
	else
	{
		Menu, Tray, Add, 显示所有文件和文件夹,ShowHide
		ShowHideStatus=1
	}
}
Menu, Tray, Add, 添加和删除程序,AppWiz
;Menu, Tray, Add, 系统用户设置,WinUserAcc
Menu, Tray, Add, 禁用WIN键,F12NoWin
Menu, Tray, Add, 黑屏,BlackScreen
Menu, Tray, Add, 黑屏并锁定,BlackScreenLock
Menu, Tray, Add
Menu, Tray, Add, 设置快捷键,OpenINI
Menu, Tray, Add, 重启 HK4WIN,Want2Restart
Menu, Tray, Add, 暂停 HK4WIN,Pause_HK4WIN
Menu, Tray, Add, 退出 HK4WIN,Want2Exit
Menu, Tray, Add
Menu, Tray, Add, 在线留言,CmtOnline_HK4WIN
Menu, Tray, Add, 关于,ShowVersion_HK4WIN
Menu, Tray, Add, 捐助,Donate_HK4WIN


Menu, Tray, Default, 使用说明
Menu, Tray, Click, 1 ;单击打开托盘图标
Menu, Tray, Tip, HK4WIN
Menu, Tray, icon,hk4win-icon.ico

}
else
{

;否则已存在ini文件
FileInstall, hk4win-icon.ico, %A_ScriptDir%\hk4win-icon.ico , 1
FileInstall, HK4WIN 使用说明.htm, %A_ScriptDir%\HK4WIN 使用说明.htm , 1
FileInstall, 更新详情.txt, %A_ScriptDir%\更新详情.txt , 1
FileInstall, Everything.lng, %A_ScriptDir%\Everything.lng
FileInstall, Everything64.exe, %A_ScriptDir%\Everything64.exe
FileInstall, Everything86.exe, %A_ScriptDir%\Everything86.exe
If(A_Is64bitOS)
{
FileMove, %A_ScriptDir%\Everything64.exe, %A_ScriptDir%\Everything.exe, 1
FileDelete, %A_ScriptDir%\Everything86.exe
;UrlDownloadToFile, http://www.songruihua.com/hk4win-everything-x64, %A_ScriptDir%\EVTtest\Everything64.exe
}
else
{
FileMove, %A_ScriptDir%\Everything86.exe, %A_ScriptDir%\Everything.exe, 1
FileDelete, %A_ScriptDir%\Everything64.exe
;UrlDownloadToFile, http://www.songruihua.com/hk4win-everything-x86, %A_ScriptDir%\EVTtest\Everything86.exe
}
FileInstall, Everything.ini, %A_ScriptDir%\Everything.ini
FileInstall, hk4win-logo.png, %A_ScriptDir%\hk4win-logo.png , 1
FileSetAttrib, +H, %A_ScriptDir%\hk4win-icon.ico
FileSetAttrib, +H, %A_ScriptDir%\hk4win-logo.png

Menu, Tray, NoStandard
Menu, Tray, Add, 使用说明,SHOW_README
Menu, Tray, Add
Menu, Tray, Add, 定时关机,ASD_START

if A_OSVersion not in WIN_8,WIN_9
{
	RegRead, HIDDEN_REG_1, HKEY_CURRENT_USER, SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\Folder\Hidden\SHOWALL , CheckedValue
	RegRead, HIDDEN_REG_2, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden
	if (HIDDEN_REG_1="1" and HIDDEN_REG_2="1")
	{
		Menu, Tray, Add, 不显示隐藏的文件和文件夹,ShowHide
		ShowHideStatus=0
	}
	else
	{
		Menu, Tray, Add, 显示所有文件和文件夹,ShowHide
		ShowHideStatus=1
	}
}
Menu, Tray, Add, 添加和删除程序,AppWiz
;Menu, Tray, Add, 系统用户设置,WinUserAcc
Menu, Tray, Add, 禁用WIN键,F12NoWin
Menu, Tray, Add, 黑屏,BlackScreen
Menu, Tray, Add, 黑屏并锁定,BlackScreenLock
Menu, Tray, Add
Menu, Tray, Add, 设置快捷键,OpenINI
Menu, Tray, Add, 重启 HK4WIN,Want2Restart
Menu, Tray, Add, 暂停 HK4WIN,Pause_HK4WIN
Menu, Tray, Add, 退出 HK4WIN,Want2Exit
Menu, Tray, Add
Menu, Tray, Add, 在线留言,CmtOnline_HK4WIN
Menu, Tray, Add, 关于,ShowVersion_HK4WIN
Menu, Tray, Add, 捐助,Donate_HK4WIN
;Menu, Tray, Add, 以管理员身份运行,ToggleRunAsAdmin


Menu, Tray, Default, 使用说明
Menu, Tray, Click, 1 ;单击打开托盘图标
Menu, Tray, Tip, HK4WIN
Menu, Tray, icon,hk4win-icon.ico




	TereIsIni=1
	IniRead, IniCreatedByMain, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,IniCreatedByMain
	IniRead, IniCreatedBySub, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,IniCreatedBySub
	;msgbox,IniCreatedByMain=%IniCreatedByMain% and IniCreatedBySub=%IniCreatedBySub%
	If (IniCreatedByMain="ERROR" or IniCreatedByMain="ERROR")
	{
		;msgbox,IniCreatedBy=none
		FileReadLine, line2, %A_ScriptDir%\HK4WIN_SET.ini, 2
		StringMid, line2verMain, line2, 14, 1
		StringMid, line2verSub, line2, 16, 1
		if line2verMain between 0 and 99
			flag1=true
		else
			flag1=false
		if line2verSub between 1 and 99
			flag2=true
		else
			flag2=false
		If(flag1="true" and flag2="true")
			{
				IniCreatedByMain=%line2verMain%
				IniCreatedBySub=%line2verSub%
			}
		else
			{
				MsgBox, 262192, HK4WIN INI配置文件出错！！！,INI配置文件出错，请删除HK4WIN_SET.ini，然后重新启动HK4WIN。
				GoSub,Exit_HK
			}
		;msgbox,111@%IniCreatedByMain%@%IniCreatedBySub%
		If((IniCreatedByMain<VerCurMain)or((IniCreatedByMain=VerCurMain)and(IniCreatedBySub<VerCurSub)))
		GoSub,ReBuildIni
	}
	else If (IniCreatedByMain<>"ERROR" and IniCreatedBySub<>"ERROR")
	{
		;msgbox,222@%IniCreatedByMain%@%IniCreatedBySub%
		If((IniCreatedByMain<VerCurMain)or((IniCreatedByMain=VerCurMain)and(IniCreatedBySub<VerCurSub)))
		GoSub,ReBuildIni
	}
	else
	{
		MsgBox, 262192, HK4WIN INI配置文件出错！！！,INI配置文件出错，请删除HK4WIN_SET.ini，然后重新启动HK4WIN。
		GoSub,Exit_HK
	}
	
}
	






GoSub,Read_FnSwitch	




	





IniRead, GPL_Accepted, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,GPL_Accepted




If (GPL_Accepted="0" and TereIsIni="0")
{
If CanSkipGPL=1
{
IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,GPL_Accepted
			Goto,SKIP_GPL
}
;
Process, Exist,Kwatch.exe
if ErrorLevel
	flag1=1
else
	flag1=0
Process, Exist,KsafeTray.exe
if ErrorLevel
	flag2=1
else
	flag2=0
Process, Exist,kissvc.exe
if ErrorLevel
	flag3=1
else
	flag3=0
;msgbox,flag0=%flag1%*%flag2%*%flag3%


Process, Exist,uiSeAgnt.exe
if ErrorLevel
	flag4=1
else
	flag4=0


If (flag1==1 or flag2==1 or flag3==1 or flag4==1)
    msgbox,262192,HK4WIN 警告,HK4WIN检测到您正在使用的安全类软件会错误地将HK4WIN判别为恶意软件，请您将HK4WIN标识为可信任。`n`nHK4WIN的源代码已公布，请访问www.songruihua.com/hk4win获取，源代码中绝对恶意代码。

		If SetUpBy=EXE
		{
			
		IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,GPL_Accepted
		Goto,SKIP_GPL
		}
tooltip
Reask_GPL:
Suspend,On
SetTimer, ChangeButtonNames_GPL, 50
MsgBox, 262148, HK4WIN [ %HK4WIN_ver_build% ],`n                                    HK4WIN 软件最终用户许可协议`n`n`n　　HK4WIN 会根据您的键盘和鼠标操作向操作系统发出一系列指令，以帮助您简化计算机的使用，让您能够快速打开程序，访问网站，打开文件或文件夹，快速输入常用词汇，对计算机进行设置等。但是在某些不可预知的情况下，这些被发出的指令可能并不能实现预期的功能，其所带来的结果亦难以预知，某些结果可能出乎您的预料，并可能损害您的利益，因此不建议您在生产环境中使用。如您接受此协议则表明您已了解并愿意自行承担此种风险。`n`n　　宋瑞华按照 CC-GNU GPL 协议授权用户使用 HK4WIN 。`n　　详细内容请参见 www.songruihua.com/hk4win-license`n　　在上述 CC-GNU GPL 协议基础之上，另附以下内容：`n　　HK4WIN 软件作者宋瑞华明示不为 HK4WIN 软件做任何担保。本软件及任何相关文件以“即此”形式提供，无任何明示的或暗示的担保，包括（但不限于）对可销售性、某一目的的适用性或无侵权的暗示担保。`n　　使用 HK4WIN 软件所引起的全部风险由您自己承担。宋瑞华在任何情况下均不就因使用或不能使用本产品所引起的任何损害赔偿（包括但不限于营业利润损失、营业中断、商业信息的遗失或任何其他金钱上的损失），即使宋瑞华事先被告知该损害发生的可能性。`n　　您一旦安装、复制、点击下面的“我同意”按钮或以其它方式使用本软件，即表示您同意接受本协议。如您不同意本协议中的条件，请不要使用。`n`n　　如有任何疑问或建议，请联系我：`n　　QQ:273454295　Email:hk4win@songruihua.com`n　　或访问官方网站 www.songruihua.com/hk4win`n`n`n                                                              您是否同意接受上述协议？
	IfMsgBox Yes
	{
		IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,GPL_Accepted
		Suspend,Off
	}
	else
	{
		PlayWAV("notify")
		MsgBox, 262180, HK4WIN 提醒, 如果您不接受此协议，则不能继续使用 HK4WIN。`n`n您要继续使用 HK4WIN 吗？
		IfMsgBox Yes
			Goto,Reask_GPL
		else
		{
			FileDelete, %A_ScriptDir%\HK4WIN_SET.ini
			FileDelete, %A_ScriptDir%\hk4win-icon.ico
			FileDelete, %A_ScriptDir%\hk4win-logo.png
			FileDelete, %A_ScriptDir%\HK4WIN 使用说明.htm
			FileDelete, %A_ScriptDir%\HK4WIN_LU.exe
			FileDelete, %A_ScriptDir%\更新详情.txt
			FileDelete, %A_ScriptDir%\Everything.lng
			FileDelete, %A_ScriptDir%\Everything64.exe
			FileDelete, %A_ScriptDir%\Everything86.exe
			FileDelete, %A_ScriptDir%\Everything.exe
			FileDelete, %A_ScriptDir%\Everything.ini
			FileDelete, %A_ScriptDir%\最终用户许可协议.txt

			;;;msgbox,showme111
			Gosub, SHOW_README
			Gosub, Exit_HK
		}
			
	}
SKIP_GPL:
}
;;;THE END of If GPL_Accepted=0











;;;;;;;;;;;;;;;;;;;;;;;;;;;;;admin()
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;{

IniRead, RunAsAdmin, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,RunAsAdmin
;RegRead, UACregVal, HKEY_LOCAL_MACHINE, SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System , EnableLUA
If(A_OSVersion!="WIN_XP" && !A_IsAdmin && RunAsAdmin!=0)
{
;msgbox,RunAsAdmin==%RunAsAdmin%
	
	;msgbox,UACregVal==%UACregVal%
	If(UACregVal=0)
	{
		
		RunHK4WINAsAdmin()
	}
	else
	{
			RunHK4WINAsAdmin()
			;;;;;;;;;;MsgBox, 262180, HK4WIN 管理员, HK4WIN 的某些功能只能在取得管理员权限的情况下才能正常使用！`n您完全无需担心安全问题，HK4WIN是开源软件，所有源代码均已公开。`n`n以管理员身份运行 HK4WIN 吗？`n`n`n`n提示：HK4WIN的大部分功能不需要管理员权限，但部分功能需要，例如“安全删除硬件”功能，同时如果不赋予HK4WIN管理员权限，那么HK4WIN就无法与其他以管理员权限运行的程序交互，例如鼠标左键加右键秒杀窗口功能以及安全删除硬件功能，如果您需要这些功能那么推荐选择 "是"，但每次启动HK4WIN时您都会遇到用户账户控制（UAC）提示对话框，这可能对您造成困扰，如果您不需要这些功能请选择“否”。
			;;;;;;;;;	IfMsgBox Yes
			;;;;;;;;;	{
			;;;;;;;;;		
			;;;;;;;;;		IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,RunAsAdmin
			;;;;;;;;;		MsgBox, 262192, HK4WIN 管理员, 从现在开始，HK4WIN 会以管理员身份运行。`n`n如果您要取消此项设置（即以标准用户运行），请右键托盘图标，点击“设置快捷键“，搜索RunAsAdmin，将其等号后的数字改为0，保存后重启HK4WIN。
			;;;;;;;;;		;Menu, Tray, Check, 以管理员身份运行
			;;;;;;;;;			RunHK4WINAsAdmin()
			;;;;;;;;;			
			;;;;;;;;;	}
			;;;;;;;;;	else
			;;;;;;;;;	{
			;;;;;;;;;	IniWrite,0, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,RunAsAdmin
			;;;;;;;;;	;Menu, Tray, UnCheck, 以管理员身份运行
			;;;;;;;;;	MsgBox , 262192, HK4WIN 管理员,HK4WIN未能获取管理员权限，这可能导致部分功能无法运行。
			;;;;;;;;;	MsgBox, 262192, HK4WIN 管理员, 从现在开始，HK4WIN 会以标准用户（非管理员）身份运行。`n`n如果您要取消此项设置（即以管理员身份运行），请右键托盘图标，点击“设置快捷键“，搜索RunAsAdmin，将其等号后的数字改为1，保存后重启HK4WIN。
			;;;;;;;;;	}
	}




		
}
else If(A_OSVersion!="WIN_XP" && !A_IsAdmin && RunAsAdmin=1)
{

		RunHK4WINAsAdmin()
}
else If(!A_IsAdmin && RunAsAdmin=0)
{

}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;}




for process in ComObjGet("winmgmts:").ExecQuery("Select * from Win32_Process  where Name = 'HK4WIN.exe'")
   AllPID .= process.ProcessId ""
SelfPID := DllCall("GetCurrentProcessId")

StringReplace,AnotherPID,AllPID,%SelfPID%
If (AnotherPID<>"")
{
		MsgBox, 262452, HK4WIN 警告, HK4WIN检测到另外一个 HK4WIN 进程正在运行，必须结束先前的进程以重新运行 HK4WIN 。`n警告：某些设置（例如定时关机）可能因此失效。`n`n`n                                                                           继续吗？
		IfMsgBox Yes
		{
			Process, close, %AnotherPID%
			Process, WaitClose, %AnotherPID%, 7
			if ErrorLevel=0
			tooltip,先前的 HK4WIN 进程已被结束
			sleep,1500
			tooltip,HK4WIN 正在启动...
			sleep,1500
			tooltip
			CanSkipGPL=1
			CanSkipReg=1
		}
		else
		{
			ExitApp
		}
}



















If(A_OSVersion!="WIN_XP" && A_IsAdmin)
	StartTip=(A)
else
	StartTip=


SysGet, MonFull, Monitor
tooltip,HK4WIN 已启动 %StartTip%
RegRead, OpenNewFlashDisk_RegValue, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\UserChosenExecuteHandlers\StorageOnArrival
If(OpenNewFlashDisk_RegValue!="MSOpenFolder")
SetTimer,OpenNewFlashDisk,1200

sleep,1000
tooltip

IniRead, HideTrayIcon, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,HideTrayIcon
If(HideTrayIcon="1")
	{
	menu, tray, NoIcon
	}
IniRead, LU_CheckDate, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,LU_CheckDate
If (LU_CheckDate="NEVER")
{
	;msgbox,第一次启动，60s后检查更新
	SetTimer,LaunchLU,-60000
	SetTimer,Bing,-150000
}
else
	{
		IniRead, DisableLiveUpdate_V, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,DisableLiveUpdate
		If DisableLiveUpdate_V<>1
		{
			;msgbox,第n次启动，10min后检查更新
			SetTimer,LaunchLU,-600000
			SetTimer,Bing,-150000
		}
			
	}
;;;THE END of If (LU_CheckDate

	
	
IniRead, AutoShutdownTime, %A_ScriptDir%\HK4WIN_SET.ini,UserSetting,AutoShutdownTime
		If AutoShutdownTime<>
		{
		 IfInString, AutoShutdownTime, :
			{
				StringSplit, as_time, AutoShutdownTime, `:,%A_Space%
				GoSub,as_time_format_AutoRun
				
			}
		else IfInString, AutoShutdownTime, ：
			{
				StringSplit, as_time, AutoShutdownTime, `：,%A_Space%
				GoSub,as_time_format_AutoRun	
				
			}
		else
			{
			AutoShutdown_Run_INI=0
		MsgBox, 262160, HK4WIN 定时关机 输入有误, 您输入的定时关机时间格式错误：`nAutoShutdownTime=%AutoShutdownTime%`n`n请重新设置，正确的格式有：`nAutoShutdownTime=6:05`nAutoShutdownTime=23:45`n`n取消自动关机请留空，即`nAutoShutdownTime=
		GoSub,OpenINI
		;sleep,2000
		
				Send, {CTRLDOWN}f{CTRLUP}
				sleep,200
				SendInput {Raw}AutoShutdownTime
				sleep,300
				Send, {Enter}
				;Send, {Tab 4}{Enter}
			}
		
		}
;;;THE END of If AutoShutdownTime
;======================================XP自启动   开始=====================
If CanSkipReg=1
	{
	RegRead, CURRENT_RUN, HKEY_CURRENT_USER, SOFTWARE\Microsoft\Windows\CurrentVersion\Run , HK4WIN
	If (CURRENT_RUN<>0)
		{
		RegWrite, REG_SZ,HKEY_CURRENT_USER,SOFTWARE\Microsoft\Windows\CurrentVersion\Run, HK4WIN, %A_ScriptFullPath%
		Goto,SkipReg
		}
	}
If REG_SAME()=0
{
IniRead, AskAutoStartHK4WIN_V, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,AskAutoStartHK4WIN
				If(AskAutoStartHK4WIN_V="0")
					Goto,SkipReg
PlayWAV("notify")
sleep,120
PlayWAV("notify")
sleep,120
PlayWAV("notify")
;;MsgBox, 256, HK4WIN, HK4WIN已启动，您的电脑操作体验将焕然一新！`n`n%HK4WIN_ver_build%,5
;;sleep,600
;;tooltip
MsgBox, 262180, HK4WIN 开机自启动, HK4WIN 已启动，您的电脑操作体验将焕然一新！`n`n开机自动运行 HK4WIN 吗？（推荐选择 "是" )
	IfMsgBox Yes
		{
		RegWrite, REG_SZ,HKEY_CURRENT_USER,SOFTWARE\Microsoft\Windows\CurrentVersion\Run, HK4WIN, %A_ScriptFullPath%
		;MsgBox, 64, HK4WIN开机启动, HK4WIN开机启动功能已打开。`n注意：请不要移动HK4WIN的位置或重命名，否则开机启动会失效。`n它位于 %A_ScriptFullPath%,10
		SysGet, MonFull, Monitor
		;;;tooltip,HK4WIN : 开机自启动已打开
		TrayTip , HK4WIN,开机自启动已打开 , 5, 1
		;;sleep,1000
		;;;;tooltip
		;;;;;tooltip,HK4WIN : 如果改变 HK4WIN 的位置或重命名，开机自启动会失效。`n它位于  %A_ScriptFullPath%
		;;sleep,7500
		;;;;;;tooltip
		IfNotExist, %A_StartMenu%\%ProgramFolderName%\HK4WIN\
		GoSub,Create_Shortlinks
		;;msgbox,showme22222
		run,www.songruihua.com/hk4win-donate
		sleep,1000
		GoSub,SHOW_README
		sleep,3000
		GoSub,POP_SFT_LABEL
		}
	else
		{

		
		
		
		if AskAutoStartHK4WIN_V not in 0,1,2
			IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,AskAutoStartHK4WIN
		else If(AskAutoStartHK4WIN_V="1")
			IniWrite, 2, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,AskAutoStartHK4WIN
		else If(AskAutoStartHK4WIN_V="2")
			IniWrite, 0, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,AskAutoStartHK4WIN

		
				If(AskAutoStartHK4WIN_V!="0")
				{
				
					MsgBox, 262192, HK4WIN开机启动, HK4WIN已启动，但开机启动功能未打开。`n下次开机后您需要手动打开HK4WIN，它位于 %A_ScriptFullPath%`n如需打开自启动请按Ctrl+Alt+Shift+R,20
		
					RegWrite, REG_SZ,HKEY_CURRENT_USER,SOFTWARE\Microsoft\Windows\CurrentVersion\Run, HK4WIN, 0
					IfNotExist, %A_StartMenu%\%ProgramFolderName%\HK4WIN\
					GoSub,Create_Shortlinks
					;;;;msgbox,showme3333
					;run,www.songruihua.com/hk4win-donate
					Run, www.songruihua.com/hk4win-donate
					sleep,1000
					GoSub,SHOW_README
					sleep,3000
					GoSub,POP_SFT_LABEL
				}
		}
				
						
				
}
else
{

sleep,600
tooltip
		IfNotExist, %A_StartMenu%\%ProgramFolderName%\HK4WIN\
		GoSub,Create_Shortlinks

}
;;THE END of If REG_SAME()=0
SkipReg:
IfExist, %A_StartMenu%\%ProgramFolderName%\HK4WIN\
	GoSub,Refresh_Shortlinks










	
;msgbox,the end of autorun
return
;msgbox,the end of autorun222

 
POP_SFT_LABEL:



IniRead, ACAD_dir, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,ACAD_dir
IniRead, AdobeReader_dir, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,AdobeReader_dir
IniRead, SEP_dir, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,SEP_dir
IniRead, QQ_dir, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,QQ_dir
IniRead, Thunder_dir, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,Thunder_dir
IniRead, WINWORD_dir, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,WINWORD_dir
IniRead, OUTLOOK_dir, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,OUTLOOK_dir
IniRead, EXCEL_dir, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,EXCEL_dir
IniRead, PPT_dir, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,PPT_dir
IniRead, PhotoShop_dir, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,Photoshop_dir
IniRead, Storm_dir, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,Storm_dir
IniRead, TTPlayer_dir, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,TTPlayer_dir
IniRead, Picasa_dir, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,Picasa_dir
IniRead, CCleaner_dir, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,CCleaner_dir
IniRead, PVZ_dir, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,PVZ_dir
IniRead, PPLive_dir, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,PPLive_dir
IniRead, chrome_dir, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,chrome_dir
IniRead, IDMan_dir, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,IDMan_dir
IniRead, EverNote_dir, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,EverNote_dir
IniRead, AngryBirds_dir, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,AngryBirds_dir
IniRead, notepad2_dir, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,notepad2_dir
IniRead, Firefox_dir, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,Firefox_dir
IniRead, Opera_dir, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,Opera_dir
IniRead, MSE_dir, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,MSE_dir

POP_SFT=在您的计算机上检测到以下软件（可自定义），按相应的快捷键可启动。`n`n`nLCtrl+LAlt+1	PowerPoint`nLCtrl+LAlt+2	OutLook`nLCtrl+LAlt+3	Excel`nLCtrl+LAlt+4	暴风影音`nLCtrl+LAlt+5	植物大战僵尸`nLCtrl+LAlt+6	PPLive`nLCtrl+LAlt+7	千千静听`nLCtrl+LAlt+8	Chrome`nLCtrl+LAlt+9	Picasa`nLCtrl+LAlt+0	CCleaner`nLCtrl+LAlt+B	愤怒的小鸟`nLCtrl+LAlt+C	计算器`nLCtrl+LAlt+D	Internet Download Manager`nLCtrl+LAlt+E	IE浏览器`nLCtrl+LAlt+F	Firefox`nLCtrl+LAlt+H	PhotoShop`nLCtrl+LAlt+I	AutoCAD`nLCtrl+LAlt+M	Media Player`nLCtrl+LAlt+N	Notepad(记事本)`nLCtrl+LAlt+Shift+N	Notepad++`nLCtrl+LAlt+O	Opera`nLCtrl+LAlt+P	Paint(画图)`nLCtrl+LAlt+Q	QQ即时通讯`nLCtrl+LAlt+R	Adobe Reader`nLCtrl+LAlt+S	SEP赛门铁克端点防护`nLCtrl+LAlt+T	Thunder(迅雷)`nLCtrl+LAlt+U	EverNote`nLCtrl+LAlt+V	MSE`nLCtrl+LAlt+W	Word`n`n`nLCtrl为左侧的Ctrl键，LAlt为左侧的Alt键。`n右侧的RCtrl+RAlt+?则用于打开常用网页（可自定义）。`n如果发生快捷键冲突，可在自定义中删除相应的快捷键。`n`n右键单击系统托盘图标（或按Ctrl+Alt+Shift+Z）可自定义 HK4WIN 的快捷键，现在就自定义吗？
If ACAD_dir=
	StringReplace, POP_SFT, POP_SFT, `nLCtrl+LAlt+I	AutoCAD
If AdobeReader_dir=
	StringReplace, POP_SFT, POP_SFT, `nLCtrl+LAlt+R	Adobe Reader
If QQ_dir=
	StringReplace, POP_SFT, POP_SFT, `nLCtrl+LAlt+Q	QQ即时通讯
If SEP_dir=
	StringReplace, POP_SFT, POP_SFT, `nLCtrl+LAlt+S	SEP赛门铁克端点防护
If Thunder_dir=
	StringReplace, POP_SFT, POP_SFT, `nLCtrl+LAlt+T	Thunder(迅雷)
If WINWORD_dir=
	StringReplace, POP_SFT, POP_SFT, `nLCtrl+LAlt+W	Word
If EXCEL_dir=
	StringReplace, POP_SFT, POP_SFT, `nLCtrl+LAlt+3	Excel
If PPT_dir=
	StringReplace, POP_SFT, POP_SFT, `nLCtrl+LAlt+1	PowerPoint
If OUTLOOK_dir=
	StringReplace, POP_SFT, POP_SFT, `nLCtrl+LAlt+2	OutLook
If PhotoShop_dir=
	StringReplace, POP_SFT, POP_SFT, `nLCtrl+LAlt+H	PhotoShop
If Storm_dir=
	StringReplace, POP_SFT, POP_SFT, `nLCtrl+LAlt+4	暴风影音
If PVZ_dir=
	StringReplace, POP_SFT, POP_SFT, `nLCtrl+LAlt+5	植物大战僵尸
If PPLive_dir=
	StringReplace, POP_SFT, POP_SFT, `nLCtrl+LAlt+6	PPLive
If TTPlayer_dir=
	StringReplace, POP_SFT, POP_SFT, `nLCtrl+LAlt+7	千千静听
If chrome_dir=
	StringReplace, POP_SFT, POP_SFT, `nLCtrl+LAlt+8	Chrome
If Picasa_dir=
	StringReplace, POP_SFT, POP_SFT, `nLCtrl+LAlt+9	Picasa
If CCleaner_dir=
	StringReplace, POP_SFT, POP_SFT, `nLCtrl+LAlt+0	CCleaner
If AngryBirds_dir=
	StringReplace, POP_SFT, POP_SFT, `nLCtrl+LAlt+B	愤怒的小鸟
If IDMan_dir=
	StringReplace, POP_SFT, POP_SFT, `nLCtrl+LAlt+D	Internet Download Manager
If EverNote_dir=
	StringReplace, POP_SFT, POP_SFT, `nLCtrl+LAlt+U	EverNote
If notepad2_dir=
	StringReplace, POP_SFT, POP_SFT, `nLCtrl+LAlt+Shift+N	Notepad++
If Firefox_dir=
	StringReplace, POP_SFT, POP_SFT, `nLCtrl+LAlt+F	Firefox
If Opera_dir=
	StringReplace, POP_SFT, POP_SFT, `nLCtrl+LAlt+O	Opera	
If MSE_dir=
	StringReplace, POP_SFT, POP_SFT, `nLCtrl+LAlt+V	MSE	
	
	
PlayWAV("ding")	
msgbox,262148,HK4WIN 快捷键提示,%POP_SFT%
IfMsgBox, Yes
{
	sleep,500
	GoSub,OpenINI
}
else
{
SysGet, MonFull, Monitor
	;tooltip,您可随时按 Ctrl+Alt+Shift+Z 自定义 HK4WIN 的快捷键。
;SetTimer, RemoveToolTip, 4500
TrayTip , HK4WIN,您可随时按 Ctrl+Alt+Shift+Z 自定义 HK4WIN 的快捷键。 , 10, 1
}
;Bing desktop
If(A_OSVersion="WIN_7")
{
	IniRead, BingDir, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,BingDir
	IfExist, %BingDir%
	{
		MsgBox, 262180, HK4WIN,HK4WIN 检测到您安装了微软Bing Desktop软件，这款软件可以每天将Bing搜索引擎的背景设为您的桌面壁纸，但是却不能保存过往的壁纸，如果您只是想要获取Bing的壁纸而不想使用其搜索服务，HK4WIN提供以下功能：每天HK4WIN随电脑启动后，待Bing Desktop完成下载并设为桌面壁纸的工作，HK4WIN会将新下载的图片复制到自身目录下的BingDesktopWallpapers文件夹，然后关闭Bing Desktop。`n注意：Bing Desktop默认会随开机自行启动，请保持此项默认设置，因为任何情况下HK4WIN都不会主动运行Bing Desktop，只会在复制新图片后将其关闭。`n`n您需要此项功能吗？
		IfMsgBox Yes
		{
			IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,BingWallpaperBackup
		}
		else
		{
			IniWrite, 0, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,BingWallpaperBackup
		}
	}
}
return

Bing:
If(A_OSVersion="WIN_7")
{
	IniRead, temp1, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,BingWallpaperBackup
	If(temp1<>"0" and temp1<>"")
	{
	
		StringTrimRight, temp2, A_AppData, 8
		BWP=%temp2%\Local\Microsoft\BingDesktop\themes\image.jpg
		IfNotExist,%BWP%
			return
		FileGetTime, BWPdate,%BWP%
		IniRead, BingLastDate, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,BingLastDate
		If(BWPdate>BingLastDate)
		{
		IfNotExist, %A_ScriptDir%\BingDesktopWallpapers
			FileCreateDir, %A_ScriptDir%\BingDesktopWallpapers
		FileCopy, %BWP%, %A_ScriptDir%\BingDesktopWallpapers\Bing-%BWPdate%.jpg
		IniWrite, %BWPdate%, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,BingLastDate
		Process, Exist,BingDesktop.exe
		if ErrorLevel
			Process, close, BingDesktop.exe
		}
		
	}
}
return



RemoveToolTip:
SetTimer, RemoveToolTip, Off
If (BeforRemoveToolTip<>"")
{
ToolTip,%BeforRemoveToolTip%
sleep,1000
BeforRemoveToolTip=
}
ToolTip
return





Read_FnSwitch:
	IniRead, Fn0101_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0101
	IniRead, Fn0102_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0102
	IniRead, Fn0103_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0103
	IniRead, Fn0104_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0104
	IniRead, Fn0105_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0105
	IniRead, Fn0106_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0106
	IniRead, Fn0107_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0107
	IniRead, Fn0108_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0108
	IniRead, Fn0109_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0109
	IniRead, Fn0110_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0110
	IniRead, Fn0111_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0111
	IniRead, Fn0112_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0112
	IniRead, Fn0113_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0113
	IniRead, Fn0114_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0114
	IniRead, Fn0115_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0115
	IniRead, Fn0116_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0116
	IniRead, Fn0117_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0117
	IniRead, Fn0118_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0118
	IniRead, Fn0119_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0119
	IniRead, Fn0120_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0120
	IniRead, Fn0121_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0121
	IniRead, Fn0122_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0122
	IniRead, Fn0201_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0201
	IniRead, Fn0202_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0202
	IniRead, Fn0203_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0203
	IniRead, Fn0204_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0204
	IniRead, Fn0205_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0205
	IniRead, Fn0206_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0206
	IniRead, Fn0207_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0207
	IniRead, Fn0208_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0208
	IniRead, Fn0209_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0209
	IniRead, Fn0210_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0210
	IniRead, Fn0211_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0211
	IniRead, Fn0212_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0212
	IniRead, Fn0213_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0213
	IniRead, Fn0214_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0214
	IniRead, Fn0215_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0215
	IniRead, Fn0216_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0216
	IniRead, Fn0217_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0217
	IniRead, Fn0218_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0218
	IniRead, Fn0219_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0219
	IniRead, Fn0220_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0220
	IniRead, Fn0221_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0221
	IniRead, Fn0222_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0222
	IniRead, Fn0223_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0223
	IniRead, Fn0224_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0224
	IniRead, Fn0225_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0225
	IniRead, Fn0301_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0301
	IniRead, Fn0302_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0302
	IniRead, Fn0303_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0303
	IniRead, Fn0304_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0304
	IniRead, Fn0305_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0305
	IniRead, Fn0306_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0306
	IniRead, Fn0307_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0307
	IniRead, Fn0308_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0308
	IniRead, Fn0309_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0309
	IniRead, Fn0310_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0310
	IniRead, Fn0311_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0311
	IniRead, Fn0312_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0312
	IniRead, Fn0313_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0313
	IniRead, Fn0314_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0314
	IniRead, Fn0315_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0315
	IniRead, Fn0316_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0316
	IniRead, Fn0317_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0317
	IniRead, Fn0318_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0318
	IniRead, Fn0319_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0319
	IniRead, Fn0320_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0320
	IniRead, Fn0321_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0321
	IniRead, Fn0322_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0322
	IniRead, Fn0323_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0323
	IniRead, Fn0324_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0324
	IniRead, Fn0325_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0325
	IniRead, Fn0326_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0326
	IniRead, Fn0327_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0327
	IniRead, Fn0328_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0328
	IniRead, Fn0329_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0329
	IniRead, Fn0330_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0330
	IniRead, Fn0331_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0331
	IniRead, Fn0332_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0332
	IniRead, Fn0333_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0333
	IniRead, Fn0334_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0334
	IniRead, Fn0335_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0335
	IniRead, Fn0336_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0336
	IniRead, Fn0337_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0337
	IniRead, Fn0338_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0338
	IniRead, Fn0339_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0339
	IniRead, Fn0340_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0340
	IniRead, Fn0341_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0341
	IniRead, Fn0342_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0342
	IniRead, Fn0343_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0343
	IniRead, Fn0344_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0344
	IniRead, Fn0345_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0345
	IniRead, Fn0401_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0401
	IniRead, Fn0402_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0402
	IniRead, Fn0501_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0501
	IniRead, Fn0502_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0502
	IniRead, Fn0503_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0503
	IniRead, Fn0504_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0504
	IniRead, Fn0505_V, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0505
	

	
	IniRead, Key0101_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0101
	IniRead, Key0102_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0102
	IniRead, Key0103_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0103
	IniRead, Key0104_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0104
	IniRead, Key0105_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0105
	IniRead, Key0106_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0106
	IniRead, Key0107_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0107
	IniRead, Key0108_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0108
	IniRead, Key0109_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0109
	;;;;;IniRead, Key0110_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0110
	IniRead, Key0111_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0111
	IniRead, Key0112_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0112
	;;;;;IniRead, Key0113_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0113
	;;;;;IniRead, Key0114_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0114
	IniRead, Key0115_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0115
	IniRead, Key0116_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0116
	IniRead, Key0117_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0117
	IniRead, Key0118_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0118
	IniRead, Key0119_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0119
	IniRead, Key0120_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0120
	IniRead, Key0121_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0121
	IniRead, Key0122_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0122
	IniRead, Key0201_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0201
	IniRead, Key0202_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0202
	IniRead, Key0203_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0203
	IniRead, Key0204_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0204
	IniRead, Key0205_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0205
	IniRead, Key0206_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0206
	IniRead, Key0207_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0207
	IniRead, Key0208_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0208
	IniRead, Key0209_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0209
	IniRead, Key0210_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0210
	IniRead, Key0211_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0211
	IniRead, Key0212_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0212
	IniRead, Key0213_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0213
	IniRead, Key0214_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0214
	IniRead, Key0215_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0215
	IniRead, Key0216_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0216
	IniRead, Key0217_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0217
	IniRead, Key0218_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0218
	IniRead, Key0219_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0219
	IniRead, Key0220_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0220
	IniRead, Key0221_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0221
	IniRead, Key0222_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0222
	IniRead, Key0223_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0223
	IniRead, Key0224_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0224
	IniRead, Key0225_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0225
	IniRead, Key0301_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0301
	IniRead, Key0302_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0302
	IniRead, Key0303_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0303
	IniRead, Key0304_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0304
	IniRead, Key0305_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0305
	IniRead, Key0306_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0306
	IniRead, Key0307_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0307
	IniRead, Key0308_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0308
	IniRead, Key0309_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0309
	;;;;;;;;;;IniRead, Key0310_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0310
	IniRead, Key0311_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0311
	IniRead, Key0312_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0312
	IniRead, Key0313_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0313
	IniRead, Key0314_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0314
	IniRead, Key0315_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0315
	IniRead, Key0316_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0316
	IniRead, Key0317_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0317
	IniRead, Key0318_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0318
	IniRead, Key0319_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0319
	IniRead, Key0320_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0320
	;;;;;;;;;;IniRead, Key0321_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0321
	IniRead, Key0322_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0322
	;;;;;;;;;;IniRead, Key0323_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0323
	;;;;;;;;;;IniRead, Key0324_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0324
	IniRead, Key0325_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0325
	IniRead, Key0326_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0326
	IniRead, Key0327_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0327
	IniRead, Key0328_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0328
	IniRead, Key0329_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0329
	IniRead, Key0330_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0330
	;;;;;;;;;;IniRead, Key0331_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0331
	IniRead, Key0332_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0332
	;;;;;;;;;;IniRead, Key0333_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0333
	;;;;;;;;;;IniRead, Key0334_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0334
	;;;;;;;;;;IniRead, Key0335_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0335
	;;;;;;;;;;IniRead, Key0336_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0336
	;;;;;;;;;;IniRead, Key0337_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0337
	IniRead, Key0338_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0338
	;;;;;;;;;;IniRead, Key0339_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0339
	;;;;;;;;;;IniRead, Key0340_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0340
	;;;;;;;;;;IniRead, Key0341_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0341
	;;;;;;;;;;IniRead, Key0401_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0401
	IniRead, Key0402_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0402
	;;;;;;;;;;IniRead, Key0501_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0501
	;;;;;;;;;;IniRead, Key0502_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0502
	;;;;;;;;;;IniRead, Key0503_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0503
	;;;;;;;;;;IniRead, Key0504_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0504
	;;;;;;;;;;IniRead, Key0505_V, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0505
;;;;KeySet START	
 
   
hotkey, If, (FnSwitch(0101)=1)
hotkey,%Key0101_V%,Label0101,on

	
hotkey, If, (FnSwitch(0102)=1)
hotkey,%Key0102_V%,Label0102,on

	
hotkey, If, (FnSwitch(0103)=1 && A_OSVersion="WIN_XP")
hotkey,%Key0103_V%,Label0103,on
	
	
hotkey, If, (FnSwitch(0104)=1)
hotkey,%Key0104_V%,Label0104,on

	
hotkey, If, (FnSwitch(0105)=1)
hotkey,%Key0105_V%,Label0105,on
	

	
hotkey, If, (FnSwitch(0106)=1)
hotkey,%Key0106_V%,Label0106,on
	
	
hotkey, If, (FnSwitch(0107)=1)
hotkey,%Key0107_V%,Label0107,on

	
hotkey, If, (FnSwitch(0108)=1)
hotkey,%Key0108_V%,Label0108,on

	
hotkey, If, (FnSwitch(0109)=1)
hotkey,%Key0109_V%,Label0109,on
	

;;;;;;hotkey, If, (FnSwitch(0110)=1)
;;;;;hotkey,%Key0110_V%,Label0110,on
	 

hotkey, If, (FnSwitch(0111)=1)
hotkey,%Key0111_V%,Label0111,on

     
hotkey, If, (FnSwitch(0112)=1)
hotkey,%Key0112_V%,Label0112,on
	 
     
;;;hotkey, If, (FnSwitch(0113)=1)
;;;hotkey,%Key0113_V%,Label0113,on
	 
     
;;;;hotkey, If, (FnSwitch(0114)=1)
;;;;;hotkey,%Key0114_V%,Label0114,on
	 
     
hotkey, If, (FnSwitch(0115)=1)
hotkey,%Key0115_V%,Label0115,on
	 
     
hotkey, If, (FnSwitch(0116)=1)
hotkey,%Key0116_V%,Label0116,on
	 
     
hotkey, If, (FnSwitch(0117)=1)
hotkey,%Key0117_V%,Label0117,on
	 
     
hotkey, If, (FnSwitch(0118)=1)
hotkey,%Key0118_V%,Label0118,on
	 
     
hotkey, If, (A_OSVersion="WIN_XP" && FnSwitch(0119)=1)
hotkey,%Key0119_V%,Label0119,on
	 
     
hotkey, If, (FnSwitch(0120)=1)
hotkey,%Key0120_V%,Label0120,on
	 
     
hotkey, If, ((WinActive("ahk_class CabinetWClass") || WinActive("ahk_class ExploreWClass")) &&  FnSwitch(0121)=1)
hotkey,%Key0121_V%,Label0121,on
	 
     
;;;hotkey, If, (FnSwitch(0122)=1)
;;;hotkey,%Key0122_V%,Label0122,on


    
;;;hotkey, If, (FnSwitch(0201)=1)
;;;hotkey,%Key0201_V%,Label0201,on

	
hotkey, If, (FnSwitch(0202)=1)
hotkey,%Key0202_V%,Label0202,on

	
hotkey, If, (FnSwitch(0203)=1)
hotkey,%Key0203_V%,Label0203,on
	
	
hotkey, If, (FnSwitch(0204)=1)
hotkey,%Key0204_V%,Label0204,on

	
hotkey, If, (FnSwitch(0205)=1)
hotkey,%Key0205_V%,Label0205,on
	

	
hotkey, If, (FnSwitch(0206)=1)
hotkey,%Key0206_V%,Label0206,on
	
	
hotkey, If, (FnSwitch(0207)=1)
hotkey,%Key0207_V%,Label0207,on

	
hotkey, If, (FnSwitch(0208)=1)
hotkey,%Key0208_V%,Label0208,on

	
hotkey, If, (FnSwitch(0209)=1)
hotkey,%Key0209_V%,Label0209,on
	

hotkey, If, (FnSwitch(0210)=1)
hotkey,%Key0210_V%,Label0210,on
	 

hotkey, If, (FnSwitch(0211)=1)
hotkey,%Key0211_V%,Label0211,on

     
hotkey, If, (FnSwitch(0212)=1)
hotkey,%Key0212_V%,Label0212,on
	 
     
hotkey, If, (FnSwitch(0213)=1)
hotkey,%Key0213_V%,Label0213,on
	 
     
hotkey, If, (FnSwitch(0214)=1)
hotkey,%Key0214_V%,Label0214,on
	 
     
;;;hotkey, If, (FnSwitch(0215)=1)
;;;hotkey,%Key0215_V%,Label0215,on
	 
     
hotkey, If, (FnSwitch(0216)=1 && (WinActive("ahk_class WMP Skin Host") || WinActive("ahk_class WMPTransition") || WinActive("ahk_class CWmpControlCntr")))
hotkey,%Key0216_V%,Label0216,on
	 
     
hotkey, If, (FnSwitch(0217)=1 && (WinActive("ahk_class WMP Skin Host") || WinActive("ahk_class WMPTransition") || WinActive("ahk_class CWmpControlCntr")))
hotkey,%Key0217_V%,Label0217,on
	 
     
hotkey, If, (FnSwitch(0218)=1)
hotkey,%Key0218_V%,Label0218,on
	 
     
hotkey, If, (FnSwitch(0219)=1)
hotkey,%Key0219_V%,Label0219,on
	 
     
hotkey, If, (FnSwitch(0220)=1)
hotkey,%Key0220_V%,Label0220,on
	 
     
;;;hotkey, If, (FnSwitch(0221)=1)
;;;hotkey,%Key0221_V%,Label0221,on
	 
     
;;;hotkey, If, (FnSwitch(0222)=1)
;;;hotkey,%Key0222_V%,Label0222,on
	 
     
;;;hotkey, If, (FnSwitch(0223)=1)
;;;hotkey,%Key0223_V%,Label0223,on
	 
     
hotkey, If, (FnSwitch(0224)=1)
hotkey,%Key0224_V%,Label0224,on
	 
     
;;;;hotkey, If, (FnSwitch(0225)=1)
;;;;hotkey,%Key0225_V%,Label0225,on 



	
hotkey, If, (FnSwitch(0302)=1)
hotkey,%Key0302_V%,Label0302,on

	
hotkey, If, (FnSwitch(0303)=1)
hotkey,%Key0303_V%,Label0303,on
	
	
hotkey, If, (FnSwitch(0304)=1)
hotkey,%Key0304_V%,Label0304,on

	
hotkey, If, (FnSwitch(0305)=1)
hotkey,%Key0305_V%,Label0305,on
	

	
hotkey, If, (FnSwitch(0306)=1)
hotkey,%Key0306_V%,Label0306,on
	
	
hotkey, If, (FnSwitch(0307)=1)
hotkey,%Key0307_V%,Label0307,on

	
hotkey, If, (FnSwitch(0308)=1)
hotkey,%Key0308_V%,Label0308,on

	
hotkey, If, (FnSwitch(0309)=1)
hotkey,%Key0309_V%,Label0309,on
	

;;;hotkey, If, (FnSwitch(0310)=1)
;;;hotkey,%Key0310_V%,Label0310,on
	 

hotkey, If, (FnSwitch(0311)=1)
hotkey,%Key0311_V%,Label0311,on

     
hotkey, If, (FnSwitch(0312)=1)
hotkey,%Key0312_V%,Label0312,on
	 
     
hotkey, If, (FnSwitch(0313)=1)
hotkey,%Key0313_V%,Label0313,on
	 
     
hotkey, If, (FnSwitch(0314)=1)
hotkey,%Key0314_V%,Label0314,on
	 
     
hotkey, If, (FnSwitch(0315)=1)
hotkey,%Key0315_V%,Label0315,on
	 
     
hotkey, If, (FnSwitch(0316)=1)
hotkey,%Key0316_V%,Label0316,on
	 
     
hotkey, If, (FnSwitch(0317)=1)
hotkey,%Key0317_V%,Label0317,on
	 
     
hotkey, If, (FnSwitch(0318)=1)
hotkey,%Key0318_V%,Label0318,on
	 
     
hotkey, If, (FnSwitch(0319)=1)
hotkey,%Key0319_V%,Label0319,on
	 
     
hotkey, If, (FnSwitch(0320)=1)
hotkey,%Key0320_V%,Label0320,on
	 
     
;;;hotkey, If, (FnSwitch(0321)=1)
;;;hotkey,%Key0321_V%,Label0321,on
	 
     
hotkey, If, (FnSwitch(0322)=1)
hotkey,%Key0322_V%,Label0322,on
	 
     
;;;hotkey, If, (FnSwitch(0323)=1)
;;;hotkey,%Key0323_V%,Label0323,on
	 
     

	 
	 
     
hotkey, If, (FnSwitch(0325)=1)
hotkey,%Key0325_V%,Label0325,on 
	 
     
hotkey, If, (FnSwitch(0326)=1)
hotkey,%Key0326_V%,Label0326,on 
	 
     
hotkey, If, (FnSwitch(0327)=1)
hotkey,%Key0327_V%,Label0327,on 
	 
     
hotkey, If, (FnSwitch(0328)=1)
hotkey,%Key0328_V%,Label0328,on 
	 
     
hotkey, If, (FnSwitch(0329)=1)
hotkey,%Key0329_V%,Label0329,on 


hotkey, If, (FnSwitch(0330)=1)
hotkey,%Key0330_V%,Label0330,on
	 

;;;hotkey, If, (FnSwitch(0331)=1)
;;;hotkey,%Key0331_V%,Label0331,on

     
hotkey, If, (FnSwitch(0332)=1)
hotkey,%Key0332_V%,Label0332,on
	 
     
	 
     
hotkey, If, (FnSwitch(0338)=1)
hotkey,%Key0338_V%,Label0338,on
	 
 

hotkey, If, (FnSwitch(0402)=1)
hotkey,%Key0402_V%,Label0402,on
;;;;KeySet END	
	;msgbox,Read_FnSwitch end


 
IniRead, SEID, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,SearchEngine_F3
IniRead, UsrHateShortcut,%A_ScriptDir%\HK4WIN_SET.ini,ScriptSetting,UsrHateShortcut	
IniRead, RClickCorner_1_TL, %A_ScriptDir%\HK4WIN_SET.ini, RClickCorner, 1_TL
IniRead, RClickCorner_2_TR, %A_ScriptDir%\HK4WIN_SET.ini, RClickCorner, 2_TR
IniRead, RClickCorner_3_BR, %A_ScriptDir%\HK4WIN_SET.ini, RClickCorner, 3_BR

IniRead, RClickCorner_4_BL, %A_ScriptDir%\HK4WIN_SET.ini, RClickCorner, 4_BL
IniRead, Vol_Home, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting, Vol_Home
IniRead, MOUSE_ESC_LOCK, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,MOUSE_ESC_LOCK
IniRead, OpenAppMax_V, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,OpenAppMax
;msgbox,OpenAppMax_V=%OpenAppMax_V%
IniRead, LU_CheckDate, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,LU_CheckDate
IniRead, Vol_Morning, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,Vol_Morning
IniRead, Vol_Night, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,Vol_Night
IniRead, Vol_Max, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,Vol_Max
;IniRead, MinFx, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,WheelDown_MinFx
IniRead,InstantMinimizeWindow_V,%A_ScriptDir%\HK4WIN_SET.ini,UserSetting,InstantMinimizeWindow
IniRead, SEID2, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,SearchEngine_Shift_F3
IniRead, BlackList, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch,BlackList
IniRead, TransparentList, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,TransparentList
IniRead, TransparentValue, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,TransparentValue
;msgbox,BlackList=%BlackList%
IniRead, WheelList, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,WheelList
WheelListInside=Flip3D,Photo_Lightweight_Viewer,OpusApp,XLMAIN,%WheelList%
IniRead, WheelSpeed, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,WheelSpeed
IniRead, AutoIME, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,AutoIME
IniRead, AutoImeList, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,AutoImeList
IniRead, SecKill, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,SecKill

;IniRead, DisableWinKey, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,DisableWinKey






;GoSub,INI







	IniRead, IE_Gesture_Back, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,IE_Gesture_Back
	IniRead, IE_Gesture_Forward, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,IE_Gesture_Forward
	IniRead, IE_Gesture_Refresh, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,IE_Gesture_Refresh
	IniRead, IE_Gesture_Stop, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,IE_Gesture_Stop
	
	IniRead, IE_Gesture_PreTab, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,IE_Gesture_PreTab
	IniRead, IE_Gesture_NextTab, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,IE_Gesture_NextTab
	IniRead, IE_Gesture_CloseTab, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,IE_Gesture_CloseTab
	IniRead, IE_Gesture_UndoTab, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,IE_Gesture_UndoTab
	IniRead, IE_Gesture_NewTab, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,IE_Gesture_NewTab
	IniRead, IE_Gesture_PageHome, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,IE_Gesture_PageHome
	IniRead, IE_Gesture_PageEnd, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,IE_Gesture_PageEnd
	
	
	IniRead, Ex_Gesture_Copy, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,Ex_Gesture_Copy
	IniRead, Ex_Gesture_Paste, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,Ex_Gesture_Paste
	IniRead, Ex_Gesture_Cute, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,Ex_Gesture_Cute
	IniRead, Ex_Gesture_Del, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,Ex_Gesture_Del
	IniRead, Ex_Gesture_DelInst, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,Ex_Gesture_DelInst
	IniRead, Ex_Gesture_Pro, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,Ex_Gesture_Pro
	IniRead, Ex_Gesture_Back, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,Ex_Gesture_Back
	IniRead, Ex_Gesture_Fwd, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,Ex_Gesture_Fwd
	IniRead, Ex_Gesture_Upper, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,Ex_Gesture_Upper
	IniRead, Ex_Gesture_Close, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,Ex_Gesture_Close
	IniRead, Ex_Gesture_Undo, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,Ex_Gesture_Undo
	
	
	
	
	
	FormatTime, DonateDate,, dd
If (DonateDate="17" or DonateDate="3")
{
	
	
		IniRead, DonateHistory, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,DonateHistory
		FormatTime, NowDate,, yyyyMMdd

		If(NowDate!=DonateHistory)
		{
			settimer,Donate_HK4WIN,-900000
			IniWrite, %NowDate%, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,DonateHistory
		}
}
return


;???????????????????????自启动 初始检查  结束??????????????????
Create_Shortlinks:


	If(UsrHateShortcut="1" or SetUpBy="EXE")
		return

MsgBox, 262180, HK4WIN 添加快捷方式, 您想在桌面和开始菜单中为 HK4WIN 添加快捷方式吗？
;;;;提示：HK4WIN是绿色软件，您可以随意随时变更其位置，如果添加了快捷方式，那么当您移动 HK4WIN 到新位置时，只需双击运行就可自动更新最初的快捷方式，而无需担心快捷方式失效。
IfMsgBox Yes
{
FileCreateShortcut, %A_ScriptFullPath%,%A_Desktop%\HK4WIN.lnk,,, 为 Windows 系统提供丰富多彩、可定制的快捷键。, %A_ScriptDir%\hk4win-icon.ico


IfNotExist, %A_StartMenu%\%ProgramFolderName%\HK4WIN\
	FileCreateDir, %A_StartMenu%\%ProgramFolderName%\HK4WIN\

FileCreateShortcut, %A_ScriptFullPath%,%A_StartMenu%\%ProgramFolderName%\HK4WIN\HK4WIN.lnk,,, 为 Windows 系统提供丰富多彩、可定制的快捷键。, %A_ScriptDir%\hk4win-icon.ico

IfExist, %A_ScriptDir%\HK4WIN 使用说明.htm
FileCreateShortcut, %A_ScriptDir%\HK4WIN 使用说明.htm,%A_StartMenu%\%ProgramFolderName%\HK4WIN\HK4WIN 使用说明.lnk,,, HK4WIN 使用说明。, %A_ProgramFiles%\Internet Explorer\iexplore.exe,,2

FileCreateShortcut, "http://www.songruihua.com/hk4win",%A_StartMenu%\%ProgramFolderName%\HK4WIN\HK4WIN 官方网站.lnk,,, 下载最新版HK4WIN和源代码。, %A_ProgramFiles%\Internet Explorer\iexplore.exe
FileCreateShortcut, "http://www.songruihua.com/archives/hk4win.html#comment",%A_StartMenu%\%ProgramFolderName%\HK4WIN\在线留言.lnk,,, 在线留言。, %A_ProgramFiles%\Internet Explorer\iexplore.exe
FileCreateShortcut, "mailto:hk4win@songruihua.com?subject=关于HK4WIN：",%A_StartMenu%\%ProgramFolderName%\HK4WIN\给作者发 Email.lnk,,, hk4win@songruihua.com, %A_WinDir%\Explorer.exe,,16

}
else
IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,UsrHateShortcut
return



Refresh_Shortlinks:


IfExist, %A_Desktop%\HK4WIN.lnk
{
	FileGetShortcut, %A_Desktop%\HK4WIN.lnk, old_LNK_exe
	If old_LNK_exe<>%A_ScriptFullPath%
		FileCreateShortcut, %A_ScriptFullPath%,%A_Desktop%\HK4WIN.lnk,,, 为 Windows 系统提供丰富多彩、可定制的快捷键。, %A_ScriptDir%\hk4win-icon.ico
}



FileCreateShortcut, %A_ScriptFullPath%,%A_StartMenu%\%ProgramFolderName%\HK4WIN\HK4WIN.lnk,,, 为 Windows 系统提供丰富多彩、可定制的快捷键。,%A_ScriptDir%\hk4win-icon.ico

FileGetShortcut, %A_StartMenu%\%ProgramFolderName%\HK4WIN\HK4WIN 使用说明.lnk, old_LNK_readme
IfExist, %A_ScriptDir%\HK4WIN 使用说明.htm
FileCreateShortcut, %A_ScriptDir%\HK4WIN 使用说明.htm,%A_StartMenu%\%ProgramFolderName%\HK4WIN\HK4WIN 使用说明.lnk,,, HK4WIN 使用说明。, %A_ProgramFiles%\Internet Explorer\iexplore.exe,,2
else IfNotExist, %old_LNK_readme%
FileDelete, %A_StartMenu%\%ProgramFolderName%\HK4WIN\HK4WIN 使用说明.lnk


FileCreateShortcut, "http://www.songruihua.com/hk4win",%A_StartMenu%\%ProgramFolderName%\HK4WIN\HK4WIN 官方网站.lnk,,, 下载最新版HK4WIN和源代码。, %A_ProgramFiles%\Internet Explorer\iexplore.exe
FileCreateShortcut, "http://www.songruihua.com/archives/hk4win.html#comment",%A_StartMenu%\%ProgramFolderName%\HK4WIN\在线留言.lnk,,, 在线留言。, %A_ProgramFiles%\Internet Explorer\iexplore.exe
FileCreateShortcut, "mailto:hk4win@songruihua.com?subject=关于HK4WIN：",%A_StartMenu%\%ProgramFolderName%\HK4WIN\给作者发 Email.lnk,,, hk4win@songruihua.com, %A_WinDir%\Explorer.exe,,16

return



; ==========================检查注册表一致性  开始========================
REG_SAME()
{
  RegRead, CURRENT_RUN, HKEY_CURRENT_USER, SOFTWARE\Microsoft\Windows\CurrentVersion\Run , HK4WIN
CURRENT_LOCATION=%A_ScriptFullPath%
if CURRENT_RUN=%CURRENT_LOCATION%
	return 1
else
	return 0
}
; ==========================检查注册表一致性  结束========================

FnSwitch(FnID)
{
global BlackList
MouseGetPos,x,y,MouseID,MouseControl
WinGetClass,MouseClass,ahk_id %MouseID%
;msgbox,%FnID%---000 BlackList=%BlackList%
	If(BlackList<>"")
	{
		
					If MouseClass in %BlackList%
					{
					;
						return 0
						;msgbox,%FnID%---222
					}
					else
					{
					
					;msgbox,%FnID%---333  Not in BlackListGroup
									if (Fn%FnID%_V=1)
										return 1
									else if (Fn%FnID%_V=0 or Fn%FnID%_V="")
										return 0
									else
									{
									
									;msgbox,%FnID%---444
										temp0:=Fn%FnID%_V
										If MouseClass in %temp0%
										{
											;msgbox,will return 0 haha
											
											return 0
										}
										else
										{
										
											return 1
										}
									}

					}
					
					;GoSub,GetInfoUnderMouse
	}
	else
	{
	;If BlackList="" it will run from here
									if (Fn%FnID%_V=1)
										return 1
									else if (Fn%FnID%_V=0 or Fn%FnID%_V="" or Fn%FnID%_V="UNAVAILABLE")
										return 0
									else
									{
									
									;msgbox,%FnID%---444
										temp:=Fn%FnID%_V
										If MouseClass in %temp%
										{
											;msgbox,will return 0 haha
											
											return 0
										}
										else
										{
										
											return 1
										}
									}
	}	
}




!Pause::



IniRead, MOUSE_ESC_LOCK, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,MOUSE_ESC_LOCK
if (MOUSE_ESC_LOCK=0)
{
	MOUSE_ESC_LOCK=1
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,MOUSE_ESC_LOCK 
	PlayWAV("ding")
	TrayTip , HK4WIN,鼠标秒杀功能已禁用 , 5, 1
}
else
{
	MOUSE_ESC_LOCK=0
	IniWrite, 0, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,MOUSE_ESC_LOCK
	PlayWAV("chimes")
	TrayTip , HK4WIN,鼠标秒杀功能已开启 , 5, 1
}

return




#If (FnSwitch(0101)=1)
Label0101:
;*************************检查是否VISTA $ 7   开始
if A_OSVersion in WIN_7,WIN_8,WIN_9,WIN_VISTA
{
	;;;msgbox,OS error
	send,{F2}
	
	return
}
;*************************检查是否VISTA $ 7   结束

;*************************检查是否显示扩展名  开始
RegRead, EXT_REG, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, HideFileExt
if (EXT_REG="1")
{
	send,{F2}
	
	return
}

;*************************检查是否显示扩展名  结束






;*************************检查是否选中文件夹  开始
User_New_Name=%Clipboard%
;;;send,{ESC}
send,^c
;ClipWait,3
sleep,100
MYclipboard=%clipboard%
IfExist, %clipboard%\
	IS_FOLDER=1
else
	IS_FOLDER=0
;*************************检查是否选中文件夹  结束

;*************************检查是否是快捷方式  开始
StringRight, LAST_R4, MYclipboard, 4
If (LAST_R4=".lnk")
	IS_LNK=1
else
	IS_LNK=0
;*************************检查是否是快捷方式  结束

;IfWinActive,ahk_class (CabinetWClass|Progman|WorkerW|#32770)
If  WinActive("ahk_class CabinetWClass") or WinActive("ahk_class Progman")or WinActive("ahk_class WorkerW") or WinActive("ahk_class #32770")
{

If (IS_FOLDER=0) and (IS_LNK=0)
{
;;;;msgbox,NOT_FOLDER
BlockInput On									;先锁定鼠标键盘，以防用户捣乱
send,{F2}
send,^c											;复制旧文件名
;ClipWait,3
StringSplit,pos,Clipboard,`.					;将旧文件名以句点分割为几部分
Last_Ext:=pos%pos0%								;将旧文件名的扩展名存于Last_Ext
Ext_Len:=StrLen(Last_Ext)						;将旧文件名的扩展名长度存于Ext_Len
send,+^{END}									;将光标放在文件名末尾
sleep,100
loop %Ext_Len%									;将光标从末尾向左移动到扩展名之前
	{
	send,{Left}
	}
send,{Left}										;将光标从扩展名之前再往左移到句点之前
send,+^{Home}									;选中光标到文件名首的部分
BlockInput Off									;解除鼠标键盘锁定
Clipboard=%User_New_Name%						;将用户先前复制的内容还给他
}
else	;若果是文件夹
{
;;;;;;msgbox,IS_FOLDER
Clipboard=%User_New_Name%						;将用户先前复制的内容还给他
send,{F2}
}



}
else
{
Clipboard=%User_New_Name%						;将用户先前复制的内容还给他
send,{F2}
}


return
#If
;;;;;The end #IF tag of FnSwitch 0101



RClickCorner_Open_Computer:
{

sleep,200
send,{F10}
 Run ::{20d04fe0-3aea-1069-a2d8-08002b30309d},,Max
 sleep,200
	If (A_OSVersion="WIN_XP")
	{
	send,!v
	sleep,100
	send,r
	}
 MouseMove, MonFullRight/2, MonFullBottom/2 , 1
 WinActivate
}

return
RClickCorner_Open_Documents:
{
sleep,200
send,{F10}
 Run ::{450d8fba-ad25-11d0-98a8-0800361b1103},,Max
 sleep,200
	If (A_OSVersion="WIN_XP")
	{
	send,!v
	sleep,100
	send,r
	}
 MouseMove, MonFullRight/2, MonFullBottom/2 , 1
}

return
RClickCorner_Open_Desktop:
{
sleep,200
;;;;send,{F10}
 Send,#m
 sleep,200
 
 MouseMove, MonFullRight/2, MonFullBottom/2 , 1
 send,{F10}
}
return



~RButton:: ;右键
;Click up right
;return
If SecKilling=1
return

WinGetPos , X, Y, Width, Height, A
SysGet, MonFull, Monitor
If(X=0)&&(Y=0)&&(Width=MonFullRight)&&(Height=MonFullBottom)
{
	If  WinActive("ahk_class Progman")or WinActive("ahk_class WorkerW")
		Gaming="0"
	else
	{
		Gaming="1"
			return
	}
}
else
	Gaming="0"
;msgbox,Gaming=%Gaming%


MouseGetPos, xpos, ypos, OVarWin, OVarControl
If (ypos<5 and xpos>10 and xpos<MonFullRight-10)
	{
	If  (Gaming="1" or FnSwitch(0225)="0")
		{
		Send, {RButton}
		return
		}

		Process, Exist,QQ.exe
		if ErrorLevel
		{
			Send, {F10}
			sleep,100
			Send,^!z
			return
		}	

	}
else If (xpos<5 and ypos<5)
	{
	RClickCornerAct("1_TL")
	}
else if (xpos>MonFullRight-5 and ypos<5)
	{
	RClickCornerAct("2_TR")
	}
else if (xpos>MonFullRight-10 and ypos>MonFullBottom-10)
	{
	RClickCornerAct("3_BR")
	}
else if (xpos<5 and ypos>MonFullBottom-5)
	{
	RClickCornerAct("4_BL")
	}
else
{
		If (FnSwitch(0324)=1)
		{
			If Gaming=1
				return
		Keywait, RButton, t0.3
		if errorlevel = 1
		{
		return
		}
		Keywait, RButton, d t0.3
			if errorlevel = 0
			{
				If (WinActive("ahk_class TXGuiFoundation") && (FnSwitch(0342)=1))
				{
					;;;QQ 清屏 开始
					WinGetPos ,WinX , WinY, WinWidth, WinHeight, A
					If (WinHeight<WinWidth*2)
					{
						X:=WinX+WinWidth*0.4
						Y:=WinY+WinHeight*0.4
						MouseMove, X, Y
						;msgbox,X=%X%////Y=%Y%
						sleep,50
						send,{Rbutton}
						sleep,20
						send,{Up}
						sleep,20
						send,{Enter}
					}
					else
					{
						
						WinMinimize, A
					}
					WinX=""
					WinY=""
					WinWidth=""
					WinHeight=""
					;;;QQ 清屏 结束
				}
				else
				{
					;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;开始最大化
					if WinActive("ahk_class DV2ControlHost")
					{
					Send, {RButton}
					return
					}
					WinGet, DAXIAO , MinMax, A
					if (DAXIAO = "1")
					{
					WinRestore, A
					sleep,20
					send,{F10}
					SetTimer , MakeCtrlKeyUp, 500
					}
					else
					{
					;;;;;;;;;;;;;;;;;;;;;WinGet, Last_Max_Id, ID, A
					WinMaximize, A
					sleep,20
					send,{F10}
					SetTimer , MakeCtrlKeyUp, 500
					}
					send,{Alts}
					;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;最大化结束
				}
			
			

			}
			


		}
		;this is the End of FnSwitch(0324)

}
;this is the End of ELSE

return





RClickCornerAct(CN)
{
	If (RClickCorner_%CN%<>"")
	{
	;msgbox,Gaming=%Gaming%
		If (RClickCorner_%CN%="Desktop")
			GoSub,RClickCorner_Open_Desktop
		else If (RClickCorner_%CN%="Computer")
			GoSub,RClickCorner_Open_Computer
		else If (RClickCorner_%CN%="Documents")
			GoSub,RClickCorner_Open_Documents
		else If (RClickCorner_%CN%="ZhaiNan")
			Gosub,ZNK_PW
		else
		{
		If Gaming="1"
			return
			temp45465:=RClickCorner_%CN%
			;msgbox,run %temp45465%
			Run %temp45465%,,Max
			sleep,200
			;send,{F10}
			MouseMove, MonFullRight/2, MonFullBottom/2 , 1
		}
	}
	else
		Send, {RButton}
}







;????????????????????????????????  文件夹定位  ?????????????????????????????????????????
#If (FnSwitch(0104)=1)
Label0104:
;
Run %A_MyDocuments%	; 打开我的文档

return
#If
;;;;;The end #IF tag of FnSwitch 0104

#If (FnSwitch(0105)=1)
Label0105:


send !{F4}


return
#If
;;;;;The end #IF tag of FnSwitch 0105

#If (FnSwitch(0106)=1)
Label0106:

If (A_OSVersion="WIN_XP")
{
IfNotExist, %A_MyDocuments%\文本文档
{
	FileCreateDir, %A_MyDocuments%\文本文档
	MsgBox, 48, 新建文件夹, 已在“我的文档”中新建“文本文档”文件夹`n它位于:%A_MyDocuments%\文本文档,15
}
Run %A_MyDocuments%\文本文档
}
else
Run %A_MyDocuments%

return
#If
;;;;;The end #IF tag of FnSwitch 0106

#If (FnSwitch(0107)=1)

Label0107:
If (A_OSVersion="WIN_XP")
{
IfNotExist, %A_MyDocuments%\My Pictures
	FileCreateDir, %A_MyDocuments%\My Pictures
Run %A_MyDocuments%\My Pictures
}
else
{
MyDocDir=%A_MyDocuments%
StringLen, mdlen, MyDocDir
usrlen:=mdlen-10
StringLeft, UsrDir, A_MyDocuments, %usrlen%
;msgbox,%UsrDir%
IfNotExist, %UsrDir%\Pictures
	FileCreateDir, %UsrDir%\Pictures
Run %UsrDir%\Pictures

}

return
#If
;;;;;The end #IF tag of FnSwitch 0107


#If (FnSwitch(0108)=1)	
Label0108:

If (A_OSVersion="WIN_XP")
{
IfNotExist, %A_MyDocuments%\My Music
	FileCreateDir, %A_MyDocuments%\My Music
Run %A_MyDocuments%\My Music
}
else
{
MyDocDir=%A_MyDocuments%
StringLen, mdlen, MyDocDir
usrlen:=mdlen-10
StringLeft, UsrDir, A_MyDocuments, %usrlen%
;msgbox,%UsrDir%
IfNotExist, %UsrDir%\Music
	FileCreateDir, %UsrDir%\Music
Run %UsrDir%\Music
}

return
#If
;;;;;The end #IF tag of FnSwitch 0108


#If (FnSwitch(0109)=1)
Label0109:

If (A_OSVersion="WIN_XP")
{
IfNotExist, %A_MyDocuments%\My Videos
	FileCreateDir, %A_MyDocuments%\My Videos
Run %A_MyDocuments%\My Videos
}
else
{
MyDocDir=%A_MyDocuments%
StringLen, mdlen, MyDocDir
usrlen:=mdlen-10
StringLeft, UsrDir, A_MyDocuments, %usrlen%
;msgbox,%UsrDir%
IfNotExist, %UsrDir%\Videos
	FileCreateDir, %UsrDir%\Videos
Run %UsrDir%\Videos
}

return
#If
;;;;;The end #IF tag of FnSwitch 0109


#If (FnSwitch(0110)=1)
#F5::Launch_Folder("F5")
#F6::Launch_Folder("F6")
#F7::Launch_Folder("F7")
#F8::Launch_Folder("F8")
#F9::Launch_Folder("F9")
#F10::Launch_Folder("F10")
#F11::Launch_Folder("F11")
#F12::Launch_Folder("F12")
#If
;;;;;The end #IF tag of FnSwitch 0110


Launch_Folder(TheHotKey)
{
;
IfExist, %A_ScriptDir%\HK4WIN_SET.ini
{	IniRead, FolderDir, %A_ScriptDir%\HK4WIN_SET.ini, OpenDir, %TheHotKey%
	If (FolderDir<>"")
	
		{
		;msgbox, FolderDir==%FolderDir%
		IfExist, %FolderDir%		
			Run %FolderDir%
		else
		{
			MsgBox, 36, HK4WIN 文件夹路径错误, 配置文件中 Win+%TheHotKey% 指定的文件夹不存在。这可能是该文件夹已被删除或者您拼写错误。`n是否打开配置文件以进行修改？,20
		IfMsgBox Yes
			{
			GoSub,OpenINI
			;msgbox,qwe3
			}
		}
	}
	else
	{
		FileSelectFolder, FolderDir , ::{20d04fe0-3aea-1069-a2d8-08002b30309d}, 1, 请指定快捷键 Win+%TheHotKey% 对应的文件夹。
		IniWrite, %FolderDir%, %A_ScriptDir%\HK4WIN_SET.ini, OpenDir, %TheHotKey%
		Run %FolderDir%

		}
}
else
	Send, #{%TheHotKey%}
}
;###############################

#If (FnSwitch(0111)=1)
Label0111:

Run ::{20d04fe0-3aea-1069-a2d8-08002b30309d}

return
#If
;;;;;The end #IF tag of FnSwitch 0111

#If (FnSwitch(0112)=1)
Label0112:


send #e
sleep,20
WinMaximize, A

return
#If
;;;;;The end #IF tag of FnSwitch 0112


#If (FnSwitch(0115)=1)
Label0115:

Run ::{20d04fe0-3aea-1069-a2d8-08002b30309d}

return
#If
;;;;;The end #IF tag of FnSwitch 0115



<#>!x::
>#<!x::
IfExist, X:\
{
Run X:\,,Max
;BlockInput On
MsgBox, 48, 计算机安全警告,您即将进入系统还原分区,此处的所有文件对计算机安全至关重要,请不要进行任何操作。

}
return

#If (FnSwitch(0113)=1)
#!c::



IfExist, C:\
Run C:\

return
#!d::


IfExist, D:\
Run D:\

return
#!e::


IfExist, E:\
Run E:\

return
#!f::


IfExist, F:\
Run F:\

return
#!g::


IfExist, G:\
	Run G:\

return
#!h::


IfExist, H:\

	Run H:\

	return
#!i::


IfExist, I:\
	Run I:\

return
#!j::


IfExist, J:\
	Run J:\

return
#!k::


IfExist, K:\
	Run K:\

return
#!l::


IfExist, L:\
	Run L:\

return
#If
;;;;;The end #IF tag of FnSwitch 0113


#If (FnSwitch(0114)=1)
#1::
;
IfExist, C:\
Run C:\	

return
#2::
;
IfExist, D:\
Run D:\
return
#3::
;
IfExist, E:\
Run E:\

return
#4::
;
IfExist, F:\
Run F:\

return
#5::
;
IfExist, G:\
	Run G:\

return
#6::
;
IfExist, H:\
	Run H:\

return
#7::
;
IfExist, I:\
	Run I:\

return
#8::
;
IfExist, J:\
	Run J:\

return
#9::
;
IfExist, K:\
	Run K:\

return
#0::
;
IfExist, L:\
	Run L:\

return
#If
;;;;;The end #IF tag of FnSwitch 0114


#If (FnSwitch(0116)=1)
Label0116:

If (A_OSVersion="WIN_XP")
{
;if WinActive("ahk_class CabinetWClass")
if (WinActive("ahk_class ExploreWClass") or WinActive("ahk_class CabinetWClass"))
	{
	;;Send, {F10}vin	; 按名称排序
	send,!v
	sleep,100
	send,i
	sleep,30
	send,n
	}
else
	send,#o
}
else
{

;if WinActive("ahk_class CabinetWClass")
if (WinActive("ahk_class CabinetWClass") or WinActive("ahk_class ExploreWClass"))
	;;Send, {F10}vo{Enter}	; 按名称排序
	{
		send,!v
	sleep,100
	send,o
	sleep,30
	send,{Enter}
	}
else
	send,#o
}

return

#If
;;;;;The end #IF tag of FnSwitch 0116

#If (FnSwitch(0118)=1)
Label0118:

KeyWait,LWin
KeyWait,RWin
;if WinActive("ahk_class CabinetWClass")
if (WinActive("ahk_class CabinetWClass") or WinActive("ahk_class ExploreWClass"))
{


	If (A_OSVersion="WIN_7" or A_OSVersion="WIN_8" or A_OSVersion="WIN_9")
	{
			BlockInput On
					temp0=%ClipBoard%
					sleep,20
					Send, ^+n	; 新建文件夹
					;sleep,100
					;Send, n	; 新建文件夹
					FormatTime, CurrentDateTime,, yyyy-MM-dd [HH.mm.ss]
					ClipBoard=%CurrentDateTime%
					sleep,500
					send,^v
					sleep,200
					send,^a
					sleep,100
					ClipBoard=%temp0%
			BlockInput Off
	}
	else
	{
			BlockInput On
					temp0=%ClipBoard%
					sleep,20
					Send, !f	; 新建文件夹
					sleep,100
					Send, w	; 新建文件夹
					FormatTime, CurrentDateTime,, yyyy-MM-dd [HH.mm.ss]
					ClipBoard=%CurrentDateTime%
					Send, f	; 新建文件夹
					sleep,500
					send,^v
					sleep,200
					send,^a
					sleep,100
					ClipBoard=%temp0%
			BlockInput Off
	}
		
	
	
	
}
else
	send,#n
	

return
#If
;;;;;The end #IF tag of FnSwitch 0118

#If (FnSwitch(0117)=1)
Label0117:

;if WinActive("ahk_class CabinetWClass")
if (WinActive("ahk_class CabinetWClass") or WinActive("ahk_class ExploreWClass"))
	;;;Send, {F10}ei	; 反向选择
	{
		If (A_OSVersion="WIN_8" or A_OSVersion="WIN_9")
		{
			send,!h
			sleep,100
			send,s
			sleep,100
			send,i		
		}
		else
		{
			send,!e
			sleep,100
			send,i
		}
	}
else
	send,#i
	

return
#If
;;;;;The end #IF tag of FnSwitch 0117

#If (A_OSVersion="WIN_XP" && FnSwitch(0119)=1)
Label0119:

;if WinActive("ahk_class CabinetWClass")
if (WinActive("ahk_class CabinetWClass") or WinActive("ahk_class ExploreWClass"))
	;Send, {F10}vou	;
	{
		send,!v
	sleep,100
	send,o
	sleep,30
	send,u
	}
else
	SoundPlay *48

return
#If
;;;;;The end #IF tag of FnSwitch 0119





;????????????????????????????????  程序启动  ?????????????????????????????????????????
#If (FnSwitch(0220)=1)
Label0220:             ;双击F12禁用win
Keywait, F12, , t0.2
if errorlevel = 1
return
else
Keywait, F12, d, t0.2
if errorlevel = 0
{
GoSub,F12NoWin
}
return
#If

;;;;;The end #IF tag of FnSwitch 0220
#If (DisableWinKey="1")
LWin::PlayWAV("Windows Error")
RWin::PlayWAV("Windows Error")
#If


F12NoWin:
PlayWAV("chimes")
	If (DisableWinKey="0")
	{
		DisableWinKey=1
		;IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,DisableWinKey
		Menu, Tray,Rename,禁用WIN键,启用WIN键
		TrayTip , HK4WIN,Windows键已禁用`n若要重新启用请快速按两次 F12 键 , 10, 1
	}
	else
	{
		DisableWinKey=0
		;IniWrite, 0, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,DisableWinKey
		Menu, Tray,Rename,启用WIN键,禁用WIN键
		TrayTip , HK4WIN,Windows键已启用 , 5, 1
	}
return

#If (FnSwitch(0224)=1)

Label0224:                 ;双击F11自动点击鼠标左键

Keywait, F11, , t0.2
if errorlevel = 1
return
else
Keywait, F11, d, t0.2
if errorlevel = 0
{
	IniRead, AutoClick_Alarm, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,AutoClick_Alarm
	
	If(AutoClick_Alarm="0")
	{
		MsgBox, 262436, HK4WIN 警告, 这是您首次连续按两下F11键。`n`nHK4WIN 可以实现自动单击鼠标，这可以让您在某些应用中从频繁的点击鼠标中解脱出来！但是如果您在不适当环境中使用此功能可能会带来非常严重的后果，所以请您谨慎使用此功能。`n`n快捷键：`n连续按两下F11键：开始自动单击动作（或将自动单击频率恢复到默认）`n同时按\与0：停止自动单击`n同时按\与-：调低自动单击的频率`n同时按\与+：调高自动单击的频率`n同时按\与退格键（backspace）：暂停自动单击。`n以上提示仅会出现一次，请您仔细阅读并记住相关的快捷键。`n`n`n　　　　　　　　　　　　　　　　　现在开始自动单击吗？
		IfMsgBox Yes
		{
		IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,AutoClick_Alarm
		}
		else
			return
	}



	If (AutoClick="0")
	{
		AutoClick=1
		AutoClickPaused=0
		;TrayTip , HK4WIN,Windows键已禁用`n若要重新启用请快速按两次 F12 键 , 20, 1
		AutoClickSleep=500
		PlayWAV("ding")
		tooltip,警告：鼠标自动点击 即将开始
		sleep,3000
		If AutoClick=0
			return
		PlayWAV("ding")
		tooltip,5
		sleep,1000
		If AutoClick=0
			return
		PlayWAV("ding")
		tooltip,4
		sleep,1000
		If AutoClick=0
			return
		PlayWAV("ding")
		tooltip,3
		sleep,1000
		If AutoClick=0
			return
		PlayWAV("ding")
		tooltip,2
		sleep,1000
		If AutoClick=0
			return
		PlayWAV("ding")
		tooltip,1
		sleep,1000
		If AutoClick=0
			return
		PlayWAV("chimes")
		tooltip
		SetTimer, AutoClickTimer, 10
		
	}
	else
	{
		PlayWAV("chimes")
		;AutoClick=0
		AutoClickPaused=0
		;TrayTip , HK4WIN,Windows键已禁用`n若要重新启用请快速按两次 F12 键 , 20, 1
		AutoClickSleep=500
		;SetTimer, AutoClickTimer, off
		
		
	}

}
return
#If
;;;;;The end #IF tag of FnSwitch 0224

#If (AutoClick="1")
\ & 0::
{
PlayWAV("chimes")
AutoClick=0
SetTimer, AutoClickTimer, off
tooltip,鼠标自动点击 已停止
sleep, 3000
tooltip
}
return

\ & Backspace::
{

If(AutoClickPaused="0")
{
	AutoClickPaused=1
	PlayWAV("ding")
	tooltip,鼠标自动点击 已暂停
	sleep, 1000
	tooltip
}
else
	{
	PlayWAV("ding")
		AutoClickPaused=0
	}

}
return

\ & =::
{
If AutoClickPaused=1
			return
	If(AutoClickSleep="500")
		AutoClickSleep=400
	else If(AutoClickSleep="400")
		AutoClickSleep=300
	else If(AutoClickSleep="300")
		AutoClickSleep=200
	else If(AutoClickSleep="200")
		AutoClickSleep=100
	else If(AutoClickSleep="100")
		AutoClickSleep=50
	else If(AutoClickSleep="50")
		AutoClickSleep=30
	else If(AutoClickSleep="30")
		AutoClickSleep=20
	else If(AutoClickSleep="20")
		AutoClickSleep=15
	else If(AutoClickSleep="15")
		AutoClickSleep=10
	else If(AutoClickSleep="10")
		AutoClickSleep=5
	else If(AutoClickSleep="1000")
		AutoClickSleep=900
	else If(AutoClickSleep="900")
		AutoClickSleep=800
	else If(AutoClickSleep="800")
		AutoClickSleep=700
	else If(AutoClickSleep="700")
		AutoClickSleep=600
	else If(AutoClickSleep="600")
		AutoClickSleep=500
;tooltip,%AutoClickSleep%
If(AutoClickSleep="5")
PlayWAV("ding")
}
return
\ & -::
{
If AutoClickPaused=1
			return
	If(AutoClickSleep="500")
		AutoClickSleep=600
	else If(AutoClickSleep="600")
		AutoClickSleep=700
	else If(AutoClickSleep="700")
		AutoClickSleep=800
	else If(AutoClickSleep="800")
		AutoClickSleep=900
	else If(AutoClickSleep="900")
		AutoClickSleep=1000
	else If(AutoClickSleep="5")
		AutoClickSleep=10
	else If(AutoClickSleep="10")
		AutoClickSleep=15
	else If(AutoClickSleep="15")
		AutoClickSleep=20
	else If(AutoClickSleep="20")
		AutoClickSleep=30
	else If(AutoClickSleep="30")
		AutoClickSleep=50
	else If(AutoClickSleep="50")
		AutoClickSleep=100
	else If(AutoClickSleep="100")
		AutoClickSleep=200
	else If(AutoClickSleep="200")
		AutoClickSleep=300
	else If(AutoClickSleep="300")
		AutoClickSleep=400
	else If(AutoClickSleep="400")
		AutoClickSleep=500

;tooltip,%AutoClickSleep%
If(AutoClickSleep="1000")
PlayWAV("ding")
}
return
#If

AutoClickTimer:
If(AutoClickPaused="1")
return
sleep,%AutoClickSleep%
send,{Click}
return




#If (FnSwitch(0205)=1)
Label0205:             ;双击NumLock打开浏览器
Keywait, NumLock, , t0.2
if errorlevel = 1
return
else
Keywait, NumLock, d, t0.2
if errorlevel = 0
{
send ,{Browser_Home}
}
return
#If
;;;;;The end #IF tag of FnSwitch 0205

#If (FnSwitch(0206)=1)
Label0206:             ;双击Pause打开邮件客户端
Keywait, Pause, , t0.2
if errorlevel = 1
return
else
Keywait, Pause, d, t0.2
if errorlevel = 0
{
send ,{Launch_Mail}
}
return
#If
;;;;;The end #IF tag of FnSwitch 0206
#If (FnSwitch(xxxx)=1)
~<!>^PrintScreen::             ;双击PrnScr截屏
Keywait, PrintScreen, , t0.2
if errorlevel = 1
return
else
Keywait, PrintScreen, d, t0.2
if errorlevel = 0
{
	ClipSaved := ClipboardAll
	Clipboard := ClipSaved
	ClipSaved = 
				If (A_OSVersion="WIN_XP")
			{
			IfNotExist, %A_MyDocuments%\My Pictures
				FileCreateDir, %A_MyDocuments%\My Pictures
			PicDir=
			FileAppend, %ClipboardAll%, C:\Company Logo.clip ; 
			}
			else
			{
			MyDocDir=%A_MyDocuments%
			StringLen, mdlen, MyDocDir
			usrlen:=mdlen-10
			StringLeft, UsrDir, A_MyDocuments, %usrlen%
			;msgbox,%UsrDir%
			IfNotExist, %UsrDir%\Pictures
				FileCreateDir, %UsrDir%\Pictures
			PicDir=%UsrDir%\Pictures

			}

	
}
return
#If
;;;;;The end #IF tag of FnSwitch xxxxx


^+`::


IfExist, %A_WinDir%\system32\proc.exe
	Run proc
else
	send,^+{Esc}
	

return

#If (FnSwitch(0202)=1)
Label0202: 



IfExist, %A_ProgramFiles%\Notepad++\notepad++.exe
        Run %A_ProgramFiles%\Notepad++\notepad++.exe
else IfExist, D:\Program Files\Notepad++\notepad++.exe
        Run D:\Program Files\Notepad++\notepad++.exe
else IfExist, E:\Program Files\Notepad++\notepad++.exe
        Run E:\Program Files\Notepad++\notepad++.exe
else IfExist, F:\Program Files\Notepad++\notepad++.exe
        Run F:\Program Files\Notepad++\notepad++.exe
else
	Run Notepad
	

return
#If
;;;;;The end #IF tag of FnSwitch 0202


<^<!PRINTSCREEN::


IfExist, %A_ProgramFiles%\PicPick\picpick.exe
        Run %A_ProgramFiles%\PicPick\picpick.exe
else IfExist, D:\Program Files\PicPick\picpick.exe
        Run D:\Program Files\PicPick\picpick.exe
else IfExist, E:\Program Files\PicPick\picpick.exe
        Run E:\Program Files\PicPick\picpick.exe
else IfExist, F:\Program Files\PicPick\picpick.exe
        Run F:\Program Files\PicPick\picpick.exe
else
send,{PrintScreen}

return











<^>!+c::
IfWinExist PowerToy Calc
	WinActivate
else
{
	IfExist, %A_WinDir%\system32\ptc.exe
		Run ptc
	else
		Run Calc
}
	
return


#If (FnSwitch(0304)=1)
Label0304:


send ^f

return

$^f::

;if WinActive("ahk_class CabinetWClass")
if (WinActive("ahk_class CabinetWClass") or WinActive("ahk_class ExploreWClass"))
	GoSub,SuperFind
else
	send ^f

return
#If
;;;;;The end #IF tag of FnSwitch 0304


#If (FnSwitch(0204)=1)
Label0204:

GoSub,Switch_Evethg

return
#If
;;;;;The end #IF tag of FnSwitch 0204


#If (FnSwitch(0203)=1)
Label0203:
GoSub,SuperFind

return
#If
;;;;;The end #IF tag of FnSwitch 0203


SuperFind:
;if WinActive("ahk_class CabinetWClass")
if (WinActive("ahk_class CabinetWClass") or WinActive("ahk_class ExploreWClass"))
{
;;;;msgbox,11111
WinWaitActive

	
	If (A_OSVersion="WIN_XP")
	{
		temp1=Edit1
		temp0=0
	}
	else
	{
		temp1=ToolbarWindow322
		if (A_Language = "0804")
			temp0=4
		else
			temp0=9
	}
		
		
	ControlGetText, FilePath, %temp1%, A
	StringTrimLeft, FilePath, FilePath, %temp0%
	;msgbox, temp1=%temp1%  FilePath===%FilePath%
	;;;;;;;;stringreplace, FilePath, FilePath, 地址:%A_space%, , All	
	if (FilePath="桌面") or WinActive("ahk_class Progman")or WinActive("ahk_class WorkerW")
		FilePath=%A_Desktop%
	if FilePath in 我的文档,库
		FilePath=%A_MyDocuments%
	if FilePath in 我的电脑,计算机,这台电脑,"This PC",网上邻居,控制面板,回收站,控制面板,我们的电脑
	{
	;;;;msgbox,2222
		GoSub,Switch_Evethg
		sleep 200
		IfWinExist ahk_class EVERYTHING
		{
		;;;msgbox,333333
		WinActivate, ahk_class EVERYTHING
		WinWaitActive, ahk_class EVERYTHING
		ControlSetText, Edit1, , ahk_class EVERYTHING
		}
		else
		;;;msgbox,44444
		;;;;send,#f
		return
	}	
	GoSub,Switch_Evethg
	sleep 200
	IfWinExist ahk_class EVERYTHING
	{
	;;;msgbox,555555555
	WinActivate,ahk_class EVERYTHING
	WinWaitActive, ahk_class EVERYTHING
	;;;msgbox,OK

	ControlSetText,  Edit1, "%FilePath%"%A_space%, ahk_class EVERYTHING

	sleep 20
	send {end}
	}
	;;;;;;;;;;;;;;;;;;;;;若在资源管理器中，但不存在evth
	else
		send,^f
}
;;;;;;;;;;;;;;;;;;;;;若不在资源管理器中
else
{

		GoSub,Switch_Evethg
		sleep 20
		IfWinExist ahk_class EVERYTHING
		{
		WinActivate
		WinWaitActive, ahk_class EVERYTHING
		ControlSetText, Edit1, , ahk_class EVERYTHING
		}
	;else
		;send,^f



}
return



Switch_Evethg:
RegRead, Everything_dir_temp, HKLM, SOFTWARE\Classes\Everything.FileList\DefaultIcon
;StringTrimLeft, Everything_dir_temp, Everything_dir_temp, 1
StringTrimRight, Everything_dir_temp, Everything_dir_temp, 3

;msgbox,temp---%Everything_dir_temp%
	IfExist, %Everything_dir_temp%
	{
		Everything_dir=%Everything_dir_temp%
		;msgbox,temp---%Everything_dir_temp%---2
		Run "%Everything_dir%",,Max
	}
	else
	{
		Everything_dir=
		IfExist, %A_ScriptDir%\Everything.exe
		{
			Run "%A_ScriptDir%\Everything.exe",,Max
					WinActivate,ahk_class EVERYTHING
					sleep,150
					WinWaitActive, ahk_class EVERYTHING
					if WinActive("ahk_class EVERYTHING")
					WinMaximize, ahk_class EVERYTHING
						IniRead, EverythingWarn_V, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,EverythingWarn
						If(EverythingWarn_V<>1)
						{
							IfWinExist ahk_class EVERYTHING
							{
							WinActivate,ahk_class EVERYTHING
							WinWaitActive, ahk_class EVERYTHING
							IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,EverythingWarn
							sleep,200
							send,^p
							sleep,200
							IfWinActive, Everything Options
								MsgBox, 262192, HK4WIN 提示,Everything默认界面为英文，切换语言请点击左侧General，然后点击右侧Language：English...`n选择简体中文，点击OK按钮。,300
							}
						}
		}
		else
		{
			Process, Exist,Everything.exe.exe
			if ErrorLevel
				send #^+!P
		}
			
	}
		
	

return


;HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH   隐藏文件   开始   HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH

#If (FnSwitch(0120)=1)
Label0120:
{

ShowHideTrayTip=1
GoSub,ShowHide
}
return
#If
;;;;;The end #IF tag of FnSwitch 0120

ShowHide:
{
Critical

If (A_OSVersion="WIN_8" or A_OSVersion="WIN_9")
	ShowHideTrayTip=1

BY_F5=0

		if A_OSVersion = "WIN_XP"
		{
			if WinExist("ahk_class ExploreWClass")
			{
				WinActivate,ahk_class ExploreWClass
				WinWaitActive, ahk_class ExploreWClass, , 3
					if ErrorLevel
					{
						MsgBox, WinWait ExploreWClass timed out.
						return
					}
					else
						Gosub, HIDE_SHOW_REG_CHECK
			}
			else
			{
				IfExist,C:\
					run,C:\
				else IfExist,D:\
					run,D:\
				else IfExist,E:\
					run,E:\
				else
					msgbox,HK4WIN ERROR : NO DRIVE MATCH
					
				WinWait, ahk_class ExploreWClass, , 3
					if ErrorLevel
					{
						MsgBox, WinWait ExploreWClass timed out.
						return
					}
					else
						Gosub, HIDE_SHOW_REG_CHECK
				
			}
		}
		else
		{
		
			if WinExist("ahk_class CabinetWClass")
			{
				WinActivate,ahk_class CabinetWClass
				WinWaitActive, ahk_class  CabinetWClass, , 3
					if ErrorLevel
					{
						MsgBox, WinWait CabinetWClass timed out.
						return
					}
					else
						Gosub, HIDE_SHOW_REG_CHECK
						
			}
			else
			{
				IfExist,C:\
					run,C:\
				else IfExist,D:\
					run,D:\
				else IfExist,E:\
					run,E:\
				else
					msgbox,HK4WIN ERROR : NO DRIVE MATCH
					

				WinWait, ahk_class CabinetWClass, , 3
					if ErrorLevel
					{
						MsgBox, WinWait CabinetWClass timed out.
						return
					}
					else
						Gosub, HIDE_SHOW_REG_CHECK
			}
		}	
}
return



HIDE_SHOW_REG_CHECK:
;if WinActive("ahk_class CabinetWClass")
if (WinActive("ahk_class CabinetWClass") or WinActive("ahk_class ExploreWClass"))
{
RegRead, HIDDEN_REG_1, HKEY_CURRENT_USER, SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\Folder\Hidden\SHOWALL , CheckedValue
RegRead, HIDDEN_REG_2, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden
if (HIDDEN_REG_1="1" and HIDDEN_REG_2="1")
	Gosub, HIDE_FILES
else
	Gosub, SHOW_FILES
}
else
{
		;;;MsgBox, 262192, HK4WIN 显示已隐藏的文件和文件夹, “显示已隐藏的文件和文件夹”功能只能在资源管理器中使用。,8
	SoundPlay *48
	SysGet, MonFull, Monitor
	TrayTip , HK4WIN,此功能只能在资源管理器中使用 , 5, 3
}
return

HIDE_FILES:
RegWrite, REG_DWORD, HKEY_CURRENT_USER, SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\Folder\Hidden\SHOWALL, CheckedValue, 0
RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden, 2
HIDE_ACTION=1
SHOW_ACTION=0
Gosub, REFRESH_CURRENT_WINDOW
return

SHOW_FILES:
RegWrite, REG_DWORD, HKEY_CURRENT_USER, SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\Folder\Hidden\SHOWALL, CheckedValue, 1
RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden, 1
HIDE_ACTION=0
SHOW_ACTION=1
Gosub, REFRESH_CURRENT_WINDOW

return


CmtOnline_HK4WIN:
Run, www.songruihua.com/archives/hk4win.html#comment
return


REFRESH_CURRENT_WINDOW:

If BY_F5=0
{
		If (A_OSVersion="WIN_8" or A_OSVersion="WIN_9")
		{
			temp2=`n请在右键菜单中点击“刷新”
		}
		else
		{
			temp2=
			BlockInput ,On
			BlockInput,MouseMove
			;;;;;;;;;;;;;;;;;SysGet, SCROLL_BAR_WIDTH, 2
			;;;;;;;;;;;;;;;;;;;;REFRESH_PLACE=500
			;;;;;;;;;;;;;;;REFRESH_PLACE=MonFull-SCROLL_BAR_WIDTH-500
			WinMaximize, A
			sleep,100
			;Send, {F10}vd	; 按名称排序
				send,!v
				sleep,100
				send,d

			sleep,100
			MouseGetPos, xpos, ypos
			MouseClick, right,  MonFullRight*0.9,  MonFullBottom/2
			;Click right MonFullRight*0.9,MonFullBottom/2
			Sleep, 100
			Send, e
			Sleep, 20
			;Send, {F10}vs
				send,!v
				sleep,100
				send,s
			sleep,100
			MouseMove, %xpos%, %ypos%
			BlockInput,MouseMoveOff
			BlockInput,Off
		}
}
else
{
BlockInput,On
BlockInput,MouseMove
tooltip,请等待...
;send {F10}ei{Down}{Up}{Left}{Right}
	send,!e
	sleep,100
	send,i
	sleep,30
	send,{Down}{Up}{Left}{Right}
sleep,500
send {F5}{F5}
sleep,500
send {F5}{F5}
sleep,500
send {F5}{F5}
sleep,500
send {F5}{F5}
tooltip
BlockInput,MouseMoveOff
BlockInput,Off
}

If HIDE_ACTION=1
{
	If(ShowHideTrayTip="1")
	TrayTip , HK4WIN,不显示隐藏的文件和文件夹%temp2% , 5, 1 
	
	ShowHideTrayTip=0
	RegRead, HIDDEN_REG_1, HKEY_CURRENT_USER, SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\Folder\Hidden\SHOWALL , CheckedValue
	RegRead, HIDDEN_REG_2, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden
	;tooltip,HIDDEN_REG_1=%HIDDEN_REG_1%-----111-------HIDDEN_REG_2=%HIDDEN_REG_2%----ShowHideStatus=%ShowHideStatus%
	if (HIDDEN_REG_1="0" and HIDDEN_REG_2="2" and ShowHideStatus="0")
	{
	;msgbox,HIDDEN_REG_1=%HIDDEN_REG_1%-----111-------HIDDEN_REG_2=%HIDDEN_REG_2%----ShowHideStatus=%ShowHideStatus%
		Menu, Tray,Rename,不显示隐藏的文件和文件夹,显示所有文件和文件夹
		ShowHideStatus=1
	}
	
	
}
else
{
	If(ShowHideTrayTip="1")
	TrayTip , HK4WIN,显示所有文件和文件夹%temp2% , 5, 1
	
	ShowHideTrayTip=0
	RegRead, HIDDEN_REG_1, HKEY_CURRENT_USER, SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\Folder\Hidden\SHOWALL , CheckedValue
	RegRead, HIDDEN_REG_2, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden
	;tooltip,HIDDEN_REG_1=%HIDDEN_REG_1%-----222-------HIDDEN_REG_2=%HIDDEN_REG_2%----ShowHideStatus=%ShowHideStatus%
	if (HIDDEN_REG_1="1" and HIDDEN_REG_2="1" and ShowHideStatus="1")
	{
	;msgbox,HIDDEN_REG_1=%HIDDEN_REG_1%-----222-------HIDDEN_REG_2=%HIDDEN_REG_2%----ShowHideStatus=%ShowHideStatus%
		Menu, Tray,Rename,显示所有文件和文件夹,不显示隐藏的文件和文件夹
		ShowHideStatus=0
	}

	
}

;;sleep,2000
;;tooltip
return

;HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH   隐藏文件   结束   HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH

;SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS   脚本功能   开始   SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS


^+!z::



GoSub,OpenINI

return

OpenINI:
IfWinExist HK4WIN_SET
	WinActivate
else
{
IfNotExist, %A_ScriptDir%\HK4WIN_SET.ini
{
	 GoSub,CREATE_INI
	 
	 loop,5
	 {	 
	 sleep,1000
	 IfExist, %A_ScriptDir%\HK4WIN_SET.ini
		break
	 
	 }
	 IfExist, %A_ScriptDir%\HK4WIN_SET.ini
		Run %A_ScriptDir%\HK4WIN_SET.ini,,Max
	 else
		msgbox,HK4WIN ERROR:CAN NOT RUN INI
}
else
	{
		IniRead, OpenINIAlarm_V, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,OpenINIAlarm
				If(OpenINIAlarm_V="0")
					Goto,SkipOpenINIAlarm
					
		if OpenINIAlarm_V not in 0,1,2,3,4
			IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,OpenINIAlarm
		else If(OpenINIAlarm_V="1")
			IniWrite, 2, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,OpenINIAlarm
		else If(OpenINIAlarm_V="2")
			IniWrite, 3, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,OpenINIAlarm
		else If(OpenINIAlarm_V="3")
			IniWrite, 4, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,OpenINIAlarm
		else If(OpenINIAlarm_V="4")
			IniWrite, 0, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,OpenINIAlarm
		
		MsgBox, 262192, HK4WIN 警告, 即将打开配置文件：`n%A_ScriptDir%\HK4WIN_SET.ini`n您可以在这里对HK4WIN进行设置，请参照相关说明或者查看HK4WIN的在线使用说明谨慎修改。一般来说，设置完成后必须重启HK4WIN才能生效，重启方法是按下快捷键Ctrl+Alt+Shift+F5，或者右键单击系统托盘图标。`n`n如有任何疑问，请联系HK4WIN作者：宋瑞华。`nQQ:273454295　Email:hk4win@songruihua.com`n在线使用说明 www.songruihua.com/hk4win
		SkipOpenINIAlarm:
		Run %A_ScriptDir%\HK4WIN_SET.ini,,Max
		
		
		
	}
}
sleep,2000
if WinActive("打开方式") and WinActive("ahk_class #32770")
{
	;MsgBox, 262192, HK4WIN_SET.ini 打开方式, 请使用文本编辑器（如:记事本）打开HK4WIN_SET.ini,10
tooltip,HK4WIN : 请使用文本编辑器（如:记事本）打开HK4WIN_SET.ini
sleep,3000
tooltip
}
return






^+!F1::GoSub,SHOW_README
SHOW_README:
{
	IfWinExist, HK4WIN 官方网站
	{
		WinActivate , HK4WIN 官方网站
		GoSub,ShowVersion_HK4WIN
		return
	}
Official_Web_Opened=0
Run, www.songruihua.com/hk4win,,Max
sleep,100
loop,10
	 {	 
	 sleep,300
	 IfWinExist, HK4WIN 官方网站
		{
			Official_Web_Opened=1
			break
		} 
	 }
	 If Official_Web_Opened=0
		{
		IfExist, %A_ScriptDir%\HK4WIN 使用说明.htm
			Run "%A_ScriptDir%\HK4WIN 使用说明.htm",,Max
		}
	;else
	;msgbox,opened
}
GoSub,ShowVersion_HK4WIN
return


^+!s::



MsgBox, 292, HK4WIN 快捷键重置, 是否重置所有快捷键为默认设置？`n`n这会删除并重建%A_ScriptDir%\HK4WIN_SET.ini`n您的所有自定义快捷键将丢失，建议先备份该ini文件,60
	IfMsgBox Yes
		{
		IniRead, GPL_Accepted, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,GPL_Accepted
		sleep,200
		FileDelete, %A_ScriptDir%\HK4WIN_SET.ini
		;Run,%A_ScriptFullPath%
		;msgbox,000000
		sleep,500
		GoSub,CREATE_INI
		sleep,200
		If GPL_Accepted=1
		IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,GPL_Accepted
		;MsgBox, 0, HK4WIN 成功重置快捷键, 已重置所有快捷键为默认设置，按Ctrl+Alt+Shift+Z可自定义快捷键。,15
		SysGet, MonFull, Monitor
		;tooltip,HK4WIN : 已重置所有快捷键为默认设置，按 Ctrl+Alt+Shift+Z 可自定义快捷键。,MonFullRight/2-100,MonFullBottom/2-50
		;sleep,3000
		;tooltip
		TrayTip , HK4WIN,已重置所有快捷键为默认设置，按 Ctrl+Alt+Shift+Z 可自定义快捷键。 , 7, 1
		reload
		}
	
	else
	{
	
	}
return

^+!F5::
GoSub,Want2Restart
return

Want2Restart:
;MsgBox,AutoShutdown_Run=%AutoShutdown_Run%
If (AutoShutdown_Run=1)
	{
		If(ASDMode="1")
		{
								asmin:=pageacc*60000
						If ASDLeftMin>60
						{
						my_hr:=ASDLeftMin/60
						my_hr^=0
						
						;msgbox,my_hr===%my_hr%
						my_min:=ASDLeftMin-(my_hr*60)
						;msgbox,%my_hr%---%my_min%
						If my_min=0
							ASDLeftMin2= %my_hr% 小时  
						else
							ASDLeftMin2= %my_hr% 小时 %my_min% 分钟 
						}
						else if (ASDLeftMin=60)
						{
							ASDLeftMin2= 1 小时
							my_min=0
							my_hr=1
						}
						else if (ASDLeftMin<2)
						{
							ASDLeftMin2=几秒钟
							my_min=1
							my_hr=0
						}
						else
						{
							ASDLeftMin2=%ASDLeftMin% 分钟
							my_min=%ASDLeftMin%
							my_hr=0
						}
						CancelAskTime=%ASDLeftMin2% 后
		}

	MsgBox, 262436, HK4WIN 提醒, 您之前已经设置过定时关机！`n自动关机时间是 %CancelAskTime%`n重启 HK4WIN 会取消此设定。`n`n重启 HK4WIN 吗？
	IfMsgBox Yes
	{
		ASDMode=0
		CancelAskTime=
		GoSub,Restart_HK4WIN
		
	}
	else
		return
	}
else
	GoSub,Restart_HK4WIN
return

Restart_HK4WIN:
tooltip,重启 HK4WIN ...
sleep,500
tooltip

Reload 
return
^+!v::GoSub,ShowVersion_HK4WIN
ShowVersion_HK4WIN:



SoundPlay *48


Gui, 3: Destroy
Gui, 3: Font, s16 bold, 微软雅黑
Gui, 3: Add,text,, HK4WIN
IfExist, %A_ScriptDir%\hk4win-icon.ico
Gui, 3: Add, Picture, xm+250 ym, hk4win-icon.ico
Gui, 3: Font, s11 bold, 微软雅黑
Gui, 3: Add,text,xm ym+25,软件作者：宋瑞华
Gui, 3: Font, s10 norm, 微软雅黑
Gui, 3: Add,text,xm ym+50, %HK4WIN_ver_build%`n开发代号：%DevCode%
Gui, 3: Add,text,xm ym+130, Email:hk4win@songruihua.com 
Gui, 3: Add,text,xm ym+150, QQ:273454295　
Gui, 3: Font, cBlue bold underline
Gui, 3: Add,text,xm ym+170 GSRHHP, www.songruihua.com
Gui, 3: Color, White

Gui, 3: Show,, 谨以此版本献给我的女朋友
return







return

SRHHP:
run, www.songruihua.com
return

^+!r::



;IniWrite, 0, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,AutoRunAfterLaunch

if REG_SAME()=false
	{
MsgBox, 36, HK4WIN开机启动, 您想让HK4WIN开机时自动启动吗？`n这将令您的电脑操作体验焕然一新！`n`n如果您点击“是”，HK4WIN会编辑注册表的如下位置HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run`n这一操作的目的是让HK4WIN开机自动启动。
	IfMsgBox Yes
		{
		RegWrite, REG_SZ,HKEY_CURRENT_USER,SOFTWARE\Microsoft\Windows\CurrentVersion\Run, HK4WIN, %A_ScriptFullPath%
		;MsgBox, 64, HK4WIN开机启动, HK4WIN开机启动功能已打开。`n注意：请不要移动%A_ScriptName%的位置或重命名，否则开机启动会失效。`n它位于 %A_ScriptFullPath%,10
		SysGet, MonFull, Monitor
		;tooltip,HK4WIN : 开机自启动已打开。`n`n如果改变 HK4WIN 的位置或重命名，开机自启动会失效。`n它位于  %A_ScriptFullPath%,MonFullRight/2-50,MonFullBottom/2-50
		;sleep,7000
		;tooltip
		TrayTip , HK4WIN,开机自启动已打开。`n`n如果改变 HK4WIN 的位置或重命名，开机自启动会失效。`n它位于  %A_ScriptFullPath% , 15, 2
		}
	}
	else
	{
MsgBox, 292, HK4WIN开机启动, HK4WIN开机启动功能目前已打开。`n`n您想取消此功能吗？`n如果这样，您下次开机后需手动打开HK4WIN。
	IfMsgBox Yes
		{
		RegWrite, REG_SZ,HKEY_CURRENT_USER,SOFTWARE\Microsoft\Windows\CurrentVersion\Run, HK4WIN, 0
		;MsgBox, 64, HK4WIN开机启动, HK4WIN开机启动功能已关闭。`n下次开机后您需要手动打开HK4WIN`n`n它位于 %A_ScriptFullPath%
		SysGet, MonFull, Monitor
		;tooltip,HK4WIN : 开机自启动已关闭。`n`n下次开机后您需要手动打开 HK4WIN。`n它位于 %A_ScriptFullPath%`n`n如需再次打开此功能请按 Ctrl+Alt+Shift+R,MonFullRight/2-50,MonFullBottom/2-50
		;sleep,10000
		;tooltip
		TrayTip , HK4WIN,开机自启动已关闭。`n`n下次开机后您需要手动打开 HK4WIN。`n它位于 %A_ScriptFullPath%`n`n如需再次打开此功能请按 Ctrl+Alt+Shift+R , 15, 2
		}
	}


return

^+!c::
;GetMouseClass:



Gosub,GetInfoUnderMouse

;MouseGetPos,x,y,MouseID
;WinGetClass,MouseClass,ahk_id %MouseID%
;WinGetClass,ActClass,A
;tooltip,Class=%MouseClass%`nControl=%MouseControl%`nID=%MouseID%


		clipboard=%MouseClass%
		tooltip,已复制“类”：%MouseClass%
		;`nControl=%MouseControl%`nID=%MouseID%
		;BeforRemoveToolTip=已复制：%MouseClass%
		SetTimer, RemoveToolTip, 2000


;sleep,5000
return


^+!Esc::
^+!h::
GoSub,Want2Exit
return

Want2Exit:
If ((AutoShutdown_Run=1)or(AutoShutdown_Run_INI=1))
{
If AutoShutdown_Run_INI=1
	ASDINI=`n在INI文件中您设置了AutoShutdownTime的值
else
	ASDINI=
	
		If(ASDMode="1")
		{
								asmin:=pageacc*60000
						If ASDLeftMin>60
						{
						my_hr:=ASDLeftMin/60
						my_hr^=0
						
						;msgbox,my_hr===%my_hr%
						my_min:=ASDLeftMin-(my_hr*60)
						;msgbox,%my_hr%---%my_min%
						If my_min=0
							ASDLeftMin2= %my_hr% 小时  
						else
							ASDLeftMin2= %my_hr% 小时 %my_min% 分钟 
						}
						else if (ASDLeftMin=60)
						{
							ASDLeftMin2= 1 小时
							my_min=0
							my_hr=1
						}
						else if (ASDLeftMin<2)
						{
							ASDLeftMin2=几秒钟
							my_min=1
							my_hr=0
						}
						else
						{
							ASDLeftMin2=%ASDLeftMin% 分钟
							my_min=%ASDLeftMin%
							my_hr=0
						}
						CancelAskTime=%ASDLeftMin2% 后
		}



MsgBox, 262436, HK4WIN 提醒, 您之前已经设置过定时关机！%ASDINI%`n自动关机时间是 %CancelAskTime%`n关闭 HK4WIN 会取消此设定。`n`n关闭 HK4WIN 吗？
			IfMsgBox Yes
			{
			CancelAskTime=
			Gosub,Exit_Asked
			ASDMode=0
			}

}
else
Gosub,Exit_No_Timer
return











Exit_No_Timer:
	MsgBox, 262436, HK4WIN 退出, 退出 HK4WIN 吗？
	IfMsgBox Yes
		{
		Gosub,Exit_Asked
		}
return
Exit_Asked:
{
if REG_SAME()=false
	{
	;;MsgBox, 0, HK4WIN关闭, HK4WIN正在关闭...,1
;tooltip,HK4WIN 正在关闭,MonFullRight/2, MonFullBottom/2
;sleep,1000
;tooltip
MsgBox, 36, HK4WIN开机启动, 您想让HK4WIN开机时自动启动吗？`n这将令您的电脑操作体验焕然一新！`n`n如果您点击“是”，HK4WIN会编辑注册表的如下位置HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run`n这一操作的目的是让HK4WIN开机自动启动。
	IfMsgBox Yes
		{
		SysGet, MonFull, Monitor
		RegWrite, REG_SZ,HKEY_CURRENT_USER,SOFTWARE\Microsoft\Windows\CurrentVersion\Run, HK4WIN, %A_ScriptFullPath%
		;;;;MsgBox, 64, HK4WIN开机启动, HK4WIN开机启动功能已打开。`n注意：请不要移动HK4WIN的位置或重命名，否则开机启动会失效。`n它位于 %A_ScriptFullPath%
		;tooltip,HK4WIN : 开机自启动已打开,MonFullRight/2-50,MonFullBottom/2-50
		;sleep,2500
		;tooltip,HK4WIN : 如果改变 HK4WIN 的位置或重命名，开机自启动会失效。`n它位于  %A_ScriptFullPath%,MonFullRight/2-150,MonFullBottom/2-50
		;sleep,7500
		;tooltip
		TrayTip , HK4WIN,开机自启动已打开。`n如果改变 HK4WIN 的位置或重命名，开机自启动会失效。`n它位于  %A_ScriptFullPath% , 5, 1
		}
	Gosub, Exit_HK
	}
else
	{
	Gosub, Exit_HK
	}
}

;;;;;;;;;;;;MsgBox , 0, HK4XP, HK4XP正在关闭..., 1

return


Exit_HK:
tooltip,HK4WIN 已关闭
PlayWAV("tada")
sleep,2000
tooltip
ExitApp
return

;SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS   脚本功能   结束   SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS











;WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW  系统功能    开始   WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW






#If (FnSwitch(0302)=1)
Label0302:
WinSet, AlwaysOnTop, On, A
WinGetTitle, Current_Win_Title,A
SysGet, MonFull, Monitor
;tooltip,已置顶 %Current_Win_Title%,MonFullRight/2-50,MonFullBottom/2-50
tooltip,已置顶 %Current_Win_Title%
sleep,1000
tooltip
return

RControl & Down::
WinSet, AlwaysOnTop, Off, A
SysGet, MonFull, Monitor
tooltip,当前窗口未置顶
sleep,1000
tooltip
return
#If
;;;;;The end #IF tag of FnSwitch 0302







#+Del::



        Gosub, DelDev
		;Goto, FORCE_REMOVE_FD
return




#If (FnSwitch(0311)=1)

Label0311:
GoSub,SafelyRemoveAll
;NewNewFlashDiskReadyToOpen=0
return
;以下是旧版代码

If A_OSVersion!=WIN_XP
{
	;MsgBox, 16, HK4WIN 兼容性检查, HK4WIN 的安全删除硬件功能与当前操作系统不兼容。`n`n仅支持WIN_XP系统，您正在使用%A_OSVersion%系统，请手动删除硬件。,20
	send,#{Delete}
	return
}
DEL_ANOTHER_DEV=0
KeyWait, DEL
KeyWait,LWin
KeyWait,RWin
RETRY_TO_REMOVE_FD:

DriveGet, FDs, List , REMOVABLE						;将IJKL存入FDs
StringLen, FDs_Len, FDs								;将IJKL的数量 4 存入FDs_Len
If(FDs_Len<>0)
{
;;;;;;;;;;;msgbox,%FDs_Len%--%FDs%
StringLeft, FD1, FDs, 1
;;;;;;;;msgbox,FD1=%FD1%							;将I存入FD1
StringMid, FD2, FDs, 2	
;;;;;;;;;;;;;;;;;;;;;msgbox,FD2=%FD2%							;将J存入FD2
DriveGet,  FD1_LABEL, label,%FD1%:					;将 VE66 存入FD1_LABEL
DriveGet,  FD2_LABEL, label,%FD2%:					;将 SRH-MSD 存入FD2_LABEL

	Gosub, DelDev

DriveGet, 2FDs, List , REMOVABLE						;将JKL存入2FDs
StringLen, 2FDs_Len, 2FDs								;将JKL的数量 3 存入2FDs_Len
StringLeft, 2FD1, 2FDs, 1								;将I存入FD1
StringMid, 2FD2, 2FDs, 2								;将J存入FD2
DriveGet,  2FD1_LABEL, label,%2FD1%:					;将 VE66 存入FD1_LABEL
DriveGet,  2FD2_LABEL, label,%2FD2%:					;将 SRH-MSD 存入FD2_LABEL
	
	;;;DriveGet, FDs_Re, List , REMOVABLE				
	;;StringLen, FDs_Len_Re, FDs_Re				
	;;StringLeft, FD1_Re, FDs_Re, 1					
	;;;DriveGet,  FD1_Re_LABEL, label,%FD1_Re%:	
	;;;;;;;StringMid, ANOTHER_FD, HAVE_FD_2, 2
	
	;;DriveGet,  FD_LABEL_2, label,%NEXT_FD%:
	;;DriveGet,  FD_LABEL_ANOTHER, label,%ANOTHER_FD%:
	;;;;;;StringLen, HAVE_FD_2_COUNT, HAVE_FD_2
		
	If 2FDs not contains %FD1%						
		{
		
		if(2FDs_Len=0)						
			MsgBox, 262192, HK4WIN 安全删除硬件, 已安全删除 %FD1_LABEL% (%FD1%:)`n`n电脑上已无可移动设备。,5
		else
			{
			MsgBox, 262148, HK4WIN 安全删除硬件, 已安全删除 %FD1_LABEL% (%FD1%:)`n电脑上仍插有 %2FDs_Len% 个可移动设备。`n`n是否删除 %2FD1_LABEL% (%2FD1%:) ？,30
			IfMsgBox, Yes			
				Goto, RETRY_TO_REMOVE_FD
			}
		}
	else										
		{
				if WinActive("弹出") and WinActive("ahk_class #32770")
				send,{Enter} 
		MsgBox, 262165, 请不要拔出可移动设备！！！, 无法安全删除 %FD1_LABEL% (%FD1%:) `n`n操作建议：`n1.关闭杀毒软件；`n2.关闭QQ，TM，以及XX卫士；`n3.关闭其他可能正在使用此设备的软件；`n4.您是否正在进行复制粘贴操作；`n5.稍后重试 (LWin+Del)；`n6.关机后拔出此设备；`n7.手动删除此设备。
		IfMsgBox, Retry
			Goto, RETRY_TO_REMOVE_FD
		else
			{
				if(2FDs_Len>1)
				{
					MsgBox, 262180, HK4WIN 安全删除硬件, 您是否想删除另一个设备 %2FD2_LABEL% (%2FD2%:), 15
					IfMsgBox, Yes			
					Gosub, NEXT_DEV
					
				}
				;;;;;else;;;262177
				
					
			}
		
		}

	
}	
else
{
;;PlayWAV("notify")
;;;;;BlockInput, Off
	MsgBox, 16, HK4WIN 未发现可移动设备, 您的电脑未连接任何可移动设备。`n`n如果您的设备未被正确识别，可按Win+Shift+Del尝试强制删除。,10
	;;;;;;;;;;;;;;;`n如果您想安全删除光驱%HAVE_CD%(对虚拟光驱可能无效)，请按Win+Shift+Del。
	;;;ToolTip, HK4WIN : 未发现可移动设备
	;;;SetTimer, RemoveToolTip, 1500

}
return
#If
;;;;;The end #IF tag of FnSwitch 0311
;========================================================
NEXT_DEV:
{
RETRY_TO_REMOVE_next_FD:
DEL_ANOTHER_DEV=1		
	Gosub, DelDev
DriveGet, 3FDs, List , REMOVABLE						
StringLen, 3FDs_Len, 3FDs						
StringLeft, 3FD1, 3FDs, 1						
StringMid, 3FD2, 3FDs, 2					
DriveGet,  3FD1_LABEL, label,%3FD1%:			
DriveGet,  3FD2_LABEL, label,%3FD2%:					
	

	If 3FDs not contains %2FD2%						
		{
		
		if(3FDs_Len=0)							
			MsgBox, 262192, HK4WIN 安全删除硬件, 已安全删除 %2FD2_LABEL% (%2FD2%:)`n`n电脑上已无可移动设备,5
		else
			{MsgBox, 262192, HK4WIN 安全删除硬件, 已安全删除 %2FD2_LABEL% (%2FD2%:)`n电脑上仍插有 %3FDs_Len% 个可移动设备`n`n您刚才未成功删除 %3FD1_LABEL% (%3FD1%:) ，建议稍后重试。 ,15
						;;;IfMsgBox, Yes			
				;;;;Goto, RETRY_TO_REMOVE_FD
			}
		}
	else											
		{
				if WinActive("弹出") and WinActive("ahk_class #32770")
				send,{Enter} 
		MsgBox, 262165, 请不要拔出可移动设备！！！, 无法安全删除 %2FD2_LABEL% (%2FD2%:) `n`n操作建议：`n1.关闭杀毒软件；`n2.关闭QQ，TM，以及XX卫士；`n3.关闭其他可能正在使用此设备的软件；`n4.您是否正在进行复制粘贴操作；`n5.稍后重试 (LWin+Del)；`n6.关机后拔出此设备；`n7.手动删除此设备。
		IfMsgBox, Retry
			Goto, RETRY_TO_REMOVE_next_FD
		else
			MsgBox, 262192, HK4WIN 安全删除硬件, 看来您遇到了一些棘手的问题：至少两个设备 %FD1_LABEL% (%FD1%:) 和 %2FD2_LABEL% (%2FD2%:) 均不能被安全删除。`n`n如果您正在两个设备之间传送文件请待完成后重试，否则建议您关机后再拔下设备，以免损坏设备。,60
		}
}
return
;========================================================



DelDev:
Critical
MouseGetPos, xpos, ypos
BlockInput ,On
Run %A_WinDir%\system32\control.exe hotplug.dll
WinWait 安全删除硬件
ControlGet,IfStopEnabled,Enabled,,Button2
If IfStopEnabled{
	If (DEL_ANOTHER_DEV<>0)
	{
		send,{Down %DEL_ANOTHER_DEV%}
	}
	ControlSend,Button2,s
	WinWait 停用硬件设备
	ControlSend,Button1,{Enter}
}
WinWaitClose 停用硬件设备
WinClose 安全删除硬件
WinWaitClose 安全删除硬件
MouseMove, %xpos%, %ypos%
BlockInput ,Off
send,{LShift Up}
send,{RShift Up}
send,{LWin Up}
send,{RWin Up}
sleep,100
if ((WinActive("ahk_class CabinetWClass") or WinActive("ahk_class ExploreWClass")) and (WinActive("我的电脑") or WinActive("计算机")))
	send,{F5}
return






;NumPadSub::Send, {LWINDOWN}d{LWINUP}
;NumpadEnter:: Run ::{20d04fe0-3aea-1069-a2d8-08002b30309d},,Max
#If (FnSwitch(0312)=1)
Label0312:
If (CheckSogouIME()=1)
	GoSub,KillSogouIME
if A_OSVersion not in WIN_7,WIN_8,WIN_9,WIN_VISTA
{
SoundGet, MUTE_ONOFF, , mute
If(MUTE_ONOFF="Off")
	SoundSet +1
else
{
SoundSet, 0
SoundSet, +1, , mute
SoundSet +1
}
}
else
;;;;若果是WIN_7,WIN_VIST
Send {Volume_Up}
return

>^PgDn::
If (CheckSogouIME()=1)
	GoSub,KillSogouIME
if A_OSVersion not in WIN_7,WIN_8,WIN_9,WIN_VISTA
{
SoundGet, MUTE_ONOFF, , mute
If(MUTE_ONOFF="Off")
	SoundSet -1
else
	SoundSet, 0
}
else
Send {Volume_Down}
return
#If
;;;;;The end #IF tag of FnSwitch 0312
#If (FnSwitch(0313)=1)
Label0313:
If (CheckSogouIME()=1)
	GoSub,KillSogouIME
if A_OSVersion not in WIN_7,WIN_8,WIN_9,WIN_VISTA
SoundSet, +1, , mute
else
Send {Volume_Mute}
return
#If
;;;;;The end #IF tag of FnSwitch 0313

;;;;;;;;;;;;SoundSet, 0

#If (FnSwitch(0314)=1)
Label0314:

If (A_OSVersion="WIN_XP")
{
SoundGet, MUTE_ONOFF, , mute
If(MUTE_ONOFF="Off")
{
	SoundSet, %Vol_Home%
	;msgbox,%MUTE_ONOFF%
}
else
{
SoundSet, %Vol_Home%
SoundSet, +1, , mute
}
}
else
{
Send {Volume_Down 50}
temp0:=(Vol_Home+0)/2
;msgbox,%temp0%
Send {Volume_Up %temp0%}
}
return
#If
;;;;;The end #IF tag of FnSwitch 0314



Show_Vol(Now_Vol)
{
if Now_Vol=0
	return 0
else
{
Var = %Now_Vol%
SetFormat, float, 6.0
Var -= 1
Var += 1
return Var
}
}




MouseIsOver(WinTitle,x) {

	SysGet, MonFull, Monitor
	MouseGetPos, xpos, ypos , Win
;If (xpos>MonFullRight-10 and ypos>MonFullBottom-20)
	return WinExist(WinTitle . " ahk_id " . Win) and xpos>MonFullRight*x
}
MouseIsOver2(WinTitle,x) {

	SysGet, MonFull, Monitor
	MouseGetPos, xpos, ypos , Win
;If (xpos>MonFullRight-10 and ypos>MonFullBottom-20)
	return WinExist(WinTitle . " ahk_id " . Win) and xpos<MonFullRight*x
}


SetAltTab_0:
SetTimer, SetAltTab_0, Off
AltTabing=0
return

Set1secAfterWheel_0:
SetTimer, Set1secAfterWheel_0, Off
1secAfterWheel=0
return






;;;;;;;===============================================5结束#If
;;;;;;;;;;;;;;;SoundSet, +1, , mute；；；；；
#If (FnSwitch(0315)=1)
Label0315:                       ;宅男键
Keywait, APPSKEY, , t0.3
if errorlevel = 1
	send,{APPSKEY}
else
Keywait, APPSKEY, d, t0.3
if errorlevel = 0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;开始
{


Send, {LWINDOWN}m{LWINUP}
If (A_OSVersion="WIN_XP")
SoundSet, 0
else
{
Send {Volume_Mute}
Send {Volume_Down 30}
}
SendMessage,0x112,0xF170,2,,Program Manager
;;BlockInput On
;;SetTimer, BIOff, -600000

}
else
send,{APPSKEY}
return
#If
;;;;;The end #IF tag of FnSwitch 0315

ZNK_PW:
Send, {LWINDOWN}m{LWINUP}
If (A_OSVersion="WIN_XP")
SoundSet, 0
else
{
Send {Volume_Mute}
Send {Volume_Down 30}
}
SendMessage,0x112,0xF170,2,,Program Manager

run ,C:\Windows\system32\rundll32.exe user32.dll LockWorkStation
;;;BlockInput On
;;;SetTimer, BIOff, -600000
;;;;;;;;;;;;;;BlockInput ,MouseMove
return
#If (FnSwitch(0316)=1)
Label0316:

Gosub,ZNK_PW
return
;;;;;;;;;;;;;;;;;;;;;;>^Del::                         ;宅男键(加密) 
#If
;;;;;The end #IF tag of FnSwitch 0316
#If (FnSwitch(0317)=1)
Label0317:
GoSub,BlackScreen                     ;黑屏
return
#If
;;;;;The end #IF tag of FnSwitch 0317



BlackScreen:
KeyWait b  
KeyWait LWin
KeyWait RWin
BlockInput,On
BlockInput,MouseMove
MsgBox, 262192, HK4WIN 警告, 即将黑屏，请松开鼠标。,5
SendMessage,0x112,0xF170,2 ,,Program Manager
;;;;;BlockInput On
;;;;;SetTimer, BIOff, -3000
;BlockInput,MouseMove
;SetTimer, BIOff, 10000
sleep,500
SendMessage,0x112,0xF170,2 ,,Program Manager
sleep,500
SendMessage,0x112,0xF170,2 ,,Program Manager
sleep,500
SendMessage,0x112,0xF170,2 ,,Program Manager
sleep,500
SendMessage,0x112,0xF170,2 ,,Program Manager
sleep,500
SendMessage,0x112,0xF170,2 ,,Program Manager
BlockInput,MouseMoveOff
BlockInput,Off
Return

#If (FnSwitch(0318)=1)
Label0318:
GoSub,BlackScreenLock                         ;黑屏lock
return
#If
;;;;;The end #IF tag of FnSwitch 0318

BlackScreenLock:
KeyWait b  
KeyWait LWin
KeyWait RWin
BlockInput,On
BlockInput,MouseMove
MsgBox, 262192, HK4WIN 警告, 即将黑屏（锁），请松开鼠标。,5
SendMessage,0x112,0xF170,2 ,,Program Manager
run ,C:\Windows\system32\rundll32.exe user32.dll LockWorkStation
sleep,500
SendMessage,0x112,0xF170,2 ,,Program Manager
sleep,500
SendMessage,0x112,0xF170,2 ,,Program Manager
sleep,500
SendMessage,0x112,0xF170,2 ,,Program Manager
sleep,500
SendMessage,0x112,0xF170,2 ,,Program Manager
sleep,500
SendMessage,0x112,0xF170,2 ,,Program Manager
BlockInput,MouseMoveOff
BlockInput,Off
Return



#If (FnSwitch(0319)=1)
Label0319:                         ;默认屏保
KeyWait s  
KeyWait LWin
KeyWait RWin

SendMessage, 0x112, 0xF140, 0,, Program Manager
Return
#If
;;;;;The end #IF tag of FnSwitch 0319

;;;;;;;;;;;;;;;;;;;;;;;;;;;#+b::BlockInput MouseMove


#If (FnSwitch(0320)=1)
Label0320:             ;关闭窗口


Keywait, Esc, , t0.2
if ((errorlevel="1"))
return
else
Keywait, Esc, d, t0.2
if errorlevel = 0
{
;send !{F4}
if (WinActive("AutoCAD 20"))
return

GoSub,SecKill
}
return
#If
;;;;;The end #IF tag of FnSwitch 0320
#If (FnSwitch(0321)=1)
~LShift & RShift::             ;关闭窗口
~RShift & LShift::

send !{F4}
return
#If
;;;;;The end #IF tag of FnSwitch 0321
#If (FnSwitch(0323)="1" and IsGaming()="0")
~Left & Right::             ;左右键最大化
~Right & Left::
{
WinGet, DAXIAO , MinMax, A
if (DAXIAO = "1")
	{
	WinRestore, A
	}
else
	{
	;;;;;;;;;;;;;;WinGet, Last_Max_Id, ID, A
	WinMaximize, A
	}

}

return
#If
;;;;;The end #IF tag of FnSwitch 0323
#If (FnSwitch(0322)=1)
Label0322:             ;最大化
Keywait, LAlt, , t0.3
if errorlevel = 1
return
else
Keywait, LAlt, d, t0.3
if errorlevel = 0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;开始最大化
{
;;;;;;Last_Min_Id=0
WinGet, DAXIAO , MinMax, A
if (DAXIAO = "1")
	{
	;;;;;;;;;WinRestore, ahk_id %Last_Max_Id%
	;WinRestore, A
	PostMessage, 0x112, 0xF120,,, A  ; 0x112 = WM_SYSCOMMAND, 0xF120 = SC_RESTORE
	}
else
	{
	;;;;;;;;;;;;;;;WinGet, Last_Max_Id, ID, A
	;WinMaximize, A
	PostMessage, 0x112, 0xF030,,, A  ; 0x112 = WM_SYSCOMMAND, 0xF030 = SC_MAXIMIZE
	}

}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;最大化结束

return
#If
;;;;;The end #IF tag of FnSwitch 0322
#If (FnSwitch(0326)=1)
Label0326:             ;最小化

Keywait, RAlt, , t0.3
if errorlevel = 1
return
else
Keywait, RAlt, d, t0.3
if errorlevel = 0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;开始最小化
{


If (WinActive("ahk_class Progman") or WinActive("ahk_class WorkerW"))
{
;msgbox,,333,3333,1
}
else
{
;msgbox,,444,4444,1
Last_Max_Id=0
	WinGet, Last_Min_Id, ID, A
	if (MinMemo1 = "0")
		MinMemo1=%Last_Min_Id%
	else if(MinMemo2 = "0")
		{
		MinMemo2=%MinMemo1%
		MinMemo1=%Last_Min_Id%
		}
	else
		{
		MinMemo3=%MinMemo2%
		MinMemo2=%MinMemo1%
		MinMemo1=%Last_Min_Id%	
		}
	;WinMinimize, A
	;PostMessage, 0x112, 0xF020,,, A ; 0x112 = WM_SYSCOMMAND, 0xF020 = SC_MINIMIZE
			IfWinNotActive ahk_class TXGuiFoundation
				WinMinimize, A
			else
				{
				
				WinGetTitle, Temp0 , A
				If Temp0 contains QQ20
					{
						;PlayWAV("ding")
						sleep,100
						Send, {CTRLDOWN}{ALTDOWN}z{ALTUP}{CTRLUP}
					}
				else
					WinMinimize, A
				}
}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;最小化结束

return
#If
;;;;;The end #IF tag of FnSwitch 0326


#If (FnSwitch(0325)=1)
Label0325:             ;恢复窗口

WinRestore, A
;;;;;;;;;;;if (Last_Max_Id = "0")
;;;;;;;;;;;;	{
;;;;;;;;;;;;;;;;	WinRestore, A
;;;;;;;;;;;;;	}
;;;;;;;;;;;;else
;;;;;;;;;;;;	{
;;;;;;;;;;;;;	WinRestore, ahk_id %Last_Max_Id%
;;;;;;;;;;;;;;	}

return
#If
;;;;;The end #IF tag of FnSwitch 0325
#If (FnSwitch(0327)=1)
Label0327:             ;恢复窗口

if (MinMemo1 = "0")
	{
	WinRestore, A
	WinActivate,A
	}
else if (MinMemo2 = "0")
	{
	WinRestore, ahk_id %MinMemo1%
	WinActivate, ahk_id %MinMemo1%
	MinMemo1=0
	}
else if (MinMemo3 = "0")
	{
	WinRestore, ahk_id %MinMemo1%
	WinActivate, ahk_id %MinMemo1%
	MinMemo1=%MinMemo2%
	MinMemo2=0
	}
else
	{
	WinRestore, ahk_id %MinMemo1%
	WinActivate, ahk_id %MinMemo1%
	MinMemo1=%MinMemo2%
	MinMemo2=%MinMemo3%
	MinMemo3=0
	}

return
#If
;;;;;The end #IF tag of FnSwitch 0327



; 代码结束
#If (FnSwitch(0339)="1")
~RShift & WheelUp::
;
; 透明度调整
		WinGet, Transparent, Transparent,A	
		If (Transparent="")
			Transparent=255
		Transparent_New:=Transparent+10
		;msgbox,Transparent_New=%Transparent_New%
		If (Transparent_New > 254)
                Transparent_New =255

		WinSet,Transparent,%Transparent_New%,A

return

~RShift & WheelDown::
;
		WinGet, Transparent, Transparent,A		
		If (Transparent="")
			Transparent=255
		Transparent_New:=Transparent-10
		;msgbox,Transparent_New=%Transparent_New%
        If (Transparent_New < 30)
                Transparent_New = 30	
		WinSet,Transparent,%Transparent_New%,A


return
#If
;;;;;The end #IF tag of FnSwitch 0339


#If (FnSwitch(0341)="1")
RButton & WheelUp::

send,,^{+}
sleep,200

return

RButton & WheelDown::

send,^{-}
sleep,200

return
#If
;;;;;The end #IF tag of FnSwitch 0341


#If (FnSwitch(0328)=1)
Label0328:  ; Scroll left.使用鼠标滚轮实现左右滚动
;
if (WinActive("ahk_class XLMAIN"))
{
	ControlGet, hwnd, hwnd, , Excel71, ahk_class XLMAIN
	Acc_ObjectFromWindow(hwnd, -16).SmallScroll(0,0,0,InStr(A_ThisHotkey,"Right")? -1:1)
}
else
{
	ControlGetFocus, fcontrol, A
	Loop 10  ; <-- Increase this value to scroll faster.
		SendMessage, 0x114, 0, 0, %fcontrol%, A  ; 0x114 is WM_HSCROLL and the 0 after it is SB_LINELEFT.
}

return

~RAlt & WheelDown::  ; Scroll right.
;
if (WinActive("ahk_class XLMAIN"))
{
	ControlGet, hwnd, hwnd, , Excel71, ahk_class XLMAIN
	Acc_ObjectFromWindow(hwnd, -16).SmallScroll(0,0,InStr(A_ThisHotkey,"Left")? -1:1)
}
else
{
	ControlGetFocus, fcontrol, A
	Loop 10  ; <-- Increase this value to scroll faster.
		SendMessage, 0x114, 1, 0, %fcontrol%, A  ; 0x114 is WM_HSCROLL and the 1 after it is SB_LINERIGHT.
}

return


Acc_ObjectFromWindow(hWnd, idObject = -4)
{
	Acc_Init()
	If	DllCall("oleacc\AccessibleObjectFromWindow", "Ptr", hWnd, "UInt", idObject&=0xFFFFFFFF, "Ptr", -VarSetCapacity(IID,16)+NumPut(idObject==0xFFFFFFF0?0x46000000000000C0:0x719B3800AA000C81,NumPut(idObject==0xFFFFFFF0?0x0000000000020400:0x11CF3C3D618736E0,IID,"Int64"),"Int64"), "Ptr*", pacc)=0
	Return	ComObjEnwrap(9,pacc,1)
}
Acc_Init()
{
	Static	h
	If Not	h
		h:=DllCall("LoadLibrary","Str","oleacc","Ptr")
}

#If
;;;;;The end #IF tag of FnSwitch 0328

#If (FnSwitch(0329)=1)
Label0329:  ; Scroll up faster.上下快速滚动
;
ControlGetFocus, fcontrol, A
Loop 20  ; <-- Increase this value to scroll faster.
    SendMessage, 0x115, 0, 0, %fcontrol%, A  ; 0x114 is WM_HSCROLL and the 0 after it is SB_LINELEFT.
return

~RCtrl & WheelDown::  ; Scroll down faster.
;
ControlGetFocus, fcontrol, A
Loop 20  ; <-- Increase this value to scroll faster.
    SendMessage, 0x115, 1, 0, %fcontrol%, A  ; 0x114 is WM_HSCROLL and the 1 after it is SB_LINERIGHT.
return
#If
;;;;;The end #IF tag of FnSwitch 0329


#If (FnSwitch(0102)=1)
Label0102:            ;显示桌面
Keywait, Capslock, , t0.3
if errorlevel = 1
return
else
Keywait, Capslock, d, t0.3
if errorlevel = 0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;开始
{
send,#d

}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;结束
return
#If
;;;;;The end #IF tag of FnSwitch 0102
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;层叠窗口
#If (FnSwitch(0332)=1)
Label0332:
;;;;;;;;;;;msgbox,SCROLL_MENU=1
;;;;;SysGet, SCREEN_WIDTH, 16
;;;;;;SysGet, SCREEN_HEIGHT, 17
;;;;;;;;;;if A_OSVersion in WIN_XP,WIN_VISTA,WIN_2003,WIN_2000
If(A_OSVersion="WIN_XP")
{
BlockInput ,On
MouseGetPos, xposSL, yposSL

;Click right %MonFullRight%,%MonFullBottom%
MouseClick,Right,%MonFullRight%,%MonFullBottom%
sleep,200
If (SCROLL_MENU=3)
	{
	send,{Down 4}
	sleep,200
	send,{Enter}
	SCROLL_MENU=1
	;;;;;;;;msgbox,SCROLL_MENU=1
	}
else if (SCROLL_MENU=1)
	{
	send,h
	SCROLL_MENU=2
	;;;;;;;msgbox,SCROLL_MENU=2
	}
else if (SCROLL_MENU=2)
	{
	send,e
	SCROLL_MENU=3
	;;;;;;;;;;msgbox,SCROLL_MENU=3
	}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;MSGBOX,%xposSL%----%yposSL%
MouseMove, %xposSL%, %yposSL%
BlockInput ,Off
	
}
else
{
;;;;;;;;;;SoundPlay *48
Send, {SHIFTDOWN}{SCROLLLOCK}{SHIFTUP}
}




Return
#If
;;;;;The end #IF tag of FnSwitch 0332


;WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW  系统功能    结束   WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW


;WheelUp::
;MouseGetPos, OutputVarX, OutputVarY, OutputVarWin, OutputVarControl
;;msgbox,%OutputVarX%--%OutputVarY%--%OutputVarWin%--%OutputVarControl%
;ControlClick , Internet Explorer_Server1, , , WU
;return
;WheelDown::
;MouseGetPos, OutputVarX, OutputVarY, OutputVarWin, OutputVarControl
;;msgbox,%OutputVarX%--%OutputVarY%--%OutputVarWin%--%OutputVarControl%
;ControlClick ,Internet Explorer_Server1 ,, , WD
;return

#If (FnSwitch(0303)=1)
Label0303:
BlockInput MouseMove
send,#r
sleep,200
SendInput {Raw}control
send,{Enter}
BlockInput MouseMoveOff

return
#If
;;;;;The end #IF tag of FnSwitch 0303


;SSSSSSSSSSSSSSSSS用快捷键得到当前选中文件的路径SSSSSSSSSSSSSSSS
#If (FnSwitch(0330)=1)
Label0330:
;If (sClass="CabinetWClass" || sClass="ExploreWClass")
if (WinActive("ahk_class CabinetWClass") or WinActive("ahk_class ExploreWClass")or WinActive("ahk_class Progman")or WinActive("ahk_class WorkerW"))
;;
{
Clipboard=
send ^c
sleep,100
;ClipWait,3
clipboard=%clipboard% ;%null%
tooltip,已复制以下路径`n%clipboard%
sleep,2000
tooltip,
}
return
#If
;;;;;The end #IF tag of FnSwitch 0330
;EEEEEEEEEEEEEEEEEEEEE用快捷键得到当前选中文件的路径EEEEEEEEEEEEEEE


;SSSSSSSSSSSSSSSSS秒杀窗口，左键加右键SSSSSSSSSSSSSSSS
#If (FnSwitch(0331)=1)
~LButton & RButton::
SecKilling=1
SetTimer, StopSecKilling, -500
SetTimer, SecKillingUpKeys, -2000
SetTimer, SecKillingUpKeys, -5000
SetTimer, SecKillingUpKeys, -60000
GoSub,SecKill
SecKilling=0
return


SecKillingUpKeys:
{
GetKeyState, AltKeyState, Alt,P
GetKeyState, CtrlKeyState, Ctrl,P
If(AltKeyState="U")
	{
	send {Alt Up}
	}
If(CtrlKeyState="U")
	{
	send {Ctrl Up}
	}
return
}



StopSecKilling:
{
SecKilling=0
return
}



SecKill:
WinGetPos , X, Y, Width, Height, A
SysGet, MonFull, Monitor
If(X=0)&&(Y=0)&&(Width=MonFullRight)&&(Height=MonFullBottom)
{
	If  WinActive("ahk_class Progman")or WinActive("ahk_class WorkerW")
		goto,skip7854
	else
	{
		Gaming="1"
		;msgbox,seckill blocked
		SecKilling=0
			return
	}
}
else
{
	Gaming="0"
}
skip7854:	
BlockInput Off
if (MOUSE_ESC_LOCK=0)
{
;tooltip,seckil 111
Keywait, RButton, , t0.4
WinGetClass, MouseClass, A

;if WinActive("ahk_class MozillaWindowClass") or WinActive("ahk_class IEFrame") or WinActive("ahk_class Chrome_WidgetWin_1") or WinActive("ahk_class MozillaUIWindowClass") or WinActive("ahk_class Chrome_WidgetWin_0") or WinActive("ahk_class OperaWindowClass") or WinActive("ahk_class Notepad++")or WinActive("ahk_class Chrome_WidgetWin_2")or WinActive("ahk_class Chrome_WidgetWin_3")
If MouseClass contains %SecKill%
		{

		
		
		SetTimer , MakeCtrlKeyUp, -700
		Send {Control Down}
		

		SetTimer , MakeWKeyUp, -1000
		Send {w down}
		
		sleep,50
		Send {Ctrl Up}{w Up}
		
		;tooltip,seckil CTRL W  END
		}
else
		{

		
		SetTimer , MakeAltKeyUp, -700
		Send {Alt Down}
		

		SetTimer , MakeF4KeyUp, -1000
		Send {F4 down}
		
		sleep,50
		Send {Alt Up}{F4 Up}
		;tooltip,seckil Alt F4 END
		}
		
		
}
else
{
SoundPlay *48
	;tooltip,HK4WIN : 请按 Alt + Pause 以使 鼠标左 + 右 = 关闭
	;SetTimer, RemoveToolTip, 2000
	TrayTip , HK4WIN, 请按 Alt + Pause 以开启秒杀功能, 5, 3
}
return
#If
;;;;;The end #IF tag of FnSwitch 0331
MakeCtrlKeyUp:
Send {Ctrl Up}
return
MakeWKeyUp:
Send {w Up}
return
MakeAltKeyUp:
Send {Alt Up}
return
MakeF4KeyUp:
Send {F4 Up}
return
MakeCtrlKeyUp222:
		MakeCtrlKeyUpCount++
		If MakeCtrlKeyUpCount in 1,2
		{
		;tooltip,CTRLUP
			Send {Ctrl Up}{RCtrl Up}{LCtrl Up}
		;tooltip
		}
		else if(MakeCtrlKeyUpCount=3)
		{
		MakeCtrlKeyUpCount=0
		SetTimer, MakeCtrlKeyUp, Off
		}
return

MakeAltKeyUp222:
		MakeAltKeyUpCount++
		If MakeAltKeyUpCount in 1,2,3,10,20
		{
		;tooltip,ALTUP
			Send {ALTUP}{Alt Up}{RAlt Up}{LAlt Up}
		;tooltip
		}
		else if(MakeAltKeyUpCount=21)
		{
		MakeAltKeyUpCount=0
		SetTimer, MakeAltKeyUp, Off
		}
return

ChangeIME:
If (AutoIME="" or AutoImeList="")
return
WinGetClass,ImeClass,A
If (ImeClassLast=ImeClass)
return
ImeClassLast:=ImeClass
;
If ImeClass in %AutoImeList%
	SwitchIME(AutoIME)

;msgbox,ImeClassLast=%ImeClassLast% AutoIME=%AutoIME%
return

SwitchIME(dwLayout)
{
HKL:=DllCall("LoadKeyboardLayout", Str, dwLayout, UInt, 1)
ControlGetFocus,ctl,A
SendMessage,0x50,0,HKL,%ctl%,A
}
;???????????????????????右下角桌面  开始??????????????????
#If (FnSwitch(0103)=1 && A_OSVersion="WIN_XP")
Label0103:
MouseGetPos, xpos, ypos
If (xpos>MonFullRight-10 and ypos>MonFullBottom-20)
	send,#d
return
#If
;;;;;The end #IF tag of FnSwitch 0103
;???????????????????????右下角桌面  结束??????????????????
~LButton::
{
SetTimer, ChangeIME, -500
SetTimer, ChangeTransparent, -700


;send {LButton}

}



ChangeTransparent:
If (TransparentList="")
return
;global ImeClass
MouseGetPos,x,y,MouseID,MouseControl
WinGetClass,MouseClass,ahk_id %MouseID%
;msgbox,%FnID%---000 BlackList=%BlackList%
		If MouseClass in %TransparentList%
		{
		WinGet, Transparent_V, Transparent,A
		If TransparentValue is not integer
			TransparentValue=150
		If (TransparentValue<30||TransparentValue>255)
			TransparentValue=150		
		If ((Transparent_V<>%TransparentValue%)&&(Transparent_V<>255))
			return
			
		WinSet,Transparent,%TransparentValue%,A
		
		
		
		}
return







;????????????????????????????  热词缩写  ?????????????????????????????????????

#If (FnSwitch(0502)=1)
:*:][::
FormatTime, CurrentDateTime,, yyyy-M-d H:mm:ss
;;SendInput %CurrentDateTime%
		temp0=%ClipBoard%
		sleep,20
		ClipBoard=%CurrentDateTime%
		sleep,20
		send,^v
		sleep,200
		ClipBoard=%temp0%
return
#If

#If (FnSwitch(0501)=1)

 


:*:]1::  
FastInput("1")
return
:*:]2::  
FastInput("2")
return
:*:]3::  
FastInput("3")
return
:*:]4::  
FastInput("4")
return
:*:]5::  
FastInput("5")
return
:*:]6::  
FastInput("6")
return
:*:]7::  
FastInput("7")
return
:*:]8::  
FastInput("8")
return
:*:]9::  
FastInput("9")
return
:*:]0::  
FastInput("0")
return
:*:]a::  
FastInput("a")
return
:*:]b::  
FastInput("b")
return
:*:]c::  
FastInput("c")
return
:*:]d::  
FastInput("d")
return
:*:]e::  
FastInput("e")
return
:*:]f::  
FastInput("f")
return
:*:]g::  
FastInput("g")
return
:*:]h::  
FastInput("h")
return
:*:]i::  
FastInput("i")
return
:*:]j::  
FastInput("j")
return
:*:]k::  
FastInput("k")
return
:*:]l::  
FastInput("l")
return
:*:]m::  
FastInput("m")
return
:*:]n::  
FastInput("n")
return
:*:]o::  
FastInput("o")
return
:*:]p::  
FastInput("p")
return
:*:]q::  
FastInput("q")
return
:*:]r::  
FastInput("r")
return
:*:]s::  
FastInput("s")
return
:*:]t::  
FastInput("t")
return
:*:]u::  
FastInput("u")
return
:*:]v::  
FastInput("v")
return
:*:]w::  
FastInput("w")
return
:*:]x::  
FastInput("x")
return
:*:]y::  
FastInput("y")
return
:*:]z::
FastInput("z")
return
#If
;;;;;The end #IF tag of FnSwitch 0501



#If (FnSwitch(0503)=1)
:*:,,::

		temp0503=%ClipBoard% 
		sleep,50
		ClipBoard=,
		send,^v
		ClipBoard=%temp0503%
return
#If





FastInput(TheHotKey)
{
IfExist, %A_ScriptDir%\HK4WIN_SET.ini
{	IniRead, FastWord, %A_ScriptDir%\HK4WIN_SET.ini, FastInput, %TheHotKey%
;;;msgbox,FastWord==%FastWord%
	If (FastWord<>"")
	{
		temp0988979=%ClipBoard% 
		sleep,50
		ClipBoard=%FastWord%
		send,^v
		ClipBoard=%temp0988979%
	}
	else
		SendInput, {]}{%TheHotKey%}
}
else
	SendInput, {]}{%TheHotKey%}
}


;?????????????????????????  控制面板  ?????????????????????????????
#If (FnSwitch(0305)=1)
Label0305:
Run rundll32.exe shell32.dll`,Control_RunDLL desk.cpl`,`, 1;屏保设置


return
#If
;;;;;The end #IF tag of FnSwitch 0305




#If (FnSwitch(0306)=1)
Label0306:
GoSub,AppWiz
return
#If
;;;;;The end #IF tag of FnSwitch 0306

AppWiz:
if A_OSVersion = "WIN_XP"
{
Run rundll32.exe shell32.dll`,Control_RunDLL appwiz.cpl
	Run rundll32.exe shell32.dll`,Control_RunDLL appwiz.cpl`,`, 0;添加和删除程序。
}
else
{
Run rundll32.exe shell32.dll`,Control_RunDLL appwiz.cpl
}
return


#If (FnSwitch(0307)=1)
Label0307:


if A_OSVersion = "WIN_XP"
{
	Run rundll32.exe shell32.dll`,Control_RunDLL inetcpl.cpl`,`, 6;IE选项
	Run rundll32.exe shell32.dll`,Control_RunDLL inetcpl.cpl
}
else
{
Run rundll32.exe shell32.dll`,Control_RunDLL inetcpl.cpl
}
return
#If
;;;;;The end #IF tag of FnSwitch 0307

#If (FnSwitch(0308)=1)
Label0308:
GoSub,WinUserAcc
return
#If
;;;;;The end #IF tag of FnSwitch 0308
WinUserAcc:
if A_OSVersion = "WIN_XP"
{
	Run rundll32.exe shell32.dll`,Control_RunDLL nusrmgr.cpl`,`, 0;添加和删除程序。
	Run rundll32.exe shell32.dll`,Control_RunDLL nusrmgr.cpl
}
else
{
Run rundll32.exe shell32.dll`,Control_RunDLL nusrmgr.cpl
}
return


#If (FnSwitch(0309)=1)
Label0309:


if A_OSVersion = "WIN_XP"
{
	Run rundll32.exe shell32.dll`,Control_RunDLL powercfg.cpl`,`, 0;电源
	Run rundll32.exe shell32.dll`,Control_RunDLL powercfg.cpl
}
else
{
Run rundll32.exe shell32.dll`,Control_RunDLL powercfg.cpl
}
return
#If
;;;;;The end #IF tag of FnSwitch 0309




;;;$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
;;%%%%%%%%%%%%%%%%%%%%%%%%%%%   WMP组件  开始  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
WMP_LAUNCHED()
{
Process, Exist,wmplayer.exe
if (ErrorLevel<>0)
	return 1
else
	return 0

}

#If (FnSwitch(0214)=1)
Label0214:

if WMP_LAUNCHED()
{
send,{Media_Stop}
Run ,%A_ProgramFiles%\Windows Media Player\wmplayer.exe
sleep,300
WinClose ,Windows Media Player
}
return
#If
;;;;;The end #IF tag of FnSwitch 0214


#If (FnSwitch(0212)=1)
Label0212:

send,{Media_Stop}
sleep,200
send,{Media_Play_Pause}
return
#If
;;;;;The end #IF tag of FnSwitch 0212

#If (FnSwitch(0213)=1)
Label0213:
send,{Media_Stop}

return
#If
;;;;;The end #IF tag of FnSwitch 0213
;;;;;;;;;;;;;;;;;;;;;;;;;;;;>!m::GoSub,LAUCH_WMP_AND_PLAY


#If (FnSwitch(0208)=1)
Label0208:
if WMP_LAUNCHED()
	send,{Media_Next}
else
	GoSub,LAUCH_WMP_AND_PLAY
	
	
return
#If
;;;;;The end #IF tag of FnSwitch 0208


#If (FnSwitch(0207)=1)
Label0207:
if WMP_LAUNCHED()
	send,{Media_Prev}
else
	GoSub,LAUCH_WMP_AND_PLAY
	

return
#If
;;;;;The end #IF tag of FnSwitch 0207
#If (FnSwitch(0209)=1)
Label0209:
;;;;;keywait,RAlt
if WMP_LAUNCHED()
{
	send,{Media_Play_Pause}
	
}
else
	GoSub,LAUCH_WMP_AND_PLAY

	
return
#If
;;;;;The end #IF tag of FnSwitch 0209
;;;;;;;;;;;;;;;;;;;;;最小化WMP
#If (FnSwitch(0210)=1)
Label0210:
if WMP_LAUNCHED()
{
	IfWinExist, Windows Media Player
		WinMinimize ,ahk_class WMPlayerApp
	else
	{
		Run ,%A_ProgramFiles%\Windows Media Player\wmplayer.exe,,Min
	}
}
else
{
	Run ,%A_ProgramFiles%\Windows Media Player\wmplayer.exe,,Min
	WinWait ,ahk_class WMPlayerApp
	WinMinimize ,ahk_class WMPlayerApp
	sleep,1000
	send,{Media_Play_Pause}
}


return
#If
;;;;;The end #IF tag of FnSwitch 0210
;;;;;;;;;;;;;;;;;;;;;隐藏WMP




#If (FnSwitch(0211)=1)
Label0211:
if WMP_LAUNCHED()
{
	IfWinExist, Windows Media Player
		WinHide , ahk_class WMPlayerApp
	else
	{
	Run ,%A_ProgramFiles%\Windows Media Player\wmplayer.exe,,Min
	WinWait ,ahk_class WMPlayerApp
		;;WinHide , ahk_class WMPlayerApp
	}
	
}
else
{
	Run ,%A_ProgramFiles%\Windows Media Player\wmplayer.exe	
	WinWait ,ahk_class WMPlayerApp
	WinHide , ahk_class WMPlayerApp
	sleep,1000
	send,{Media_Play_Pause}
}


return
#If
;;;;;The end #IF tag of FnSwitch 0211
LAUCH_WMP_AND_PLAY:
;;;;Run ,%A_ProgramFiles%\Windows Media Player\wmplayer.exe,,Min
Run, wmplayer.exe, %A_ProgramFiles%\Windows Media Player, Min
sleep,1000
send,{Media_Play_Pause}

return

#If (FnSwitch(0216)=1 && (WinActive("ahk_class WMP Skin Host") || WinActive("ahk_class WMPTransition") || WinActive("ahk_class CWmpControlCntr")))
Label0216:
;;;; 
{
Send,^p	
}

return

#If
;;;;;The end #IF tag of FnSwitch 0216

#If (IsGaming()="1" and FnSwitch(0216)=1 and (WinActive("ahk_class WMP Skin Host2222") or WinActive("ahk_class WMPTransition")))
$LButton::
;;;; 
{

	SysGet, MonFull, Monitor
	MouseGetPos, xpos, ypos , Win
	If (ypos<MonFullBottom*0.860317)
		Send,^p
	;else
		;send,{LButton}
		
}

return
#If


#If  (FnSwitch(0217)=1 && (WinActive("ahk_class WMP Skin Host") || WinActive("ahk_class WMPTransition") || WinActive("ahk_class CWmpControlCntr")))
Label0217:
$Enter::
{
Send,!{Enter}
}

return
#If
;;;;;The end #IF tag of FnSwitch 0217




#If (FnSwitch(0218)=1)
Label0218:
if (WinActive("AutoCAD"))
{
	MouseGetPos,x,y,MouseID,MouseControl
	WinGetClass,MouseClass,ahk_id %MouseID%
	If MouseClass contains Afx
		Send,{Del}
	else
		Send ,{ASC 0096}

}
else
	Send ,{ASC 0096}
return
#If
;;;;;The end #IF tag of FnSwitch 0218
#If (FnSwitch(0219)=1)
Label0219:
if (WinActive("AutoCAD"))
{
	MouseGetPos,x,y,MouseID,MouseControl
	WinGetClass,MouseClass,ahk_id %MouseID%
	If MouseClass contains Afx
		Send,{Enter}
	else
		Send ,{TAB}

}
else
	Send ,{TAB}
return
#If
;;;;;The end #IF tag of FnSwitch 0219
;;%%%%%%%%%%%%%%%%%%%%%%%%%%%   WMP组件  结束  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




;########################### INI启动程序  开始###########################
#If (FnSwitch(0201)=1)
$<^<!1::Launch_App_2("1")
$<^<!2::Launch_App_2("2")
$<^<!3::Launch_App_2("3")
$<^<!4::Launch_App_2("4")
$<^<!5::Launch_App_2("5")
$<^<!6::Launch_App_2("6")
$<^<!7::Launch_App_2("7")
$<^<!8::Launch_App_2("8")
$<^<!9::Launch_App_2("9")
$<^<!0::Launch_App_2("0")
$<^<!a::Launch_App("a")
$<^<!b::Launch_App("b")
$<^<!c::Launch_App("c")
$<^<!d::Launch_App("d")
$<^<!e::Launch_App("e")
$<^<!f::Launch_App("f")
$<^<!g::Launch_App("g")
$<^<!h::Launch_App("h")
$<^<!i::Launch_App("i")
$<^<!j::Launch_App("j")
$<^<!k::Launch_App("k")
$<^<!l::Launch_App("l")
$<^<!m::Launch_App("m")
$<^<!n::Launch_App("n")
$<^<!o::Launch_App("o")
$<^<!p::Launch_App("p")
$<^<!q::Launch_App("q")
$<^<!r::Launch_App("r")
$<^<!s::Launch_App("s")
$<^<!t::Launch_App("t")
$<^<!u::Launch_App("u")
$<^<!v::Launch_App("v")
$<^<!w::Launch_App("w")
$<^<!x::Launch_App("x")
$<^<!y::Launch_App("y")
$<^<!z::Launch_App("z")
#If
;;;;;The end #IF tag of FnSwitch 0201
;#############################  公用函数：启动程序  开始#################################
Launch_App(TheHotKey)
{


global OpenAppMax_V
IfExist, %A_ScriptDir%\HK4WIN_SET.ini
{	IniRead, OpenApp_ID, %A_ScriptDir%\HK4WIN_SET.ini, OpenApp, %TheHotKey%
			If (OpenApp_ID<>"")
		{

		IfExist, %OpenApp_ID%	
{		
;msgbox,OpenApp_ID=%OpenApp_ID%
;IniRead, OpenAppMax_V, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,OpenAppMax
;msgbox,443 %OpenAppMax_V%  4444
If OpenAppMax_V=N
{
		MsgBox, 262180, HK4WIN 最大化, 您想以普通大小窗口还是最大化的窗口启动程序？`n是：普通大小；否：最大化`n`n注：某些程序可能无法被最大化。如果以后需要修改此设置请按 Ctrl+Alt+Shift+Z 打开设置窗口，在用户参数设置中找到OpenAppMax，修改等号之后的值，1为最大化，0为普通大小。
	IfMsgBox No
	{
		IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,OpenAppMax
		OpenAppMax_V=1
		Run ,%OpenApp_ID%,,Max
		;msgbox,runed----%OpenApp_ID%
	}
	else
	{
		IniWrite, 0, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,OpenAppMax
		OpenAppMax_V=0
		Run ,%OpenApp_ID%
	}
		
		

}
;;IniRead, OpenAppMax_V, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,OpenAppMax
else If OpenAppMax_V=0
	Run ,%OpenApp_ID%
else
	Run ,%OpenApp_ID%,,Max
			
}
			else
			{
			;否则，ini里为错误
						MsgBox, 0, HK4WIN 错误, 配置文件中指定的程序不存在。这可能是该程序已被卸载或者您拼写有误：`n%OpenApp_ID%,15
						FileSelectFile, UserApp , , ::{20d04fe0-3aea-1069-a2d8-08002b30309d}, 请指定快捷键 LCtrl+LAlt+%TheHotKey% 打开的程序, *.exe; *.bat; *.vbs
						If(UserApp<>"")
						{
						IniWrite, %UserApp%, %A_ScriptDir%\HK4WIN_SET.ini, OpenApp, %TheHotKey%
						Run %UserApp%
						UserApp=""
						}
			}
	}
	else
		Send, ^!%TheHotKey%
		
}
else
	Send, ^!%TheHotKey%
	;;Send, {CTRLDOWN}{ALTDOWN}TheHotKey{ALTUP}{CTRLUP}
}
Launch_App_2(TheHotKey)
{


global OpenAppMax_V
IfExist, %A_ScriptDir%\HK4WIN_SET.ini
{	IniRead, OpenApp_ID, %A_ScriptDir%\HK4WIN_SET.ini, OpenApp, %TheHotKey%
	If (OpenApp_ID<>"")
		{
		IfExist, %OpenApp_ID%		
{		;msgbox,555555

;msgbox,2222222222 %OpenAppMax_V%
If OpenAppMax_V=N
{
		MsgBox, 262180, HK4WIN 最大化, 您想以普通大小窗口还是最大化的窗口启动程序？`n是：普通大小；否：最大化`n`n注：某些程序可能无法被最大化。如果以后需要修改此设置请按 Ctrl+Alt+Shift+Z 打开设置窗口，在用户参数设置中找到OpenAppMax，修改等号之后的值，1为最大化，0为普通大小。
	IfMsgBox No
	{
		IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,OpenAppMax
		OpenAppMax_V=1
		Run ,%OpenApp_ID%,,Max
		;msgbox,runed----%OpenApp_ID%
	}
	else
	{
		IniWrite, 0, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,OpenAppMax
		OpenAppMax_V=0
		Run ,%OpenApp_ID%
	}

}
;IniRead, OpenAppMax_V, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,OpenAppMax
else If OpenAppMax_V=0
	Run ,%OpenApp_ID%
else
	Run ,%OpenApp_ID%,,Max
			
}
		else
		{
		;否则，ini里为错误
						MsgBox, 0, HK4WIN 错误, 配置文件中指定的程序不存在。这可能是该程序已被卸载或者您拼写有误：`n%OpenApp_ID%,15
						FileSelectFile, UserApp , , ::{20d04fe0-3aea-1069-a2d8-08002b30309d}, 请指定快捷键 LCtrl+LAlt+%TheHotKey% 打开的程序, *.exe; *.bat; *.vbs
						If(UserApp<>"")
						{
						IniWrite, %UserApp%, %A_ScriptDir%\HK4WIN_SET.ini, OpenApp, %TheHotKey%
						Run %UserApp%
						UserApp=""
						}
		}
	}
	else
	{
		FileSelectFile, UserApp , , ::{20d04fe0-3aea-1069-a2d8-08002b30309d}, 请指定快捷键 LCtrl+LAlt+%TheHotKey% 打开的程序, *.exe; *.bat; *.vbs
		IniWrite, %UserApp%, %A_ScriptDir%\HK4WIN_SET.ini, OpenApp, %TheHotKey%
		Run %UserApp%

		}
		
}
else
	Send, ^!%TheHotKey%
	;;Send, {CTRLDOWN}{ALTDOWN}TheHotKey{ALTUP}{CTRLUP}
}
;#############################  公用函数：启动程序  结束################################


;########################### INI启动程序  结束###########################
;########################### INI一键上网  开始###########################

#If (FnSwitch(0401)=1)
$>^>!1::Launch_Web_2("1")
$>^>!2::Launch_Web_2("2")
$>^>!3::Launch_Web_2("3")
$>^>!4::Launch_Web_2("4")
$>^>!5::Launch_Web_2("5")
$>^>!6::Launch_Web_2("6")
$>^>!7::Launch_Web_2("7")
$>^>!8::Launch_Web_2("8")
$>^>!9::Launch_Web_2("9")
$>^>!0::Launch_Web_2("0")
$>^>!a::Launch_Web("a")
$>^>!b::Launch_Web("b")
$>^>!c::Launch_Web("c")
$>^>!d::Launch_Web("d")
$>^>!e::Launch_Web("e")
$>^>!f::Launch_Web("f")
$>^>!g::Launch_Web("g")
$>^>!h::Launch_Web("h")
$>^>!i::Launch_Web("i")
$>^>!j::Launch_Web("j")
$>^>!k::Launch_Web("k")
$>^>!l::Launch_Web("l")
$>^>!m::Launch_Web("m")
$>^>!n::Launch_Web("n")
$>^>!o::Launch_Web("o")
$>^>!p::Launch_Web("p")
$>^>!q::Launch_Web("q")
$>^>!r::Launch_Web("r")
$>^>!s::Launch_Web("s")
$>^>!t::Launch_Web("t")
$>^>!u::Launch_Web("u")
$>^>!v::Launch_Web("v")
$>^>!w::Launch_Web("w")
$>^>!x::Launch_Web("x")
$>^>!y::Launch_Web("y")
$>^>!z::Launch_Web("z")
#If
;;;;;The end #IF tag of FnSwitch 0401


#If (FnSwitch(0402)=1)
Label0402:
Run www.google.com/ncr
return
#If
;;;;;The end #IF tag of FnSwitch 0401



;#############################  公用函数：一键上网  开始#################################
Launch_Web(TheHotKey)
{


IfExist, %A_ScriptDir%\HK4WIN_SET.ini
{	IniRead, OpenWeb_ID, %A_ScriptDir%\HK4WIN_SET.ini, OpenWeb, %TheHotKey%
		If (OpenWeb_ID<>"")		
			Run %OpenWeb_ID%,,Max
		else
			Send, ^!%TheHotKey%
		
}
else
	Send, ^!%TheHotKey%
}


Launch_Web_2(TheHotKey)
{


IfExist, %A_ScriptDir%\HK4WIN_SET.ini
{	IniRead, OpenWeb_ID, %A_ScriptDir%\HK4WIN_SET.ini, OpenWeb, %TheHotKey%
	If (OpenWeb_ID="")
		Send, ^!%TheHotKey%
	else If (OpenWeb_ID="http://")
	{
		InputBox, UsrWeb ,一键上网 , 请输入快捷键 RCtrl+RAlt+%TheHotKey% 打开的网址,,300,150,,,,, http://
		if ErrorLevel=0
		{
		IniWrite, %UsrWeb%, %A_ScriptDir%\HK4WIN_SET.ini, OpenWeb, %TheHotKey%
		If (UsrWeb<>"" and UsrWeb<>"http://")
		Run %UsrWeb%,,Max
		}
	}
	else
		Run %OpenWeb_ID%,,Max

		
}
else
	Send, ^!%TheHotKey%
}
;#############################  公用函数：一键上网  结束################################


;########################### INI一键上网  结束###########################


CREATE_INI:
{







;########################### 确定常用程序路径  开始###########################

;;RegRead, WINWORD_dir_temp, HKCR, Applications\Winword.exe\shell\edit\command
	;;StringSplit,pos_WINWORD,WINWORD_dir_temp,`"
	;;IfExist, %pos_WINWORD2%
		;;WINWORD_dir=%pos_WINWORD2%
	;;else IfExist, %A_ProgramFiles%\Windows NT\Accessories\wordpad.exe
		;;WINWORD_dir=%A_ProgramFiles%\Windows NT\Accessories\wordpad.exe
;;RegRead, OUTLOOK_dir_temp, HKCR, Outlook.File.msg\shell\Open\command
	;;StringSplit,pos_OUTLOOK,OUTLOOK_dir_temp,`"
	;;IfExist, %pos_OUTLOOK2%
		;;;OUTLOOK_dir=%pos_OUTLOOK2%
	;;else IfExist, %A_ProgramFiles%\Outlook Express\msimn.exe
		;;;OUTLOOK_dir=%A_ProgramFiles%\Outlook Express\msimn.exe
		
RegRead, WINWORD_dir_temp, HKLM, SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\WINWORD.EXE,Path
	WINWORD_dir_temp_2=%WINWORD_dir_temp%WINWORD.EXE
	IfExist, %WINWORD_dir_temp_2%
		WINWORD_dir=%WINWORD_dir_temp_2%
	else IfExist, %A_ProgramFiles%\Windows NT\Accessories\wordpad.exe
		WINWORD_dir=%A_ProgramFiles%\Windows NT\Accessories\wordpad.exe
RegRead, OUTLOOK_dir_temp, HKLM, SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\OUTLOOK.EXE,Path
	OUTLOOK_dir_temp_2=%OUTLOOK_dir_temp%OUTLOOK.EXE
	IfExist, %OUTLOOK_dir_temp_2%
		OUTLOOK_dir=%OUTLOOK_dir_temp_2%
	else IfExist, %A_ProgramFiles%\Outlook Express\msimn.exe
		OUTLOOK_dir=%A_ProgramFiles%\Outlook Express\msimn.exe
;;;;;RegRead, EXCEL_dir_temp, HKCR, Applications\EXCEL.EXE\shell\Open\command
	;;StringSplit,pos_EXCEL,EXCEL_dir_temp,`"
	;;IfExist, %pos_EXCEL2%
	;;;EXCEL_dir=%pos_EXCEL2%
RegRead, EXCEL_dir_temp, HKLM, SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\excel.exe,Path
	EXCEL_dir_temp_2=%EXCEL_dir_temp%EXCEL.EXE
	IfExist, %EXCEL_dir_temp_2%
		EXCEL_dir=%EXCEL_dir_temp_2%
	else
		EXCEL_dir=
;;;RegRead, PPT_dir_temp, HKCR, Applications\POWERPNT.EXE\shell\Open\command
	;;StringSplit,pos_PPT,PPT_dir_temp,`"
	;;IfExist, %pos_PPT2%
	;;;PPT_dir=%pos_PPT2%
RegRead, PPT_dir_temp, HKLM, SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\powerpnt.exe,Path
	PPT_dir_temp_2=%PPT_dir_temp%POWERPNT.EXE
	IfExist, %PPT_dir_temp_2%
		PPT_dir=%PPT_dir_temp_2%
	else
		PPT_dir=
RegRead, QQ_dir_temp, HKLM, SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\QQ.exe
	IfExist, %QQ_dir_temp%
		QQ_dir=%QQ_dir_temp%
	else
		QQ_dir=
RegRead, Thunder_dir_temp, HKLM, SOFTWARE\Thunder Network\ThunderOem\thunder_backwnd,Path
	IfExist, %Thunder_dir_temp%
		Thunder_dir=%Thunder_dir_temp%
	else
		Thunder_dir=
RegRead, SEP_dir_temp, HKLM, SOFTWARE\Symantec\InstalledApps,SAV Install Directory
	SEP_dir_temp_2=%SEP_dir_temp%SymCorpUI.exe
	IfExist, %SEP_dir_temp_2%
		SEP_dir=%SEP_dir_temp_2%
	else
		SEP_dir=
;RegRead, AdobeReader_dir_temp, HKCR, acrobat\shell\open\command
	;StringSplit,pos_AdobeReader,AdobeReader_dir_temp,`"
	;AdobeReader_dir_temp_2=%pos_AdobeReader2%
	;IfExist, %AdobeReader_dir_temp_2%
	;AdobeReader_dir=%AdobeReader_dir_temp_2%
	;;msgbox,%AdobeReader_dir%
RegRead, AdobeReader_dir_temp, HKLM, SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\AcroRd32.exe
	IfExist, %AdobeReader_dir_temp%
		AdobeReader_dir=%AdobeReader_dir_temp%
	else
		AdobeReader_dir=
RegRead, ACAD_ver, HKCR, AutoCAD.Drawing\CurVer
RegRead, ACAD_dir_temp, HKCR, %ACAD_ver%\protocol\StdFileEditing\server
	IfExist, %ACAD_dir_temp%
		ACAD_dir=%ACAD_dir_temp%
	else
		ACAD_dir=

RegRead, ACDSee_dir_temp, HKLM, SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\ACDSee.exe
	IfExist, %ACDSee_dir_temp%
		ACDSee_dir=%ACDSee_dir_temp%
	else
		ACDSee_dir=
RegRead, AngryBirds_dir_temp, HKLM, SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\AngryBirds.exe
	IfExist, %AngryBirds_dir_temp%
		AngryBirds_dir=%AngryBirds_dir_temp%
	else
		AngryBirds_dir=
RegRead, chrome_dir_temp, HKLM, SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe
	IfExist, %chrome_dir_temp%
		chrome_dir=%chrome_dir_temp%
	else
		chrome_dir=
RegRead, FormatFactory_dir_temp, HKLM, SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\FormatFactory.exe
	IfExist, %FormatFactory_dir_temp%
		FormatFactory_dir=%FormatFactory_dir_temp%
	else
		FormatFactory_dir=
;RegRead, IDMan_dir_temp, HKCU, SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\IDMan.exe
RegRead, IDMan_dir_temp, HKCU, SOFTWARE\DownloadManager,ExePath
	IfExist, %IDMan_dir_temp%
		IDMan_dir=%IDMan_dir_temp%
	else
		IDMan_dir=
RegRead, EverNote_dir_temp2, HKCU, Software\Microsoft\Windows\CurrentVersion\App Paths\Evernote.exe
RegRead, EverNote_dir_temp, HKLM, Software\Microsoft\Windows\CurrentVersion\App Paths\Evernote.exe
	IfExist, %EverNote_dir_temp%
		EverNote_dir=%EverNote_dir_temp%
	else ifExist, %EverNote_dir_temp2%
		EverNote_dir=%EverNote_dir_temp2%
	else
		EverNote_dir=
RegRead, notepad2_dir_temp, HKLM, SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\notepad++.exe
	IfExist, %notepad2_dir_temp%
		notepad2_dir=%notepad2_dir_temp%
	else
		notepad2_dir=

RegRead, Photoshop_dir_temp, HKCR, Photoshop.PSD\DefaultIcon
	StringSplit,pos_Photoshop,Photoshop_dir_temp,`, 
	Photoshop_dir_temp_2=%pos_Photoshop1%
	IfExist, %Photoshop_dir_temp_2%
		Photoshop_dir=%Photoshop_dir_temp_2%
	else
		Photoshop_dir=
	;;msgbox,Photoshop=%Photoshop_dir_temp%--%Photoshop_dir_temp_2%--%Photoshop_dir%

RegRead, PVZ_dir_temp, HKLM, SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\PlantsVsZombies.exe
	IfExist, %PVZ_dir_temp%
		PVZ_dir=%PVZ_dir_temp%
	else
		PVZ_dir=
RegRead, Firefox_dir_temp, HKLM, SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\firefox.exe
	IfExist, %Firefox_dir_temp%
		Firefox_dir=%Firefox_dir_temp%
	else
		Firefox_dir=
RegRead, PPLive_dir_temp, HKLM, SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\PPLive.exe
;;;;;msgbox,reg=%PPLive_dir_temp%
	IfExist, %PPLive_dir_temp%
		PPLive_dir=%PPLive_dir_temp%
	else
		PPLive_dir=
RegRead, Storm_dir_temp, HKLM, SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\Storm.exe
	IfExist, %Storm_dir_temp%
		Storm_dir=%Storm_dir_temp%
	else
		Storm_dir=
RegRead, TTPlayer_dir_temp, HKLM, SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\TTPlayer.exe
;;;;;;;msgbox,temp---%TTPlayer_dir_temp%
	IfExist, %TTPlayer_dir_temp%
		TTPlayer_dir=%TTPlayer_dir_temp%
	else
		TTPlayer_dir=
;;;;msgbox,22222222222222-----%TTPlayer_dir%
RegRead, Picasa_dir_temp, HKCR, picasa\shell\open\command
	StringSplit,pos_Picasa,Picasa_dir_temp,`"
	IfExist, %pos_Picasa2%
		Picasa_dir=%pos_Picasa2%
	else
		Picasa_dir=
	
RegRead, CCleaner_dir_temp, HKCR, cclaunch\shell\open\command
	StringSplit,pos_CCleaner,CCleaner_dir_temp,`"
	IfExist, %pos_CCleaner2%
		CCleaner_dir=%pos_CCleaner2%
	else
		CCleaner_dir=
	
RegRead, Nero_dir_temp, HKCR, Applications\nero.exe\Shell\open\command
	StringSplit,pos_Nero,Nero_dir_temp,`"
	IfExist, %pos_Nero2%
		Nero_dir=%pos_Nero2%
	else
		Nero_dir=

RegRead, Defraggler_dir_temp, HKLM, SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\defraggler.exe,Path
	IfExist, %Defraggler_dir_temp%\Defraggler.exe
		Defraggler_dir=%Defraggler_dir_temp%\Defraggler.exe
	else
		Defraggler_dir=

RegRead, Opera_dir_temp, HKCR, Applications\Opera.exe\shell\open\command
	StringSplit,pos_Opera,Opera_dir_temp,`"
	IfExist, %pos_Opera2%
		Opera_dir=%pos_Opera2%
	else
		Opera_dir=
		
RegRead, MSE_dir_tmp, HKLM, SOFTWARE\Microsoft\Microsoft Antimalware,RemediationExe	
	IfExist, %MSE_dir_tmp%
		MSE_dir=%MSE_dir_tmp%
	else
		MSE_dir=
		

;########################### 确定常用程序路径  结束###########################

FormatTime, IniDateTime,, yyyy-M-d H:mm:ss

;If A_PtrSize=4
;	Bit32or64=32-bit
;else
;	Bit32or64=64-bit

	FileAppend, #请在此编辑HK4WIN快捷键`n#此文件由HK4WIN(%HK4WIN_ver_build%)于%IniDateTime%初始化生成。`n#操作系统环境：%A_OSVersion% `n#计算机名：%A_ComputerName%`n#用户名：%A_UserName%`n#如果要重置所有快捷键，请按Ctrl+Alt+Shift+S。`n#新安装以下任意软件之后，重置快捷键可自动为它们设置快捷键：`n#Word、PowerPoint、OutLook、Excel、PPLive、Chrome、Picasa、CCleaner、AutoCAD、愤怒的小鸟、Internet Download Manager、Notepad++、PhotoShop、Adobe Reader、Firefox、QQ即时通讯、SEP赛门铁克端点防护、Thunder(迅雷)、暴风影音、植物大战僵尸、千千静听、Opera、MSE、EverNote。`n`n#===========================================`n#！！！注意：修改完并保存本文件后，需要按Ctrl+Alt+Shift+F5重启HK4WIN才能生效。`n`n`n#OpenApp组为启动程序，快捷键为左Ctrl+左Alt+数字或字母。`n#OpenWeb组为一键上网，快捷键为右Ctrl+右Alt+数字或字母。`n#OpenDir组为打开文件夹，快捷键为Win+Fn，F1~F4预设，F5~F12可自定义。`n#FastInput组为热词，快捷键为 ]+数字或字母，按]再按其他键快速输入常用热词。`n#RClickCorner组为自定义右键单击屏幕四角。`n#FnSwitch组为快捷键功能开关。`n#Gesture组为鼠标手势，按住滚轮（中键）移动鼠标。`n#UserSetting组为用户参数设置，可手动修改。`n#ScriptSetting组为程序参数，请不要手动修改。`n`n#数字指主键盘区按键，非小键盘。`n#请根据需要修改等号之后的内容。`n#如果下列快捷键与其他程序冲突，可将等号之后的内容删除以释放快捷键，其他程序方能占用该快捷键。`n#等号以及等号之前的字符不可删除，否则会报错！！！`n#HK4WIN_SET.ini 必须与HK4WIN.exe同目录才可生效。`n#===========================================`n`n, %A_ScriptDir%\HK4WIN_SET.ini
;#########################################################################################
FileAppend, `n`n#★★★启动程序自定义★★★`n#快捷键为左Ctrl+左Alt+数字或字母。, %A_ScriptDir%\HK4WIN_SET.ini
	IniWrite, %PPT_dir%, %A_ScriptDir%\HK4WIN_SET.ini, OpenApp, 1
	IniWrite, %OUTLOOK_dir%, %A_ScriptDir%\HK4WIN_SET.ini, OpenApp, 2
	IniWrite, %EXCEL_dir%, %A_ScriptDir%\HK4WIN_SET.ini, OpenApp, 3
	IniWrite, %Storm_dir%, %A_ScriptDir%\HK4WIN_SET.ini, OpenApp, 4
	IniWrite, %PVZ_dir%, %A_ScriptDir%\HK4WIN_SET.ini, OpenApp, 5
	IniWrite, %PPLive_dir%, %A_ScriptDir%\HK4WIN_SET.ini, OpenApp, 6
	IniWrite, %TTPlayer_dir%, %A_ScriptDir%\HK4WIN_SET.ini, OpenApp, 7
	IniWrite, %chrome_dir% , %A_ScriptDir%\HK4WIN_SET.ini, OpenApp, 8
	IniWrite, %Picasa_dir%, %A_ScriptDir%\HK4WIN_SET.ini, OpenApp, 9
	IniWrite, %CCleaner_dir%, %A_ScriptDir%\HK4WIN_SET.ini, OpenApp, 0
	IniWrite, "", %A_ScriptDir%\HK4WIN_SET.ini, OpenApp,a
	IniWrite, %AngryBirds_dir%, %A_ScriptDir%\HK4WIN_SET.ini, OpenApp,b
	IniWrite, %A_WinDir%\system32\calc.exe , %A_ScriptDir%\HK4WIN_SET.ini, OpenApp,c
	IniWrite, %IDMan_dir%, %A_ScriptDir%\HK4WIN_SET.ini, OpenApp,d
	IniWrite, %A_ProgramFiles%\Internet Explorer\iexplore.exe, %A_ScriptDir%\HK4WIN_SET.ini, OpenApp,e
	IniWrite, %Firefox_dir%, %A_ScriptDir%\HK4WIN_SET.ini, OpenApp,f
	IniWrite, "", %A_ScriptDir%\HK4WIN_SET.ini, OpenApp,g
	IniWrite, %Photoshop_dir%, %A_ScriptDir%\HK4WIN_SET.ini, OpenApp,h
	IniWrite, %ACAD_dir%, %A_ScriptDir%\HK4WIN_SET.ini, OpenApp,i
	IniWrite, "", %A_ScriptDir%\HK4WIN_SET.ini, OpenApp,j
	IniWrite, "", %A_ScriptDir%\HK4WIN_SET.ini, OpenApp,k
	IniWrite, "", %A_ScriptDir%\HK4WIN_SET.ini, OpenApp,l
	IniWrite, %A_ProgramFiles%\Windows Media Player\wmplayer.exe , %A_ScriptDir%\HK4WIN_SET.ini, OpenApp,m
	IniWrite, %A_WinDir%\system32\notepad.exe , %A_ScriptDir%\HK4WIN_SET.ini, OpenApp,n
	IniWrite, %Opera_dir%, %A_ScriptDir%\HK4WIN_SET.ini, OpenApp,o
	IniWrite, C:\WINDOWS\system32\mspaint.exe , %A_ScriptDir%\HK4WIN_SET.ini, OpenApp,p
	IniWrite, %QQ_dir%, %A_ScriptDir%\HK4WIN_SET.ini, OpenApp,q
	IniWrite, %AdobeReader_dir%, %A_ScriptDir%\HK4WIN_SET.ini, OpenApp,r
	IniWrite, %SEP_dir%, %A_ScriptDir%\HK4WIN_SET.ini, OpenApp,s
	IniWrite, %Thunder_dir%, %A_ScriptDir%\HK4WIN_SET.ini, OpenApp,t
	IniWrite, "%EverNote_dir%", %A_ScriptDir%\HK4WIN_SET.ini, OpenApp,u
	IniWrite, %MSE_dir%, %A_ScriptDir%\HK4WIN_SET.ini, OpenApp,v
	IniWrite, %WINWORD_dir% , %A_ScriptDir%\HK4WIN_SET.ini, OpenApp,w
	IniWrite, "", %A_ScriptDir%\HK4WIN_SET.ini, OpenApp,x
	IniWrite, "", %A_ScriptDir%\HK4WIN_SET.ini, OpenApp,y
	IniWrite, "", %A_ScriptDir%\HK4WIN_SET.ini, OpenApp,z
FileAppend, #注意：QQ的新消息呼出默认快捷键是Ctrl+Alt+Z`n如需使用QQ此功能请将上面“z=”留空，否则会冲突。, %A_ScriptDir%\HK4WIN_SET.ini
;#########################################################################################
FileAppend, `n`n`n`n#★★★一键上网自定义★★★`n#快捷键为右Ctrl+右Alt+数字或字母。, %A_ScriptDir%\HK4WIN_SET.ini
	IniWrite, http://, %A_ScriptDir%\HK4WIN_SET.ini, OpenWeb, 1
	IniWrite, http://, %A_ScriptDir%\HK4WIN_SET.ini, OpenWeb, 2
	IniWrite, http://, %A_ScriptDir%\HK4WIN_SET.ini, OpenWeb, 3
	IniWrite, http://, %A_ScriptDir%\HK4WIN_SET.ini, OpenWeb, 4
	IniWrite, http://, %A_ScriptDir%\HK4WIN_SET.ini, OpenWeb, 5
	IniWrite, http://, %A_ScriptDir%\HK4WIN_SET.ini, OpenWeb, 6
	IniWrite, http://, %A_ScriptDir%\HK4WIN_SET.ini, OpenWeb, 7
	IniWrite, http://, %A_ScriptDir%\HK4WIN_SET.ini, OpenWeb, 8
	IniWrite, http://, %A_ScriptDir%\HK4WIN_SET.ini, OpenWeb, 9
	IniWrite, http://, %A_ScriptDir%\HK4WIN_SET.ini, OpenWeb, 0
	IniWrite, http://www.songruihua.com/hk4win-openweb-a/, %A_ScriptDir%\HK4WIN_SET.ini, OpenWeb,a
	IniWrite, http://www.songruihua.com/hk4win-openweb-b/, %A_ScriptDir%\HK4WIN_SET.ini, OpenWeb,b
	IniWrite, http://www.songruihua.com/hk4win-openweb-c/, %A_ScriptDir%\HK4WIN_SET.ini, OpenWeb,c
	IniWrite, http://www.songruihua.com/hk4win-openweb-d/, %A_ScriptDir%\HK4WIN_SET.ini, OpenWeb,d
	IniWrite, http://www.songruihua.com/hk4win-openweb-e/, %A_ScriptDir%\HK4WIN_SET.ini, OpenWeb,e
	IniWrite, http://www.songruihua.com/hk4win-openweb-f/, %A_ScriptDir%\HK4WIN_SET.ini, OpenWeb,f
	IniWrite, http://www.songruihua.com/hk4win-openweb-g/, %A_ScriptDir%\HK4WIN_SET.ini, OpenWeb,g
	IniWrite, http://www.songruihua.com/hk4win-openweb-h/, %A_ScriptDir%\HK4WIN_SET.ini, OpenWeb,h
	IniWrite, http://www.songruihua.com/hk4win-openweb-i/, %A_ScriptDir%\HK4WIN_SET.ini, OpenWeb,i
	IniWrite, http://www.songruihua.com/hk4win-openweb-j/, %A_ScriptDir%\HK4WIN_SET.ini, OpenWeb,j
	IniWrite, http://www.songruihua.com/hk4win-openweb-k/, %A_ScriptDir%\HK4WIN_SET.ini, OpenWeb,k
	IniWrite, http://www.songruihua.com/hk4win-openweb-l/, %A_ScriptDir%\HK4WIN_SET.ini, OpenWeb,l
	IniWrite, http://www.songruihua.com/hk4win-openweb-m/, %A_ScriptDir%\HK4WIN_SET.ini, OpenWeb,m
	IniWrite, http://www.songruihua.com/hk4win-openweb-n/, %A_ScriptDir%\HK4WIN_SET.ini, OpenWeb,n
	IniWrite, http://www.songruihua.com/hk4win-openweb-o/, %A_ScriptDir%\HK4WIN_SET.ini, OpenWeb,o
	IniWrite, http://www.songruihua.com/hk4win-openweb-p/, %A_ScriptDir%\HK4WIN_SET.ini, OpenWeb,p
	IniWrite, http://www.songruihua.com/hk4win-openweb-q/, %A_ScriptDir%\HK4WIN_SET.ini, OpenWeb,q
	IniWrite, http://www.songruihua.com/hk4win-openweb-r/, %A_ScriptDir%\HK4WIN_SET.ini, OpenWeb,r
	IniWrite, http://www.songruihua.com/hk4win-openweb-s/, %A_ScriptDir%\HK4WIN_SET.ini, OpenWeb,s
	IniWrite, http://www.songruihua.com/hk4win-openweb-t/, %A_ScriptDir%\HK4WIN_SET.ini, OpenWeb,t
	IniWrite, http://www.songruihua.com/hk4win-openweb-u/, %A_ScriptDir%\HK4WIN_SET.ini, OpenWeb,u
	IniWrite, http://www.songruihua.com/hk4win-openweb-v/, %A_ScriptDir%\HK4WIN_SET.ini, OpenWeb,v
	IniWrite, http://www.songruihua.com/hk4win-openweb-w/, %A_ScriptDir%\HK4WIN_SET.ini, OpenWeb,w
	IniWrite, mailto:hk4win@songruihua.com?subject=关于HK4WIN：&body=你好：, %A_ScriptDir%\HK4WIN_SET.ini, OpenWeb,x
	IniWrite, http://www.songruihua.com/hk4win-openweb-y/, %A_ScriptDir%\HK4WIN_SET.ini, OpenWeb,y
	IniWrite, "", %A_ScriptDir%\HK4WIN_SET.ini, OpenWeb,z
;#########################################################################################
FileAppend, `n`n`n`n#★★★打开文件夹自定义★★★`n#快捷键为Win+Fn，F1~F4预设，F5~F12可自定义。, %A_ScriptDir%\HK4WIN_SET.ini
	IniWrite, %A_WinDir%\system32, %A_ScriptDir%\HK4WIN_SET.ini, OpenDir,F5
	IniWrite, "", %A_ScriptDir%\HK4WIN_SET.ini, OpenDir,F6
	IniWrite, "", %A_ScriptDir%\HK4WIN_SET.ini, OpenDir,F7
	IniWrite, "", %A_ScriptDir%\HK4WIN_SET.ini, OpenDir,F8
	IniWrite, "", %A_ScriptDir%\HK4WIN_SET.ini, OpenDir,F9
	IniWrite, "", %A_ScriptDir%\HK4WIN_SET.ini, OpenDir,F10
	IniWrite, "", %A_ScriptDir%\HK4WIN_SET.ini, OpenDir,F11
	IniWrite, %A_ScriptDir%, %A_ScriptDir%\HK4WIN_SET.ini, OpenDir,F12
;#########################################################################################
FileAppend, `n`n`n`n#★★★热词速写自定义★★★`n#快捷键为 ]+数字或字母，按]再按其他键快速输入常用热词。, %A_ScriptDir%\HK4WIN_SET.ini
	IniWrite, 咦, %A_ScriptDir%\HK4WIN_SET.ini, FastInput,1
	IniWrite, 你真二, %A_ScriptDir%\HK4WIN_SET.ini, FastInput,2
	IniWrite, 三个臭皮匠顶个诸葛亮, %A_ScriptDir%\HK4WIN_SET.ini, FastInput,3
	IniWrite, 去死, %A_ScriptDir%\HK4WIN_SET.ini, FastInput,4
	IniWrite, 555，内牛满面, %A_ScriptDir%\HK4WIN_SET.ini, FastInput,5
	IniWrite, 开溜, %A_ScriptDir%\HK4WIN_SET.ini, FastInput,6
	IniWrite, 气死你, %A_ScriptDir%\HK4WIN_SET.ini, FastInput,7
	IniWrite, 拜拜了您内, %A_ScriptDir%\HK4WIN_SET.ini, FastInput,8
	IniWrite, 好久不见了, %A_ScriptDir%\HK4WIN_SET.ini, FastInput,9
	IniWrite, 我手机号是, %A_ScriptDir%\HK4WIN_SET.ini, FastInput,0
	IniWrite, 啊, %A_ScriptDir%\HK4WIN_SET.ini, FastInput,a
	IniWrite, 不要, %A_ScriptDir%\HK4WIN_SET.ini, FastInput,b
	IniWrite, 扯淡, %A_ScriptDir%\HK4WIN_SET.ini, FastInput,c
	IniWrite, 大便一下，等会见, %A_ScriptDir%\HK4WIN_SET.ini, FastInput,d
	IniWrite, 饿了，吃饭去了, %A_ScriptDir%\HK4WIN_SET.ini, FastInput,e
	IniWrite, ，我爱你, %A_ScriptDir%\HK4WIN_SET.ini, FastInput,f
	IniWrite, 滚, %A_ScriptDir%\HK4WIN_SET.ini, FastInput,g
	IniWrite, 嗨, %A_ScriptDir%\HK4WIN_SET.ini, FastInput,h
	IniWrite, 哎, %A_ScriptDir%\HK4WIN_SET.ini, FastInput,i
	IniWrite, 囧, %A_ScriptDir%\HK4WIN_SET.ini, FastInput,j
	IniWrite, 靠, %A_ScriptDir%\HK4WIN_SET.ini, FastInput,k
	IniWrite, I LOVE YOU, %A_ScriptDir%\HK4WIN_SET.ini, FastInput,l
	IniWrite, 美眉, %A_ScriptDir%\HK4WIN_SET.ini, FastInput,m
	IniWrite, 你好, %A_ScriptDir%\HK4WIN_SET.ini, FastInput,n
	IniWrite, 哦, %A_ScriptDir%\HK4WIN_SET.ini, FastInput,o
	IniWrite, 放屁, %A_ScriptDir%\HK4WIN_SET.ini, FastInput,p
	IniWrite, 我QQ号是, %A_ScriptDir%\HK4WIN_SET.ini, FastInput,q
	IniWrite, 我日, %A_ScriptDir%\HK4WIN_SET.ini, FastInput,r
	IniWrite, SHIT，去死吧, %A_ScriptDir%\HK4WIN_SET.ini, FastInput,s
	IniWrite, 他, %A_ScriptDir%\HK4WIN_SET.ini, FastInput,t
	IniWrite, 呦, %A_ScriptDir%\HK4WIN_SET.ini, FastInput,u
	IniWrite, http://www.songruihua.com/hk4win, %A_ScriptDir%\HK4WIN_SET.ini, FastInput,v
	IniWrite, 我叫王老五，男，今年108岁, %A_ScriptDir%\HK4WIN_SET.ini, FastInput,w
	IniWrite, "xxoo", %A_ScriptDir%\HK4WIN_SET.ini, FastInput,x
	IniWrite, "为什么？", %A_ScriptDir%\HK4WIN_SET.ini, FastInput,y
	IniWrite, "你是猪啊你！", %A_ScriptDir%\HK4WIN_SET.ini, FastInput,z

	
;#########################################################################################
	FileAppend, `n`n`n`n#★★★右键屏幕四角自定义★★★`n#1为左上角，2为右上角，3为右下角，4为左下角，即从左上角开始顺时针依次为1~4角`n#等号后可填入以下字符Desktop(桌面)、Computer(我的电脑/计算机)、Documents(我的文档)、ZhaiNan(宅男键)，以及文件(夹)路径，网址等。`n#默认为1.ZhaiNan、2.Documents、3.Computer、4.http://www.songruihua.com/hk4win。`n#以上字符不区分大小写。不能填入其他字符，否则报错。请正确拼写路径/网址，否则报错。`n#等号后可留空。, %A_ScriptDir%\HK4WIN_SET.ini
	IniWrite, ZhaiNan, %A_ScriptDir%\HK4WIN_SET.ini, RClickCorner,1_TL
	IniWrite, Documents, %A_ScriptDir%\HK4WIN_SET.ini, RClickCorner,2_TR
	IniWrite, Computer, %A_ScriptDir%\HK4WIN_SET.ini, RClickCorner,3_BR
	IniWrite, http://www.songruihua.com/hk4win, %A_ScriptDir%\HK4WIN_SET.ini, RClickCorner,4_BL
	
	
	
	
FileAppend, `n`n`n`n#★★★自定义快捷菜单（屏幕右边按下滚轮）★★★`n#在屏幕的右边，按下鼠标滚轮，即可弹出快捷菜单，可打开文件夹、程序或网址，最多支持20个菜单项`n#请在下方编辑菜单项，用半角逗号分隔名称和路径或网址, %A_ScriptDir%\HK4WIN_SET.ini
	temp0=C盘,C:\
	IfExist,C:\
	IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, CustomMenu,1
	
	temp0=D盘,D:\
	IfExist,D:\
	IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, CustomMenu,2
	
	temp0=我的文档,%A_MyDocuments%
	IfExist,%A_MyDocuments%
	IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, CustomMenu,3
	
	temp0=HK4WIN文件夹,%A_WorkingDir%
	IfExist,%A_WorkingDir%
	IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, CustomMenu,4
	
	temp0=桌面文件夹,%A_Desktop%
	IfExist,%A_Desktop%
	IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, CustomMenu,5
	
	temp0=Windows文件夹,%A_WinDir%
	IfExist,%A_WinDir%
	IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, CustomMenu,6
	
	temp0=AppData文件夹,%A_AppData%
	IfExist,%A_AppData%
	IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, CustomMenu,7
	
	temp0=程序文件夹,%A_ProgramFiles%
	IfExist,%A_ProgramFiles%
	IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, CustomMenu,8
	
	temp0=任务管理器,%A_WinDir%\system32\taskmgr.exe
	IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, CustomMenu,9
	
	temp0=记事本,%A_WinDir%\system32\notepad.exe
	IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, CustomMenu,10
	
	temp0=计算器,%A_WinDir%\system32\calc.exe
	IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, CustomMenu,11
	
	temp0=画图,%A_WinDir%\system32\mspaint.exe
	IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, CustomMenu,12
	
	temp0=HK4WIN官网,http://www.songruihua.com/hk4win
	IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, CustomMenu,13
	
	temp0=作者官网,http://www.songruihua.com/
	IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, CustomMenu,14
	
	temp0=Google,http://www.google.com/
	IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, CustomMenu,15
	
	temp0=,
	;IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, CustomMenu,16

	
	

	
	


	
	

;#########################################################################################
FileAppend,`n`n#★★★快捷键开关★★★`n#首先请按Ctrl+Alt+Shift+F1打开帮助文档，在表格中查询相应功能的Fn代码，例如Fn0201。Fn代码等号后默认为1，这代表对应功能完全开启；等号之后如果是0或留空，则代表对应功能已完全关闭；除0和1之外的任何其他字符都将被视为该功能的“黑名单”，对应的功能在被拉黑程序中无效，其他程序则有效。BlackList是“全局黑名单”（默认为空），所有功能在被拉黑程序中无效。`n#黑名单由相应程序的“类”组成，首先需要获取被拉黑软件的“类”，也就是软件的“名字”，但并不是所有软件的“类”都跟你在电脑屏幕上看到的一样，比如Firefox的类就是“MozillaWindowClass”，这里面根本就没有Firefox这个名字，但是记事本的“类”是Notepad，就跟它的名字一样（英文系统下），为了取得软件的“类”你可以先将鼠标指向将被拉黑的程序（请一定将鼠标置于将被拉黑窗口之上，而非仅仅将其置于最前），然后按Ctrl+Alt+Shift+C，这样你就已经取得了鼠标指针下程序的“类”，并且已经复制到剪切板中可以粘贴使用了。`n接下来请在下面的对应Fn代码（或全局黑名单BlackList）等号之后粘贴已经复制的“类”即可，如果被拉黑软件多于一个，请用英文半角逗号隔开。推荐把最常使用的软件写在前面以提高效率。`n最后注意几点：`n1、修改完并保存后，按Ctrl+Alt+Shift+F5重启HK4WIN才能生效。`n2、请注意不要在两个类名中间插入空格，不要误输入中文全角逗号。`n,%A_ScriptDir%\HK4WIN_SET.ini

if A_OSVersion in WIN_XP
	temp0=1
else
	temp0=UNAVAILABLE



If (A_OSVersion="WIN_8" or A_OSVersion="WIN_9")
{
	temp1=0
	temp2=UNAVAILABLE
}
else
{
	temp1=1
	temp2=1
}
	
	




	IniWrite, "", %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch,BlackList
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0101
	IniWrite, 0, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0102
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0103
	IniWrite, %temp1%, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0104
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0105
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0106
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0107
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0108
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0109
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0110
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0111
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0112
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0113
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0114
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0115
	IniWrite, %temp1%, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0116
	IniWrite, %temp1%, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0117	
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0118
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0119
	IniWrite, %temp2%, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0120
	IniWrite, %temp2%, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0121
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0122
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0201
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0202
	IniWrite, %temp1%, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0203
	IniWrite, %temp1%, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0204
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0205
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0206
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0207
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0208
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0209
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0210
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0211
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0212
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0213
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0214
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0215
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0216
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0217
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0218
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0219
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0220
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0221
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0222
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0223
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0224
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0225
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0301
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0302
	IniWrite, %temp1%, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0303
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0304
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0305
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0306
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0307
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0308
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0309
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0310
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0311
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0312
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0313
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0314
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0315
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0316
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0317
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0318
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0319
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0320
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0321
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0322
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0323
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0324
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0325
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0326
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0327
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0328
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0329
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0330
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0331
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0332
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0333
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0334
	;Temp0=MozillaWindowClass,MozillaUIWindowClass
	Temp0=1
	IniWrite, %Temp0%, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0335
	IniWrite, %Temp0%, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0336
	Temp0=MozillaWindowClass,IEFrame,Chrome_WidgetWin_1,Maxthon3Cls_MainFrm,MozillaUIWindowClass,OperaWindowClass,Chrome_WidgetWin_2,Chrome_WidgetWin_3,Maxthon2Cls_MainFrm,Chrome_WidgetWin_0
	IniWrite, %Temp0%, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0337
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0338
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0339
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0340
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0341
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0342
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0343
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0344
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0345
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0401
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0402
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0501
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0502
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0503
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0504
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0505
	

;#########################################################################################
FileAppend, `n`n#★★★自定义快捷键★★★`n#首先请按Ctrl+Alt+Shift+F1打开帮助文档，在表格中查询相应功能的Fn代码，例如Fn0201。`n#每个代码对应一个HK4WIN内置功能，也就是说每个功能都有一个唯一的编号，例如打开“我的文档”文件夹的编号为0104。`n#下面就是这些功能（部分功能不支持自定义）的快捷键，例如0104功能的快捷键是#w，其含义就是Win+W组合快捷键。`n#下面给出常用的按键表示方法：#代表Win键，^代表Ctrl键，!代表Alt键，，也可以将这些键组合使用，例如^!n，其含义是Ctrl+Alt+N快捷键。至于其他的$~等快捷键比较复杂，在此不做介绍，有需要者请参考AutoHotKey帮助文件。`n#`n#！！！！！！特别提醒！！！！！！`n#`n#下列快捷键如无特殊需要，建议不要更改，因为可能发生快捷键冲突，也就是说对同一个快捷键制定了两个以上的功能，这是不允许的，没有经验的用户容易造成意想不到的错误，所以只建议有经验者修改下列设置，如果需要帮助，请访问：http://www.songruihua.com/hotkeys。设置完成请保存后重启HK4WIN方能生效。,%A_ScriptDir%\HK4WIN_SET.ini	
	IniWrite, $F2, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0101
	IniWrite, ~Capslock, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0102
	IniWrite, ~LButton, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0103
	IniWrite, #w, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0104
	IniWrite, #ESC, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0105
	IniWrite, #F1, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0106
	IniWrite, #F2, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0107
	IniWrite, #F3, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0108
	IniWrite, #F4, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0109
	;;;;;IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0110
	IniWrite, $#e, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0111
	IniWrite, #+e, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0112
	;;;;;IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0113
	;;;;;IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0114
	temp0=#``
	IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0115
	IniWrite, $#o, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0116
	IniWrite, $#i, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0117
	IniWrite, $#n, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0118
	IniWrite, $!Up, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0119
	IniWrite, #h, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0120
	IniWrite, $#v, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0121
	;;;;;;IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0122
	;;;;;;;IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0201
	IniWrite, <^<!+n, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0202
	IniWrite, $#f, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0203
	IniWrite, #Space, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0204
	IniWrite, ~NumLock, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0205
	IniWrite, ~Pause, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0206
	IniWrite, >![, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0207
	IniWrite, >!], %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0208
	IniWrite, >!p, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0209
	IniWrite, >!', %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0210
	IniWrite, >!;, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0211
	IniWrite, >!r, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0212
	IniWrite, >!s, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0213
	IniWrite, >!x, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0214
	;;;;;;;;;;;;IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0215
	IniWrite, $Space, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0216
	IniWrite, $NumpadEnter, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0217
	temp0=$``
	IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0218
	IniWrite, $TAB, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0219
	IniWrite, ~F12, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0220
	;;;;;;;;;IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0221
	;;;;;;;;;IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0222
	;;;;;;;;;IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0223
	IniWrite, ~F11, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0224
	;;;;;;;;;IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0225
	;;;;;;;IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0301
	IniWrite, RControl & Up, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0302
	IniWrite, #c, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0303
	IniWrite, ^+f, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0304
	IniWrite, #+s, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0305
	IniWrite, #+a, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0306
	IniWrite, #+i, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0307
	IniWrite, #+u, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0308
	IniWrite, #+p, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0309
	;;;;;;;IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0310
	IniWrite, #Del, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0311
	IniWrite, >^PgUp, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0312
	IniWrite, >^End, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0313
	IniWrite, >^Home, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0314
	IniWrite, $APPSKEY, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0315
	IniWrite, >^APPSKEY, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0316
	IniWrite, #b, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0317
	IniWrite, #+b, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0318
	IniWrite, #s, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0319
	IniWrite, ~Esc, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0320
	;;;;;;IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0321
	IniWrite, ~LAlt, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0322
	;;;;;IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0323
	;;;;;IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0324
	IniWrite, <!Space, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0325
	IniWrite, ~RAlt, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0326
	IniWrite, >!Space, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0327
	IniWrite, ~RAlt & WheelUp, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0328
	IniWrite, ~RCtrl & WheelUp, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0329
	IniWrite, ^#c, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0330
	;;;IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0331
	IniWrite, ScrollLock, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0332
	;;;IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0333
	;;;IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0334
	;;;IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0335
	;;;IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0336
	;;;IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0337
	IniWrite, $F3, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0338
	;;;IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0339
	;;;IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0340
	;;;IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0341
	;;;IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0401
	IniWrite, $>^>!+g, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0402
	;;;IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0501
	;;;IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0502
	;;;IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0503
	;;;IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0504
	;;;IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, HotKeys, Key0505

;#########################################################################################
FileAppend, `n`n#★★★鼠标手势★★★`n#UDLR分别代表上下左右，IE_Gesture_?为IE浏览器中的鼠标手势设置，Ex_Gesture_?为资源管理器中的鼠标手势设置。`n编辑等号后的内容，不要重复否则只有一个功能生效。手势可以是无限个UDLR组合而成，例如修改Ex_Gesture_Copy=ULDRULDR即为逆时针画两个正方形实现“复制”功能，但如果大于4个你的手腕估计会不舒服，尽量控制在3个以内。`n如果某个功能被留空，那么该功能无鼠标手势。, %A_ScriptDir%\HK4WIN_SET.ini	
	IniWrite, L, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,IE_Gesture_Back
	IniWrite, R, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,IE_Gesture_Forward
	IniWrite, UD, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,IE_Gesture_Refresh
	IniWrite, DL, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,IE_Gesture_Stop
	
	IniWrite, UL, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,IE_Gesture_PreTab
	IniWrite, UR, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,IE_Gesture_NextTab
	IniWrite, DR, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,IE_Gesture_CloseTab
	IniWrite, RL, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,IE_Gesture_UndoTab
	IniWrite, LR, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,IE_Gesture_NewTab
	IniWrite, RU, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,IE_Gesture_PageHome
	IniWrite, RD, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,IE_Gesture_PageEnd
	
	
	
	IniWrite, L, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,Ex_Gesture_Copy
	IniWrite, R, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,Ex_Gesture_Paste
	IniWrite, LD, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,Ex_Gesture_Cute
	IniWrite, DL, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,Ex_Gesture_Del
	IniWrite, D, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,Ex_Gesture_DelInst
	IniWrite, UD, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,Ex_Gesture_Pro
	IniWrite, UL, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,Ex_Gesture_Back
	IniWrite, UR, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,Ex_Gesture_Fwd
	IniWrite, U, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,Ex_Gesture_Upper
	IniWrite, DR, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,Ex_Gesture_Close
	IniWrite, LU, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,Ex_Gesture_Undo





;#########################################################################################
	FileAppend, `n`n`n`n#★★★用户参数设置★★★`n#由于滚轮控制音量可能因操作失误使音量开得过大，所以设置了音量提醒`n使用快捷键RCtrl+PageUp或传统方法调高音量则不会提醒，如果您不想被提醒，请调整三个参数 Vol_Morning、Vol_Night 和 Vol_Max。`n#Vol_Morning：人们早上几点起床呢？大概7点吧。`n#Vol_Night：人们晚上几点睡觉呢？大概21点吧。`n#Vol_Max：在别人睡觉的时候，你的电脑音量不超过多少才不扰民呢？（％）。`n#例如，默认Vol_Morning=7、Vol_Night=21 、 Vol_Max=10 ，当您在每晚21:00至次日早7:00这个时间段用鼠标滚轮将音量调高到10％时 HK4WIN 会提醒您，请修改这三个参数以适应您的习惯，如果要彻底禁用此功能，请修改Vol_Morning=0、Vol_Night=24 。`n#Vol_Home是RCtrl+Home实现的音量，可取0~100，默认10。`n#OpenAppMax决定了LCtrl+LAlt+?是否以最大化形式启动程序，0为默认大小，1为最大化。`n#SearchEngine_F3决定了按下F3用哪个搜索引擎搜索选中的内容，1Google.com.hk，2Google.com，3Baidu.com，默认为1；类似的SearchEngine_Shift_F3决定了按下Shift+F3用哪个搜索引擎搜索选中的内容，默认为3。`n#DisableLiveUpdate决定了是否让HK4WIN自动更新，0启用更新（默认），1禁用更新（不推荐）`n#InstantMinimizeWindow决定了：在已经最大化的窗口的标题栏上向下滚轮，1为直接最小化，0为“向下还原”到最大化之前的大小。默认为1。`n#AutoShutdownTime为自动关机时间，每次启动HK4WIN后都会自动设定在此时间关机，采用24小时制，例如17:05，即下班5分钟后自动关机，适合上班一族。`n#WheelList针对鼠标滚轮穿透而设，有些大型软件不支持“不选中滚动”，那就把它们的“类”列于此，当你在它们之上滚轮时会自动将其前置。`n#WheelSpeed是鼠标滚轮穿透的滚动速度设置，默认为每次滚动3行，注意这里的设置只针对穿透滚轮，正常滚轮请在“控制面板\硬件和声音\设备和打印机\鼠标”中设置。`n#AutoIME是自动切换到指定输入法设置，即当激活列于AutoImeList的窗口后自动切换到键盘布局编码为AutoIME的输入法，HK4WIN可自动侦测到谷歌、搜狗和QQ三个输入法，并自动将其键盘布局编码赋值于AutoIME，如果您使用的是其他输入法，请打开regedit注册表，查看HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layouts下的子项，中文输入法键盘布局编码一般以E开头以0804结尾，将其填写在AutoIME等号之后重启HK4WIN生效，将等号后留空则关闭此功能。`n#TransparentList为自动调整窗口透明度的“类”列表，以半角逗号分隔，TransparentValue为透明度取值，范围是30~255，255表示完全不透明，30表示最为透明，超出此范围的取值将自动取30或255，如果不是数字将报错。`n#SecKill列表（默认包括常见的浏览器）中的程序会对鼠标左键加右键秒杀操作执行Ctrl+W命令（浏览器中通常为关闭当前标签页），其他程序则执行Alt+F4命令（浏览器中通常为关闭整个浏览器窗口）`n#RunAsAdmin参数如果设为1，HK4WIN会以管理员权限运行，这可以极大地提高HK4WIN的稳定性，但会造成每次启动HK4WIN都会触发UAC的麻烦，请自行斟酌。该参数不会弹出交互界面询问用户，只能在ini配置文件中手动修改，仅针对高级用户。, %A_ScriptDir%\HK4WIN_SET.ini
	IniWrite, 7, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,Vol_Morning
	IniWrite, 21, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,Vol_Night
	IniWrite, 10, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,Vol_Max
	IniWrite, 10, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,Vol_Home
	IniWrite, N, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,OpenAppMax
	;;;;IniWrite, N, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,OpenFolderMax
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,SearchEngine_F3
	IniWrite, 3, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,SearchEngine_Shift_F3
	;IniWrite, 0, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,WheelDown_MinFx
	IniWrite, 0, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,DisableLiveUpdate
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,InstantMinimizeWindow
	IniWrite, "", %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,AutoShutdownTime
	Temp0=OperaWindowClass
	IniWrite, %Temp0%, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,WheelList
	IniWrite, 3, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,WheelSpeed

RegRead, Temp0, HKEY_LOCAL_MACHINE, SYSTEM\CurrentControlSet\Control\Keyboard Layouts\E0200804, Ime File
RegRead, Temp1, HKEY_LOCAL_MACHINE, SYSTEM\CurrentControlSet\Control\Keyboard Layouts\E0210804, Ime File
RegRead, Temp2, HKEY_LOCAL_MACHINE, SYSTEM\CurrentControlSet\Control\Keyboard Layouts\E0220804, Ime File
If Temp0 contains GOOGLE
	Temp3=E0200804
else If Temp1 contains GOOGLE
	Temp3=E0210804
else If Temp2 contains GOOGLE
	Temp3=E0220804
else If Temp0 contains SOGOU
	Temp3=E0200804
else If Temp1 contains SOGOU
	Temp3=E0210804
else If Temp2 contains SOGOU
	Temp3=E0220804
else If Temp0 contains QQ
	Temp3=E0200804
else If Temp1 contains QQ
	Temp3=E0210804
else If Temp2 contains QQ
	Temp3=Es804
else
	Temp3=
	IniWrite, %Temp3%, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,AutoIME
	Temp0=Notepad,TXGuiFoundation,OpusApp,XLMAIN
	IniWrite, %Temp0%, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,AutoImeList
	IniWrite, "", %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,TransparentList
	IniWrite, 150, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,TransparentValue
Temp0=MozillaWindowClass,IEFrame,TXGuiFoundation,Chrome_WidgetWin,Maxthon3Cls_MainFrm,Maxthon2Cls_MainFrm,MozillaUIWindowClass,OperaWindowClass,Notepad++,360se,SE_
IniWrite, %Temp0%, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,SecKill

	
	
	
;#########################################################################################
	FileAppend, `n`n`n`n#※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※`n#※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※`n#		此处向下   不要修改			`n#※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※`n#※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※`n, %A_ScriptDir%\HK4WIN_SET.ini
	IniWrite, %VerCurMain%, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,IniCreatedByMain
	IniWrite, %VerCurSub%, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,IniCreatedBySub
	IniWrite, 0, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,MOUSE_ESC_LOCK
	IniWrite, 0, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,UsrHateShortcut
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,FirstRun
	IniWrite, 0, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,HideTrayIcon
	IniWrite, %VerCurMain%, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,VerCurMain
	IniWrite, %VerCurSub%, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,VerCurSub
	IniWrite, 0, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,GPL_Accepted
	IniWrite, %ACAD_dir%, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,ACAD_dir
	IniWrite, %AdobeReader_dir%, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,AdobeReader_dir
	IniWrite, %SEP_dir%, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,SEP_dir
	IniWrite, %QQ_dir%, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,QQ_dir
	IniWrite, %Thunder_dir%, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,Thunder_dir
	IniWrite, %WINWORD_dir%, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,WINWORD_dir
	IniWrite, %OUTLOOK_dir%, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,OUTLOOK_dir
	IniWrite, %EXCEL_dir%, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,EXCEL_dir
	IniWrite, %PPT_dir%, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,PPT_dir
	IniWrite, %ACDSee_dir%, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,ACDSee_dir
	IniWrite, %AngryBirds_dir%, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,AngryBirds_dir
	IniWrite, %chrome_dir%, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,chrome_dir
	IniWrite, %FormatFactory_dir%, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,FormatFactory_dir
	IniWrite, %IDMan_dir%, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,IDMan_dir
	IniWrite, %EverNote_dir%, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,EverNote_dir
	IniWrite, %notepad2_dir%, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,notepad2_dir
	IniWrite, %Photoshop_dir%, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,Photoshop_dir
	IniWrite, %PVZ_dir%, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,PVZ_dir
	IniWrite, %PPLive_dir%, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,PPLive_dir
	IniWrite, %Storm_dir%, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,Storm_dir
	IniWrite, %TTPlayer_dir%, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,TTPlayer_dir
	IniWrite, %Picasa_dir%, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,Picasa_dir
	IniWrite, %CCleaner_dir%, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,CCleaner_dir
	IniWrite, %Nero_dir%, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,Nero_dir
	IniWrite, %Defraggler_dir%, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,Defraggler_dir
	IniWrite, %Firefox_dir%, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,Firefox_dir
	IniWrite, %Opera_dir%, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,Opera_dir
	IniWrite, %MSE_dir%, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,MSE_dir
	FormatTime, NowDate,, yyyyMMdd
	IniWrite, NEVER, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,LU_CheckDate
	IniWrite, 0, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,LU_Alarm
	IniWrite, 0, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,AutoClick_Alarm
	IniWrite, 00000000000000, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,BingLastDate
	RegRead, BingDir, HKEY_LOCAL_MACHINE, SYSTEM\ControlSet001\services\eventlog\Application\BingDesktop, EventMessageFile
	IfExist, %BingDir%
		IniWrite, %BingDir%, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,BingDir
	IniWrite, 0, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,RunAsAdmin
	IniWrite, 00000000, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,DonateHistory
FileSetAttrib, +H , %A_ScriptDir%\HK4WIN_SET.ini

}
return
 
 
 

 
 
 
 
 
#If ((WinActive("ahk_class CabinetWClass") || WinActive("ahk_class ExploreWClass")) &&  FnSwitch(0121)=1)
Label0121:


If (A_OSVersion="WIN_8" or A_OSVersion="WIN_9")
{
	send,#v
	return
}



if A_OSVersion = "WIN_XP"
{
BlockInput ,On
;;msgbox,VIEW_MODE=ONONON
;Send, {F10}vs
;sleep,200
If (VIEW_MODE=1)
	{
	;;msgbox,VIEW_MODE=H
	;Send, {F10}vs
		send,!v
	sleep,100
	send,s

	VIEW_MODE=2
	}
else if (VIEW_MODE=2)
	{
	;;msgbox,VIEW_MODE=S
	;Send, {F10}vn
		send,!v
	sleep,100
	send,n
	VIEW_MODE=3
	}
else if (VIEW_MODE=3)
	{
	;;msgbox,VIEW_MODE=N
	;Send, {F10}vl
		send,!v
	sleep,100
	send,l
	VIEW_MODE=4
	}
else if (VIEW_MODE=4)
	{
	;;msgbox,VIEW_MODE=L
	;Send, {F10}vd
		send,!v
	sleep,100
	send,d
	VIEW_MODE=5
	}
else if (VIEW_MODE=5)
	{
	;;msgbox,VIEW_MODE=D
	;Send, {F10}vh
		send,!v
	sleep,100
	send,h
	VIEW_MODE=1
	}


BlockInput ,Off
}
else
{
BlockInput ,On
;;msgbox,VIEW_MODE=ONONON
;Send, {F10}vs
;sleep,200
If (VIEW_MODE=1)
	{
	;;msgbox,VIEW_MODE=H
	;Send, {F10}vd
		send,!v
	sleep,100
	;send,d
	send,{Down 7}{Enter}
	VIEW_MODE=2
	}
else if (VIEW_MODE=2)
	{
	;;msgbox,VIEW_MODE=S
	;Send, {F10}vs
		send,!v
	sleep,100
	;send,s
	send,{Down 8}{Enter}
	VIEW_MODE=3
	}
else if (VIEW_MODE=3)
	{
	;;msgbox,VIEW_MODE=N
	;Send, {F10}vt
		send,!v
	sleep,100
	send,{Down 9}{Enter}
	;send,t
	;	sleep,30
	;send,{Enter}
	VIEW_MODE=4
	}
else if (VIEW_MODE=4)
	{
	;;msgbox,VIEW_MODE=L
	;Send, {F10}vx
		send,!v
	sleep,100
	;send,x
	send,{Down 2}{Enter}
	VIEW_MODE=5
	}
else if (VIEW_MODE=5)
	{
	;;msgbox,VIEW_MODE=D
	;Send, {F10}vr{Enter}
		send,!v
	sleep,100
	send,{Down 3}{Enter}
	;send,r
	;sleep,30
	;send,{Enter}
	;sleep,100
	;send,r
	VIEW_MODE=6
	}
else if (VIEW_MODE=6)
	{
	;;msgbox,VIEW_MODE=D
	;Send, {F10}vm
		send,!v
	sleep,100
	;send,m
	send,{Down 4}{Enter}
	VIEW_MODE=7
	}
else if (VIEW_MODE=7)
	{
	;;msgbox,VIEW_MODE=D
	;Send, {F10}vn
		send,!v
	sleep,100
	;send,n
	send,{Down 5}{Enter}
	VIEW_MODE=8
	}
else if (VIEW_MODE=8)
	{
	;PlayWAV("ding")
	send,!v
	sleep,100
	send,{Down 6}{Enter}
	VIEW_MODE=1
	}




BlockInput ,Off
}	





Return
#If
;;;;;The end #IF tag of FnSwitch 0121

as_Input_AlwaysOnTop:
{
WinSet, AlwaysOnTop, On, HK4WIN 定时关机
}
return

#If (FnSwitch(0333)=1)
~LCtrl & RCtrl::             ;定时关机
~RCtrl & LCtrl::
GoSub,ASD_START
return

ASD_START:
If AutoShutdown_Is_Counting_Down=1
{
GoSub,AutoShutdown_Cancel
return
}
GoSub,Countdown2Shutdown
return

Countdown2Shutdown:
If AutoShutdown_Alarm_Text=Shown
	return
SetTimer, as_Input_AlwaysOnTop , -1000
If (AutoShutdown_Run=1 or AutoShutdown_Run_INI=1)
{
	If AutoShutdown_Run_INI=1
		ASDINI=`n在INI文件中您设置了AutoShutdownTime的值
	else
		ASDINI=
		
		If(ASDMode="1")
		{
								asmin:=pageacc*60000
						If ASDLeftMin>60
						{
						my_hr:=ASDLeftMin/60
						my_hr^=0
						
						;msgbox,my_hr===%my_hr%
						my_min:=ASDLeftMin-(my_hr*60)
						;msgbox,%my_hr%---%my_min%
						If my_min=0
							ASDLeftMin2= %my_hr% 小时  
						else
							ASDLeftMin2= %my_hr% 小时 %my_min% 分钟 
						}
						else if (ASDLeftMin=60)
						{
							ASDLeftMin2= 1 小时
							my_min=0
							my_hr=1
						}
						else if (ASDLeftMin<2)
						{
							ASDLeftMin2=几秒钟
							my_min=1
							my_hr=0
						}
						else
						{
							ASDLeftMin2=%ASDLeftMin% 分钟
							my_min=%ASDLeftMin%
							my_hr=0
						}
						CancelAskTime=%ASDLeftMin2% 后
		}
	MsgBox, 262436, HK4WIN 定时关机, 您之前已经设置过定时关机！%ASDINI%`n自动关机时间是 %CancelAskTime%`n`n取消并重新设定吗？
	IfMsgBox Yes
	{
	ASDMode=0
	SetTimer, AutoShutdown_Alarm , Off
	SetTimer, AutoShutdown , Off
	SetTimer, ShutdownOn , Off
	CancelAskTime=
	AutoShutdown_Run=0
	AutoShutdown_Run_INI=0
	;MsgBox, 262192, HK4WIN自动关机, 已取消,2
	;;;;;tooltip,HK4WIN 定时关机已取消
	;SetTimer, RemoveToolTip, 3000
	;;;;;sleep,1500
	;;;;tooltip
	TrayTip , HK4WIN, 定时关机已取消, 3, 2
	Gosub, INPUT_NUM			
	}
	else
	{
		return
	}

}
else
{
	Gosub, INPUT_NUM
}
;;;;;;;;;SetTimer, INPUT_NUM, 3000
return
#If
;;;;;The end #IF tag of FnSwitch 0321

INPUT_NUM:
 ;msgbox,898989
IfWinExist,HK4WIN 定时关机
	WinActivate,HK4WIN 定时关机
else
{
	SetTimer, ChangeButtonNames_AutoSD, 50
	InputBox, pageacc,HK4WIN 定时关机, 倒数：指定若干分钟后自动关机，例如30。`n`n定时：指定自动关机时间，例如21:05。,notHIDE, 330, 180
	Gosub, CHECK_NUM
}


return

ChangeButtonNames_AutoSD:
IfWinNotExist,HK4WIN 定时关机
    return  ; Keep waiting.

WinActivate,HK4WIN 定时关机

ControlSetText,Button1,确定
ControlSetText,Button2,取消
WinSet, AlwaysOnTop, On,HK4WIN 定时关机
SetTimer, ChangeButtonNames_AutoSD, off 
return


; ========================检查数字合法性=========================
ShutdownTimeCheck(as_hr,as_min){
	If as_hr is not integer
		return 0
	else If as_min is not integer
		return 0
	else If (as_hr>23 or as_hr<0)
		return 0
	else If (as_min>59 or as_min<0)
		return 0		
	else
		return 1		
}
;;THE END OF FUN_ShutdownTimeCheck
ShutdownOn:

;MsgBox, SetTimer ShutdownOn runing
;PlayWAV("ding")
  If ((A_Hour = as_alarm_hr) && (A_Min = as_alarm_min) )
  {
	GoSub,AutoShutdown_Alarm
	AutoShutdown_Alarm_Did=1
	}
	else If ((A_Hour = as_time1) && (A_Min = as_time2) )
	{
	GoSub,AutoShutdown
	SetTimer, ShutdownOn , off
	;MsgBox, HAHA will shutdown on %as_time1%:%as_time2% NOW is %A_Hour%:%A_Min%:%A_Sec%
	}
	
	

return

as_time_format:
{



	If ShutdownTimeCheck(as_time1,as_time2)=1
		{
		If as_time2<10
			{
			If as_time1="00"
				as_alarm_hr="23"
			else
				as_alarm_hr:=as_time1-1
				
			as_alarm_min:=as_time2+50
			}
		else
			{
			as_alarm_hr:=as_time1
			as_alarm_min:=as_time2-10
			}
		StringLen, as_time1_len, as_time1
		StringLen, as_time2_len, as_time2
		StringLen, as_alarm_hr_len, as_alarm_hr
		StringLen, as_alarm_min_len, as_alarm_min
		If as_time1_len=1
			as_time1=0%as_time1%
		If as_time2_len=1
			as_time2=0%as_time2%
		If as_alarm_min_len=1
			as_alarm_min=0%as_alarm_min%
		If as_alarm_hr_len=1
			as_alarm_hr=0%as_alarm_hr%
		;MsgBox, will shutdown on %as_time1%:%as_time2% NOW is %A_Hour%:%A_Min%:%A_Sec% ALARM on %as_alarm_hr%:%as_alarm_min%
		If as_time1<6
			AP=凌晨
		else If  as_time1<12
			AP=上午
		else If  as_time1<18
			AP=下午
		else If  as_time1<24
			AP=晚上
		MsgBox, 262180, HK4WIN 定时关机, 您确定在%AP% %as_time1%:%as_time2% 自动关机吗？`n`n注意：`n1. HK4WIN 会强制关闭您的计算机，这意味着如果自动关机时您有未保存的文件，那么这些文件可能丢失；`n2. 如果您提前手动关闭、重启了您的计算机，或退出、重启了 HK4WIN ，则本次设置自动失效；`n3.在执行自动关机前，您将有机会取消自动关机；`n4.上述%as_time1%:%as_time2%指24小时之内的时刻。,60
			IfMsgBox Yes
			{
				ASDMode=2
				SetTimer, ShutdownOn , 10000
				AutoShutdown_Run=1		
				AutoShutdown_Alarm_Did=0				
				msgbox,262192,HK4WIN 定时关机, 已确认`n`n%AP% %as_time1%:%as_time2% 自动关机。,5
				CancelAskTime=%AP% %as_time1%:%as_time2%
				SetTimer, as_Input_AlwaysOnTop , Off
				
			}
			else
			{
			;MsgBox, 262208, HK4WIN 定时关机, HK4WIN 已取消操作，同时按左右 Ctrl 键重新设置。,10
			Gosub, INPUT_NUM
			}

		}
		;Gosub, ShutdownOn
	else
		{
		MsgBox, 262160, HK4WIN 定时关机 输入有误, 时间输入错误，请参照 6:05 和 23:45 重新设置,7
		Gosub, INPUT_NUM
		}
}
return


as_time_format_AutoRun:
				If ShutdownTimeCheck(as_time1,as_time2)=1
		{
		If as_time2<10
			{
			If as_time1="00"
				as_alarm_hr="23"
			else
				as_alarm_hr:=as_time1-1
				
			as_alarm_min:=as_time2+50
			}
		else
			{
			as_alarm_hr:=as_time1
			as_alarm_min:=as_time2-10
			}
		StringLen, as_time1_len, as_time1
		StringLen, as_time2_len, as_time2
		StringLen, as_alarm_hr_len, as_alarm_hr
		StringLen, as_alarm_min_len, as_alarm_min
		If as_time1_len=1
			as_time1=0%as_time1%
		If as_time2_len=1
			as_time2=0%as_time2%
		If as_alarm_min_len=1
			as_alarm_min=0%as_alarm_min%
		If as_alarm_hr_len=1
			as_alarm_hr=0%as_alarm_hr%
		;MsgBox, will shutdown on %as_time1%:%as_time2% NOW is %A_Hour%:%A_Min%:%A_Sec% ALARM on %as_alarm_hr%:%as_alarm_min%
		If as_time1<6
			AP=凌晨
		else If  as_time1<12
			AP=上午
		else If  as_time1<18
			AP=下午
		else If  as_time1<24
			AP=晚上


				SetTimer, ShutdownOn , 1000
				AutoShutdown_Run_INI=1	
				AutoShutdown_Alarm_Did=0
				;msgbox,262192,HK4WIN 定时关机, %AP% %as_time1%:%as_time2% 时将会自动关机。,5
				tooltip,%AP% %as_time1%:%as_time2% 自动关机
				sleep,3000
				tooltip
				CancelAskTime=%AP% %as_time1%:%as_time2%


		}

	else
		{
		AutoShutdown_Run_INI=0
		MsgBox, 262160, HK4WIN 定时关机 输入有误, 您输入的定时关机时间格式错误：`nAutoShutdownTime=%AutoShutdownTime%`n`n请重新设置，正确的格式有：`nAutoShutdownTime=6:05`nAutoShutdownTime=23:45`n`n取消自动关机请留空，即`nAutoShutdownTime=
		GoSub,OpenINI
		;sleep,2000
		
				Send, {CTRLDOWN}f{CTRLUP}
				sleep,200
				SendInput {Raw}AutoShutdownTime
				sleep,300
				Send, {Enter}
				;Send, {Tab 4}{Enter}
		}
			;msgbox,as_time_format
return

AutoShutdownLeftMin:
{
ASDLeftMin-=1
If(ASDLeftMin="0")
SetTimer, AutoShutdownLeftMin, Off
return
}


CHECK_NUM:
if ErrorLevel
	{
	;MsgBox, 262208, HK4WIN 定时关机, HK4WIN 已取消操作，同时按左右 Ctrl 键重新设置。,10
	}
else IfInString, pageacc, :
	{
	StringSplit, as_time, pageacc, `:,%A_Space%
	GoSub,as_time_format	
	}
else IfInString, pageacc, ：
	{
	StringSplit, as_time, pageacc, `：,%A_Space%
	GoSub,as_time_format	
	}
else if (pageacc=null)
	{  MsgBox, 262160, HK4WIN 定时关机 输入有误, 不能为空,3
		Gosub, INPUT_NUM
	}
else if (pageacc=0)
	{  MsgBox, 262160, HK4WIN 定时关机 输入有误, 不能为0，请重新输入,3
		Gosub, INPUT_NUM
	}
else if (pageacc<0)
	{  MsgBox, 262160, HK4WIN 定时关机 输入有误, 输入有误，请重新输入,3
		Gosub, INPUT_NUM
	}
else if pageacc is not integer 
	{  MsgBox, 262160, HK4WIN 定时关机 输入有误, 倒计时模式下必须是整数，如40`n定时模式下必须是24小时制时刻，如21:05`n`n请重新输入,7
		Gosub, INPUT_NUM
	}
else if (pageacc>4320)
	{  MsgBox, 262192, HK4WIN 定时关机 输入有误, 倒计时不能超过 4320 分钟（=72小时=3天）！请重新输入,5
		Gosub, INPUT_NUM
	}

else
	{  


;%WhichDay%%AP% %SDTimeHr3%:%SDTimeMin2%


Gosub,TimeAfterMin
		MsgBox, 262180, HK4WIN 定时关机, 确定在 %pageacc2%后，即%WhichDay%%AP% %SDTimeHr3%:%SDTimeMin2% 关机吗？`n`n注意：`n1. HK4WIN 会强制关闭您的计算机，这意味着如果自动关机时您有未保存的文件，那么这些文件可能丢失；`n2. 如果您提前手动关闭、重启了您的计算机，或退出、重启了 HK4WIN ，则本次设置自动失效；`n3. 上述关机倒计时从您按下“是”按钮后开始计算；`n4. 在执行自动关机前，您将有机会取消自动关机；`n5.！！！请注意：如果您的电脑在 %pageacc2%之内进入睡眠状态，那么睡眠期间的关机倒计时会暂停，待电脑恢复工作状态以后倒计时会继续进行，在这种情况下您的实际倒计时关机时间会长于%pageacc2%，您可以利用Windows的电源管理功能来控制进入睡眠状态的时间。,120
			IfMsgBox Yes
			{
			PlayWAV("notify")
			;msgbox,00000000000--%asmin%
			
			SetTimer, AutoShutdown, -%asmin%
			ASDLeftMin=%pageacc%
			SetTimer, AutoShutdownLeftMin, 60000
			AutoShutdown_Run=1
			If asmin>600000
			{
			asmin2:=asmin-600000
			;;;msgbox,262192,00002222222--%asmin2%
			SetTimer, AutoShutdown_Alarm, -%asmin2%
			}
Gosub,TimeAfterMin
			msgbox,262192,HK4WIN 定时关机,已确认自动关机时间为`n`n%pageacc2%后即%WhichDay%%TheASDDateAndTime%。,10
			ASDMode=1
			SetTimer, as_Input_AlwaysOnTop , Off
			



			
			
			
			
			
			;CancelAskTime=%SDTimeHr3%:%SDTimeMin2%
			;CancelAskTime=%TheASDDateAndTime%
			CancelAskTime=%pageacc%后
			AutoShutdown_Alarm_Did=0
			}
			else
			{
			;MsgBox, 262208, HK4WIN 定时关机, HK4WIN 已取消操作，同时按左右 Ctrl 键重新设置。,10
			Gosub, INPUT_NUM
			}
		
	}
return

Ding:
{
PlayWAV("ding")
DingCount--
tooltip,%DingCount% 秒后关机！`n同时按左右Ctrl键取消
If(DingCount<=0)
	{
		IfNotExist, %A_ScriptDir%\HK4WIN_SD.vbs
		{
			FileAppend, set kickoff=createobject("wscript.shell")`nkickoff.run "shutdown -s -f  -c HK4WIN正在关闭计算机。 -t 10", %A_ScriptDir%\HK4WIN_SD.vbs
		}
		Run,%A_ScriptDir%\HK4WIN_SD.vbs
		sleep,1500
		filedelete,%A_ScriptDir%\HK4WIN_SD.vbs
	}
	
}
return
DingStop:
{
SetTimer, Ding, off
sleep,1000
tooltip
menu, tray, Icon
AutoShutdown_Run=0

SetTimer, DingStop, off
}
return



AutoShutdown:
{
IfNotExist, %A_ScriptDir%\HK4WIN_SD.vbs
FileAppend, set kickoff=createobject("wscript.shell")`nkickoff.run "shutdown -s -f  -c HK4WIN正在关闭计算机。 -t 10", %A_ScriptDir%\HK4WIN_SD.vbs
	IfExist, %A_ScriptDir%\HK4WIN_SD.vbs
	{
	
	PlayWAV("tada")
	sleep,1000
	
	AutoShutdown_Is_Counting_Down=1
	DingCount=61
	SetTimer, Ding, 1000
	SetTimer, DingStop, -62500
	menu, tray, NoIcon
	sleep,1000
	;;
	}
	else
	{
	msgbox,HK4WIN ERROR:NO VBS SCRIPT TO SHUTDOWN // HK4WIN无法关闭计算机，请将HK4WIN移动到非系统分区后重试。
	}
}
return

AutoShutdown_Alarm_Countdown:
{
If AutoShutdown_Alarm_Did=1
return
PlayWAV("notify")
sleep,120
PlayWAV("notify")
sleep,120
PlayWAV("notify")

}
return




^+!d::



GoSub,AutoShutdown_Cancel
return
AutoShutdown_Cancel:
If AutoShutdown_Is_Counting_Down<>1
return
;MsgBox, 262436, HK4WIN 提醒, 取消自动关机吗？
;IfMsgBox Yes
;{
	AutoShutdown_Run=0
	AutoShutdown_Run_INI=0
	AutoShutdown_Is_Counting_Down=0
	SetTimer, Ding, off
	AutoShutdown_Alarm_Text=None
	SetTimer, ShutdownTimerDown, off 
;;;;;;;;;;;;;;;;BlockInput MouseMove
;;;;;;;;;;;;;;;;send,#r
;;;;;;;;;;;;;;;;sleep,200
;;;;;;;;;;;;;;;;SendInput {Raw}shutdown -a
;;;;;;;;;;;;;;;;send,{Enter}
;;;;;;;;;;;;;;;;BlockInput MouseMoveOff

tooltip
menu, tray, Icon
MsgBox, 262192, HK4WIN 自动关机已取消,自动关机已中止。,30
sleep,1500
filedelete,%A_ScriptDir%\HK4WIN_SD.vbs
;}
;else
;{

;}
return



AutoShutdown_Alarm:
{
If AutoShutdown_Alarm_Did=1
return
PlayWAV("notify")
sleep,120
PlayWAV("notify")
sleep,120
PlayWAV("notify")
MsgBox, 262192, HK4WIN 即将强制关机！！！, 注意：HK4WIN 将于 10 分钟后强制关闭您的计算机！！！`n`n请尽快结束正在进行的工作并保存！！！,30
;IfMsgBox Timeout
    ;MsgBox You didn't press YES or NO within the 5-second period.

;msgbox,gogogo222;;;Gosub, SAP
;Shutdown, 0
}
return



^+!u::



gosub,LaunchLU
return
;SetTimer,LaunchLU,-1000

LaunchLU:
;###############检测联网情况  开始#################
loop 10
{
;97.74.14.252
	filedelete,%temp%\hk4win_pingresult.txt
	RunWait,cmd /c ping 173.231.1.231 -n 1 > %temp%\hk4win_pingresult.txt,,hide
	fileread,pingresult,%temp%\hk4win_pingresult.txt
	IfInString,pingresult,的回复
		flag1=true
	else
		flag1=false
	IfInString,pingresult,Reply from
		flag2=true
	else
		flag2=false

;IfInString,pingresult,Reply from
If (flag1="true" or flag2="true")
	{
	;msgbox,YES
	InternetConnection=YES
	break
	}
else
	{
	;msgbox,NO
	InternetConnection=NO
	sleep,60000
	}
}
;###############检测联网情况  结束#################
If InternetConnection=NO
	return
;msgbox,will LaunchLU
IniRead, LU_CheckDate, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,LU_CheckDate
FormatTime, NowDate,, yyyyMMdd

FormatTime, NowWeek,, WDay
;msgbox,NowDate=%NowDate%
;msgbox,LU_CheckDate=%LU_CheckDate% <> NowDate=%NowDate%

If ((LU_CheckDate<>NowDate) && (NowWeek=1 || NowWeek=4 || LU_CheckDate="NEVER"))
{

	
	IfExist, %A_ScriptDir%\HK4WIN_LU_NEW.exe
	{
	FileMove, %A_ScriptDir%\HK4WIN_LU_NEW.exe, %A_ScriptDir%\HK4WIN_LU.exe,1
	sleep,5000
	;FileDelete,%A_ScriptDir%\HK4WIN_LU_NEW.exe
	}

	If (LU_CheckDate="NEVER" and FullScreen()=0)
	{
	IniRead, LU_Alarm_V, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,LU_Alarm
	If(LU_Alarm_V<>"3")
		{

		MsgBox, 262192, HK4WIN 自动更新, HK4WIN 会定期检查有无新版本，并自动更新。`n如果您的电脑安装了防火墙类软件，您可能会被询问是否允许 HK4WIN 连接网络，请您选择【允许】。`n`n如果要禁用自动更新，请按 Ctrl+Alt+Shift+F1 打开帮助文档。,60

		If (LU_Alarm_V=0)
			IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,LU_Alarm
		else If (LU_Alarm_V=1)
			IniWrite, 2, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,LU_Alarm
		else If (LU_Alarm_V=2)
			IniWrite, 3, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,LU_Alarm
		}
}
GoSub,RunLUexe


}	
return


CheckSogouIME()
{
Process, Exist,SogouCloud.exe
if ErrorLevel
	flag1=1
else
	flag1=0
Process, Exist,SogouImeBroker.exe
if ErrorLevel
	flag2=1
else
	flag2=0
Process, Exist,SogouImeBroker.exe
if ErrorLevel
	flag3=1
else
	flag3=0
Process, Exist,SGImeGuard.exe
if ErrorLevel
	flag4=1
else
	flag4=0
;msgbox,flag0=%flag1%*%flag2%*%flag3%

	If (flag1==0 and flag2==0 and flag3==0 and flag4==0)
	{
		return 0
	}
	else
	{
		return 1
	}
}

KillSogouIME:
{
If (SogouKilled==1)
return
	;tooltip,SwitchIME  start
	sleep,30
	SwitchIME("00000804")
	;tooltip,SwitchIME  end
	;sleep,300
	;tooltip
	
	SogouKilled=1
	sleep,500
	
	SetTimer, SogouKilled, -2000
}
return

SogouKilled:
{
SogouKilled=0
SetTimer, SogouKilled, off
return
}
;WheelUp::SendMessage, 0x115, 0, 0, %MouseControl%, ahk_id %MouseID%

WheelUp::

If ((IsCorner("4") or MouseIsOver2("ahk_class Button",0.2)) and FnSwitch(0310)=1)
{
Gosub,GetInfoUnderMouse
If (MouseClass<>"Flip3D" and IsGaming()="0")
	{
		tooltip,3D--%A_OSVersion%
		
		If (A_OSVersion="WIN_7" or A_OSVersion="WIN_VISTA")
		{
			send ^#{Tab}
			send { Up 1 }
			
		}
		else if (A_OSVersion="WIN_8" or A_OSVersion="WIN_9")
		{
			send ,#x
			msgbox,999
		}
		else
		{
		
		}
		tooltip,
	}
else
send { Up 1 }

return
}

If (FnSwitch(0301)=1)
{
	If IsCorner("3")=1
	{
	If ForbidWheel=1
	return
	
	;任务栏调高音量--开始
	
;WinActivate,ahk_class Shell_TrayWnd
If (A_OSVersion not in WIN_7,WIN_8,WIN_9,WIN_VISTA)
{
SoundGet, Now_Vol
FormatTime, Now_Hr,, H
FormatTime, Now_HrMin,, H:mm
if (Now_Vol>Vol_Max-2 and (Now_Hr>Vol_Night-1 or Now_Hr<Vol_Morning))
MsgBox, 262192, HK4WIN 音量过高提醒, 请不要将音量开得过大。`n`n如需对此提醒进行设置请按 Ctrl+Alt+Shift+Z 打开设置文件，`n调整底部“用户参数设置”的三个参数`nVol_Morning、Vol_Night 和 Vol_Max。


}
	

If (CheckSogouIME()=1)
	GoSub,KillSogouIME

	
if A_OSVersion not in WIN_7,WIN_8,WIN_9,WIN_VISTA
{
SoundGet, MUTE_ONOFF, , mute
If(MUTE_ONOFF="Off")
	SoundSet +1
else
{
SoundSet, 0
SoundSet, +1, , mute
SoundSet +1
}

SoundGet, Now_Vol,MASTER
Now_Vol2:=Show_Vol(Now_Vol)
ToolTip, 音量 : %Now_Vol2% ％
SetTimer, RemoveToolTip, 1000
}
else
{
;;;;若果是WIN_789,WIN_VISTA
Send {Volume_Up}
}

;任务栏调高音量--结束

return
	}

}
;The end tag of Fn0301

GoSub,GetInfoUnderMouse


If (FnSwitch(0335)=1)
{
;if WinActive("ahk_class DV2ControlHost")
If (MouseClass = "DV2ControlHost")
{
GoSub,DoWU
return
}

;CoordMode, Mouse, Relative
MouseGetPos,mouse_X,mouse_Y,win_UID,win_ClassNN ;获取指针下窗口的 UID 和 ClassNN以及鼠标指针全屏坐标
WinGetPos , win_X, win_Y, win_Width, , ahk_id %win_UID%
WinGetClass,win_Class,ahk_id %win_UID% ;根据 UID 获得窗口类名
;msgbox,win_ClassNN=%win_ClassNN%
;if WinActive("ahk_id %win_UID%") 
;	WinGetPos , , , win_Width,,A
;else
;	WinGetPos , , , win_Width,,ahk_id %win_UID%

;tooltip,MouseClass=%MouseClass%
;sleep,1000
;tooltip
If (MouseClass = "Shell_TrayWnd") ;指针是否在任务栏上
{
;;;;;;;If (MouseIsOver("ahk_class Shell_TrayWnd",0.9) and FnSwitch(0301)=1)


		
	SendEvent,{click,Right}
	;MouseClick , Left
	sleep,200
		

	;SendEvent,{click,Right}
	;Send,{WheelDown}

}
Else
{


;msgbox,否在任务栏上win_LeftBorder=%win_LeftBorder%///win_TopBorder=%win_TopBorder%///win_RightBorder=%win_RightBorder%
	If ((mouse_Y <= win_Y+28) &&(mouse_Y >= win_Y)&& (mouse_X >= win_X) && (mouse_X <= win_X+win_Width))
	{
		If ((win_Class = "Progman")or(win_Class = "WorkerW")or (win_Class = "#32768")or (win_Class = "#32770") or (win_Class = "SideBar_HTMLHostWindow") or (win_Class = "WHCFlyoutWindow") or (win_Class = "ClockFlyoutWindow") or (win_Class = "Desktop User Picture") or (IsGaming()=1) or (MouseClass="MSHTML40_Origin_Class") or (  ((win_Class="MozillaWindowClass")or(win_Class="MozillaUIWindowClass")) and (FFWheelDisabled=1) ))
			{
				GoSub,DoWU
				return
			}
			
		WheelWaitUp+=1
			;tooltip,%WheelWaitUp%
			SetTimer, RemoveWheelWaitUp, 1000
		If (WheelWaitUp="2")
			{
			WheelWaitUp=0
			
			
			WinMaximize,ahk_id %win_UID%
			WinSet, AlwaysOnTop, On,  ahk_id %win_UID%
			sleep,50
			WinSet, AlwaysOnTop, Off,  ahk_id %win_UID%

			sleep,50
			return

			}
		


	}
	Else
	{
GoSub,DoWU
	}
}
;CoordMode, Mouse, Screen
;msgbox,CoordMode--ed
}
;The end tag of Fn0335
else
{
GoSub,DoWU
}

;The end tag of Fn0335
Return

;WheelDown::SendMessage, 0x115, 1, 0, %MouseControl%, ahk_id %MouseID%

RemoveWheelWaitUp:
{
WheelWaitUp=0
SetTimer, RemoveWheelWaitUp, Off
return
}
RemoveWheelWaitDown:
{
WheelWaitDown=0
SetTimer, RemoveWheelWaitDown,Off
return
}

WheelDown::

If ((IsCorner("4") or MouseIsOver2("ahk_class Button",0.2)) and FnSwitch(0310)=1)
{

	
	
		If (A_OSVersion in WIN_7,WIN_VISTA)
		{
			Gosub,GetInfoUnderMouse
			If (MouseClass<>"Flip3D" and IsGaming()="0")
				send ^#{Tab}
			else
				send { Down 1 }
		}
		else if (A_OSVersion in WIN_8,WIN_9)
		{
			send #x
		}

return
}




If (FnSwitch(0301)=1)
{
If IsCorner("3")=1
		{
		If ForbidWheel=1
	return
			;任务栏调低音量--开始

		;WinActivate,ahk_class Shell_TrayWnd
		
If (CheckSogouIME()=1)
		GoSub,KillSogouIME

		
if A_OSVersion not in WIN_7,WIN_8,WIN_9,WIN_VISTA
{
SoundGet, MUTE_ONOFF, , mute
If(MUTE_ONOFF="Off")
	SoundSet -1
else
	SoundSet, 0

SoundGet, Now_Vol,MASTER
Now_Vol2:=Show_Vol(Now_Vol)
ToolTip, 音量 : %Now_Vol2% ％
SetTimer, RemoveToolTip, 1000
}
else
Send {Volume_Down}

;任务栏调低音量--结束
return
		}
}
;the end if tag of fn0301


GoSub,GetInfoUnderMouse

If (FnSwitch(0336)=1)
{
;if WinActive("ahk_class MozillaWindowClass") or WinActive("ahk_class MozillaUIWindowClass")
;{

;if MinFx=0
;{
;	GoSub,DoWD
;return
;}
;}
;if WinActive("ahk_class DV2ControlHost")
If (MouseClass = "DV2ControlHost")
{
	GoSub,DoWD
return
}
;CoordMode, Mouse, Relative
MouseGetPos,mouse_X,mouse_Y,win_UID,win_ClassNN ;获取指针下窗口的 UID 和 ClassNN以及鼠标指针全屏坐标
WinGetPos , win_X, win_Y, win_Width, , ahk_id %win_UID%
WinGetClass,win_Class,ahk_id %win_UID% ;根据 UID 获得窗口类名

;if WinActive("ahk_id %win_UID%") 
;	WinGetPos , , , win_Width,,A
;else
;	WinGetPos , , , win_Width,,ahk_id %win_UID%
If (MouseClass = "Shell_TrayWnd") ;指针是否在任务栏上
{
;;;;;;;If (MouseIsOver("ahk_class Shell_TrayWnd",0.9) and FnSwitch(0301)=1)


		
		;msgbox,不调

						WheelWaitDown+=1
							;tooltip,%WheelWaitDown%
							SetTimer, RemoveWheelWaitDown, 1000
						If (WheelWaitDown="1")
							{
							WheelWaitDown=0
							
									send,#m
									sleep,50

									return

							}
		

	;SendEvent,{click,Right}
	;Send,{WheelDown}

}
Else
{


;msgbox,否在任务栏上win_LeftBorder=%win_LeftBorder%///win_TopBorder=%win_TopBorder%///win_RightBorder=%win_RightBorder%
	If ((mouse_Y <= win_Y+28) &&(mouse_Y >= win_Y)&& (mouse_X >= win_X) && (mouse_X <= win_X+win_Width))
	{
	
		If ((win_Class = "Progman")or(win_Class = "WorkerW")or (win_Class = "#32768")or (win_Class = "#32770") or (win_Class = "SideBar_HTMLHostWindow") or (win_Class = "WHCFlyoutWindow") or (win_Class = "ClockFlyoutWindow") or (win_Class = "Desktop User Picture") or (IsGaming()=1) or (MouseClass="MSHTML40_Origin_Class") or (  ((win_Class="MozillaWindowClass")or(win_Class="MozillaUIWindowClass")) and (FFWheelDisabled=1) ))
			{
				GoSub,DoWD
				return		
			}
			

		If (InstantMinimizeWindow_V<>0)
		{
		
			GoSub,GetInfoUnderMouse	
			If(MouseClass<>"TXGuiFoundation")
				{
							WheelWaitDown+=1
							;tooltip,%WheelWaitDown%
							SetTimer, RemoveWheelWaitDown, 1000
						If (WheelWaitDown="2")
							{
							WheelWaitDown=0
							
							WinMinimize, ahk_id %MouseID%

							return

							}
				}
			else
				{		

				WinGetTitle, Temp0 , ahk_id %MouseID%
				;;;If Temp0 contains QQ20,QQ2011,QQ2010,QQ2009,QQ2008,QQ2007
					;;;Send, {CTRLDOWN}{ALTDOWN}z{ALTUP}{CTRLUP}
				If Temp0 contains QQ20
					{
					Send, {CTRLDOWN}{ALTDOWN}z{ALTUP}{CTRLUP}
						If(ActClass<>"TXGuiFoundation")
						{
							sleep,100
							Send, {CTRLDOWN}{ALTDOWN}z{ALTUP}{CTRLUP}
						}
					}
				else
				{
							WheelWaitDown+=1
							;tooltip,%WheelWaitDown%
							SetTimer, RemoveWheelWaitDown, 1000
						If (WheelWaitDown="2")
							{
							WheelWaitDown=0
							
							WinMinimize, ahk_id %MouseID%

							return

							}
				}
				}
		}
		else
		{
		;msgbox,最小化窗口 ;关闭窗口
		;WinMinimize,ahk_id %win_UID%
		;;;;;;;;;;;;;;WinGet, DAXIAO , MinMax, ahk_id %win_UID%
		
		

		
		
		
		
		if (DAXIAO = "1")
			WinRestore, ahk_id %MouseID%
		else
			{
			
			;;;;If (win_Class<>"TXGuiFoundation")
			;;;	WinMinimize, ahk_id %win_UID%
			;;;else
			;;;;;	{
				
				
				
				
			GoSub,GetInfoUnderMouse	
			If(MouseClass<>"TXGuiFoundation")
				{
							WheelWaitUp+=1
							;tooltip,%WheelWait%
							SetTimer, RemoveWheelWaitDown, 1000
						If (WheelWaitUp="2")
							{
							WheelWaitUp=0
							
							WinMinimize, ahk_id %MouseID%

							return

							}
				}
			else
				{
				
				
				
				
				
				WinGetTitle, Temp0 , ahk_id %MouseID%
				If Temp0 contains QQ20
					{
					Send, {CTRLDOWN}{ALTDOWN}z{ALTUP}{CTRLUP}
						If(ActClass<>"TXGuiFoundation")
						{
							sleep,100
							Send, {CTRLDOWN}{ALTDOWN}z{ALTUP}{CTRLUP}
						}
					}
				else
					
					{
								WheelWaitUp+=1
								;tooltip,%WheelWait%
								SetTimer, RemoveWheelWaitUp, 1000
							If (WheelWaitUp="2")
								{
								WheelWaitUp=0
								
								WinMinimize, ahk_id %MouseID%

								return

								}
					}
				}
			}
			
		;MouseGetPos,,,UID
		;msgbox,action最小化%UID%
		;msgbox,%UID%
		}
		sleep,100
		return
	}
	Else
	{
GoSub,DoWD
	}
}
;CoordMode, Mouse, Screen
;msgbox,CoordMode--ed
}
;the end if tag of fn0336
else
{
GoSub,DoWD
}
;the end if tag of fn0336
Return

;#If !(WinActive("ahk_class CabinetWClass") or WinActive("ahk_class IEFrame") or WinActive("ahk_class Progman") or WinActive("ahk_class WorkerW") or WinActive("ahk_class ExploreWClass") or WinActive("ahk_class MozillaWindowClass") or WinActive("ahk_class MozillaUIWindowClass")or WinActive("ahk_class MozillaWindowClass") or WinActive("ahk_class MozillaUIWindowClass"))

;#If















GesEx:
  settimer,gtrack,off           

	If (gtrack="")
		{
			sleep,20
			;MouseClick,M
			MouseClick,M, , , , , U
			;Click,Up,M
			return
		}
	else If (gtrack=Ex_Gesture_Copy)
		{	
			Send, ^c			
			tooltip,复制
			SetTimer, RemoveToolTip, 700
		
		}
		
	else If (gtrack=Ex_Gesture_Paste)
		{
		;msgbox,clipboard=%clipboard%
			
			tooltip,粘贴
			SetTimer, RemoveToolTip, 700
			Send, ^v
		
		}
	else If (gtrack=Ex_Gesture_DelInst)
		{



			Send, {SHIFTDOWN}{DEL}{SHIFTUP}
			tooltip,永久删除
			SetTimer, RemoveToolTip, 700

		}
	else If (gtrack=Ex_Gesture_Del)
		{

			Send, {DEL}
			tooltip,删除
			SetTimer, RemoveToolTip, 700
		
		}
	else If (gtrack=Ex_Gesture_Upper)
		{
		GoSub,GoUpperDir
		tooltip,向上
		SetTimer, RemoveToolTip, 700
		}
	else If (gtrack=Ex_Gesture_Cute)
		{	
			Send, ^x
			
			tooltip,剪切
			SetTimer, RemoveToolTip, 700
		
		}

	else If (gtrack=Ex_Gesture_Back)
		{
		Send, !{Left}
		tooltip,返回
		SetTimer, RemoveToolTip, 700
		}		
	else If (gtrack=Ex_Gesture_Pro)
		{
		;Sendplay {LButton}
		Send, !{Enter}
		tooltip,属性
		SetTimer, RemoveToolTip, 700
		}
		
	else If (gtrack=Ex_Gesture_Fwd)
		{
		Send, !{Right}
		tooltip,前进
		SetTimer, RemoveToolTip, 700
		}		
	else If (gtrack=Ex_Gesture_Close)
		{
		Send, ^w
		tooltip,关闭
		SetTimer, RemoveToolTip, 700
		}		
	else If (gtrack=Ex_Gesture_Undo)
		{
		sleep,30
		Send, ^z
		tooltip,撤销
		SetTimer, RemoveToolTip, 700
		}
	else
		{
		tooltip,此鼠标手势未定义
		SetTimer, RemoveToolTip, 700
		}		
gtrack=
Return




GesIE:
  settimer,gtrack,off           

	If (gtrack="")
		{
			sleep,20
			MouseClick,M
			;MouseClick,M, , , , , U
			;Click,Up,M
			return 
		}
	else If (gtrack=IE_Gesture_CloseTab)
		{
		Send, ^w
		tooltip,关闭
		SetTimer, RemoveToolTip, 700
		}
	else If (gtrack=IE_Gesture_Back)
		{
		Send, !{Left}
		tooltip,返回
		SetTimer, RemoveToolTip, 700
		}		
	else If (gtrack=IE_Gesture_Refresh)
		{
		Send, {F5}
		tooltip,刷新
		SetTimer, RemoveToolTip, 700
		}		
	else If (gtrack=IE_Gesture_NewTab)
		{
		Send, ^t
		tooltip,新建选项卡
		SetTimer, RemoveToolTip, 700
		}		
	else If (gtrack=IE_Gesture_UndoTab)
		{
		Send, ^+t
		tooltip,恢复关闭的选项卡
		SetTimer, RemoveToolTip, 700
		}		
	else If (gtrack=IE_Gesture_NextTab)
		{
		Send, ^{Tab}
		tooltip,后一个选项卡
		SetTimer, RemoveToolTip, 700
		}		
	else If (gtrack=IE_Gesture_PreTab)
		{
		Send, ^+{Tab}
		tooltip,前一个选项卡
		SetTimer, RemoveToolTip, 700
		}		
	else If (gtrack=IE_Gesture_Stop)
		{
		Send, {Esc}
		tooltip,停止
		SetTimer, RemoveToolTip, 700
		}		
	else If (gtrack=IE_Gesture_Forward)
		{
		Send, !{Right}
		tooltip,前进
		SetTimer, RemoveToolTip, 700
		}		
	else If (gtrack=IE_Gesture_PageHome)
		{
		Send, <^{Home}
		tooltip,页面顶部
		SetTimer, RemoveToolTip, 700
		}		
	else If (gtrack=IE_Gesture_PageEnd)
		{
		Send, <^{End}
		tooltip,页面底部
		SetTimer, RemoveToolTip, 700
		}
	else
		{
		tooltip,此鼠标手势未定义
		SetTimer, RemoveToolTip, 700
		}		
		
gtrack=
Return






MButton Up::
{
MouseGetPos,mouse_X,mouse_Y,win_UID,win_ClassNN ;获取指针下窗口的 UID 和 ClassNN以及鼠标指针全屏坐标
WinGetPos , win_X, win_Y, win_Width, , ahk_id %win_UID%
WinGetClass,win_Class,ahk_id %win_UID% ;根据 UID 获得窗口类名
;GoSub,GetInfoUnderMouse	






	If (win_Class="TXGuiFoundation")
	{
		If (FnSwitch(0221)="0")
			MouseClick,M
		else
			GoSub,GesQQ
	}
	else If (win_Class="IEFrame")
	{
		If (FnSwitch(0215)="0")
			MouseClick,M
		else
			GoSub,GesIE
	}
		
	else If ((win_Class="MozillaWindowClass")or(win_Class="MozillaUIWindowClass"))
	{
		If (FnSwitch(0222)="0")
			MouseClick,M
		else
			GoSub,GesFF
	}
	else If ((win_Class="CabinetWClass")or(win_Class="Progman")or(win_Class="OpusApp")or(win_Class="WorkerW")or()or(win_Class="ExploreWClass"))
	{
		If (FnSwitch(0122)="0")
			MouseClick,M
		else
			GoSub,GesEx
	}
	else If ((win_Class="Notepad")or(win_Class="Notepad++"))
	{
		If (FnSwitch(0223)="0")
			MouseClick,M
		else
			GoSub,GesNP
	}
	else 
	{
		MouseClick,M, , , , , U
	}
settimer,gtrack,off
gtrack=
;Click up M
}
return




GesQQ:
		  settimer,gtrack,off        

			If (gtrack="")
				{
				
					sleep,20
					;MouseClick,M
					MouseClick,M, , , , , U
					;Click,Up,M

					return 
				}
			else If (gtrack="L" or gtrack="LD" or gtrack="LU")
				{
				Send, ^{Left}
				tooltip,<<
				SetTimer, RemoveToolTip, 300
				}
			else If (gtrack="R" or gtrack="RD" or gtrack="RU")
				{
				Send, ^{Right}
				tooltip,>>
				SetTimer, RemoveToolTip, 300
				}		
			else If (gtrack="U" or gtrack="UL" or gtrack="UR")
				{
				Send, ^!z
				;tooltip,∏
				;SetTimer, RemoveToolTip, 300
				}		
			else If (gtrack="D" or gtrack="DL" or gtrack="DR")
				{		

				WinMinimize,ahk_id %win_UID%
				WinMinimize, ahk_id TXGuiFoundation
				}		
			else
				{
				;tooltip,此鼠标手势未定义
				;SetTimer, RemoveToolTip, 700
				}		
				
		gtrack=
return


;the end #If tag of QQ guesture
 
FFWheelDisabledTimer:
SetTimer, RemoveToolTip, Off
FFWheelDisabled=0
ToolTip

return

GesFF:
  settimer,gtrack,off
  FFWheelDisabled=1
  settimer,FFWheelDisabledTimer,2000
  ;msgbox,gtrack=%gtrack%
	If (gtrack="")
		{
		;msgbox,gtrack=%gtrack%  blank
			;sleep,20
			MouseClick,M
			
			;MouseClick,M, , , , , U
			;Click,Up,M
			;tooltip,ff gues blank
			return 
		}
	else If (gtrack="D" or gtrack="DL" or gtrack="DR")
		{
		Find_Content_Prev=%Find_Content%
		User_Content=%Clipboard%
		Send,^c
		sleep,20
		Find_Content=%Clipboard%
		
		
		Send,^f
		sleep,100
		Send, {Enter}
		If (Find_Content<>Find_Content_Prev)
			{
			Send, {Enter}
			sleep,100
			}
		}	
	else If (gtrack="U" or gtrack="UL" or gtrack="UR")
		{
		;tooltip,搜索...
		GoSub,F3_Search_Act
		
		;SetTimer, RemoveToolTip, 500
		sleep,50
		Send, {Esc}
		}
	else If (gtrack="R" or gtrack="RD" or gtrack="RU")
		{
		Send,^+e
		}
	else If (gtrack="L" or gtrack="LD" or gtrack="LU")
		{
		
		Send,^c
		tooltip,复制
		SetTimer, RemoveToolTip, 700
		;sleep,50
		;Send, {Esc}
		}		
	else
		{
		;tooltip,此鼠标手势未定义
		;SetTimer, RemoveToolTip, 700
		MouseClick,M, , , , , U
		;Click,Up,M
		}		
		
gtrack=
Return

 

GesNP:
  settimer,gtrack,off
  ;msgbox,Fn0223=%Fn0223_V%
	If (gtrack="")
		{
		;msgbox,gtrack=%gtrack%  blank
			;sleep,20
			MouseClick,M
			
			;MouseClick,M, , , , , U
			;Click,Up,M
			;tooltip,ff gues blank
			return 
		}
	else If (gtrack="L" or gtrack="LD" or gtrack="LU")
		{
		
		Send,^c
		tooltip,复制
		SetTimer, RemoveToolTip, 700
		}
	else If (gtrack="R" or gtrack="RD" or gtrack="RU")
		{
		
		Send,^v
		tooltip,粘贴
		SetTimer, RemoveToolTip, 700
		}
	else If (gtrack="D" or gtrack="DL" or gtrack="DR")
		{
		Send,{Delete}
		tooltip,删除
		SetTimer, RemoveToolTip, 700
		}
	else If (gtrack="U" or gtrack="UL" or gtrack="UR")
		{		
		tooltip,搜索...
		GoSub,F3_Search_Act		
		SetTimer, RemoveToolTip, 500
		}				
	else
		{
		;tooltip,此鼠标手势未定义
		;SetTimer, RemoveToolTip, 700
		;MouseClick,M, , , , , U
		MouseClick,M
		;Click,Up,M
		}		
		
gtrack=
Return
#If
;the end #If tag of NotePad guesture
 
 
  gtrack:
  mousegetpos xpos2,ypos2
  track:=(abs(ypos1-ypos2)>=abs(xpos1-xpos2)) ? (ypos1>ypos2 ? "U" : "D") : (xpos1>xpos2 ? "L" : "R") 
  if (track<>SubStr(gtrack, 0, 1)) and (abs(ypos1-ypos2)>4 or abs(xpos1-xpos2)>4)
     gtrack.=track 
  xpos1:=xpos2,ypos1:=ypos2
  return

  
  
GoUpperDir: 
;WinGetClass,sClass,A
;If (sClass="CabinetWClass")
;	Send, !{up}
;else If (sClass="ExploreWClass")
;	Send, {BS}
;else
;	MouseClick,M
If A_OSVersion in WIN_7,WIN_8,WIN_9,WIN_VISTA
	Send, !{up}
else
	Send, {BS}
return
 

#If (IsCorner("3")=0 and IsBorder("2")=0 )
$MButton::

;traytip,中键按下,5,1
MouseGetPos,mouse_X,mouse_Y,win_UID,win_ClassNN ;获取指针下窗口的 UID 和 ClassNN以及鼠标指针全屏坐标
WinGetPos , win_X, win_Y, win_Width, , ahk_id %win_UID%
WinGetClass,win_Class,ahk_id %win_UID% ;根据 UID 获得窗口类名







If (win_Class = "Shell_TrayWnd") ;指针是否在任务栏上
{
	;#####################在任务栏上  开始
			;MouseClick,M
			Click down M
			;MouseClick,M, , , , , D
			sleep,20
			;msgbox,OK
	return
	;#####################在任务栏上  结束
}
Else
{
;#####################不在任务栏上  开始

	;msgbox,不在任务栏上win_LeftBorder=%win_LeftBorder%///win_TopBorder=%win_TopBorder%///win_RightBorder=%win_RightBorder%  看在不在标题栏上
	
	

		
	 
		If ((FnSwitch(0337)=1)&&(mouse_Y <= win_Y+28) &&(mouse_Y >= win_Y)&& (mouse_X >= win_X) && (mouse_X <= win_X+win_Width))
		{
		;#####################在标题栏上  开始
			If ((IsGaming()=1) or  (((win_Class="MozillaWindowClass")or(win_Class="MozillaUIWindowClass")) and (FFWheelDisabled=1)) )
			{
			;MouseClick,M
			Click up M
			return
			}
			;If ((win_Class = "Progman") or (win_Class = "WorkerW"))
			if win_Class in Progman,WorkerW,DV2ControlHost
			{
			;msgbox,0022
			;MouseClick,M
			MouseClick,M, , , , , D
			;Click,Down,M
			return
			}
			WinClose,ahk_id %win_UID%
			sleep,300
			return
		;#####################在标题栏上  结束
		}
		Else
		{
		
		;#####################不在标题栏上  开始
			;#####################  鼠标手势  开始  #########################
			
			;WinGetClass,sClass,A
	
			
			If win_Class not in MozillaWindowClass,IEFrame,TXGuiFoundation,CabinetWClass,Progman,WorkerW,Notepad,ExploreWClass,Notepad,Notepad++,MozillaUIWindowClass
			{
			Click,Down,M
					;tooltip,flag m02 win_Class=%win_Class%
					;SetTimer, RemoveToolTip, 1000
					;ClipBoard=%win_Class%
			return
			}
			
			If (FnSwitch(0122)=1)
			{  

			If win_Class in CabinetWClass,Progman,WorkerW,Notepad,ExploreWClass
				{
				mousegetpos xpos1,ypos1
				settimer,gtrack,1				
				Return
				}
			}




			If (FnSwitch(0215)=1)
			{

			If (win_Class="IEFrame")
				{
				mousegetpos xpos1,ypos1
				settimer,gtrack,1
				Return
				}
			}
			
			If (FnSwitch(0221)=1)
			{
			
			If (win_Class="TXGuiFoundation")
				{
				mousegetpos xpos1,ypos1
				settimer,gtrack,1
				Return
				}
			}
			
			If (FnSwitch(0222)=1)
			{
			
			If (win_Class="MozillaWindowClass" or win_Class="MozillaUIWindowClass")
				{
				mousegetpos xpos1,ypos1
				settimer,gtrack,1
				Return
				}
			}
			
			
			
			If (FnSwitch(0223)=1)
			{

			If (win_Class="Notepad" or win_Class="Notepad++")
				{
				mousegetpos xpos1,ypos1
				settimer,gtrack,1
				Return
				}
			}
			
			
		
			
			;#####################  鼠标手势  结束  #########################
		;#####################不在标题栏上  结束
		
		;MouseClick,M, , , , , D
		;Click,Down,M
		;return

		}
	
;#####################不在任务栏上  结束
}
Return
#If


IsBorder(BD) {
	temp0=0
	SysGet, MonFull, Monitor
	MouseGetPos, xpos, ypos , Win


	
	If (BD="2")
	{
	If (xpos>MonFullRight-20 and ypos<MonFullBottom*0.8 and ypos>MonFullBottom*0.1)
		temp0=1
	}
	else If (BD="4")
	{
	If (xpos<20 and ypos<MonFullBottom*0.9 and ypos>MonFullBottom*0.1)
		temp0=1
	}
	else If (BD="3")
	{
	If (xpos>20 and xpos<MonFullRight*0.8 and ypos>MonFullBottom*0.95)
		temp0=1
	}
	else If (BD="1")
	{
	If (xpos>20 and xpos<MonFullRight*0.8 and ypos<MonFullBottom*0.05)
		temp0=1
	}
	else
	{
		temp0=0
	}
	
	If temp0=1
		return 1
	else
		return 0
}



#If (IsGaming()="0" and IsBorder("2")="1" and IsCorner("3")=0 and (FnSwitch(0344)=1))
MButton::

	{
;
			;GoSub,ShowCustomMenu
		GoSub,DoOpenNewFD	
	}
return
#If

 
#If (IsCorner("3")=1)
MButton::

If (FnSwitch(0301)=0)
return

			;任务栏静音--开始
If (CheckSogouIME()=1)
GoSub,KillSogouIME




if A_OSVersion not in WIN_7,WIN_8,WIN_9,WIN_VISTA
{
SoundSet, +1, , mute
SoundGet, MUTE_ONOFF, , mute
If(MUTE_ONOFF="Off")
{
SoundGet, Now_Vol
Now_Vol2:=Show_Vol(Now_Vol)
ToolTip, 音量 : %Now_Vol2% ％
SetTimer, RemoveToolTip, 1000
}
else
{
ToolTip, 静音
SetTimer, RemoveToolTip, 1000
}
return

}
else
{
Send {Volume_Mute}
ForbidWheel=1
SetTimer, ForbidWheelCancel, 700
return
}
;任务栏静音--结束

;the end if tag of fn0301
return
#If


ForbidWheelCancel:
ForbidWheel=0
SetTimer, ForbidWheelCancel, Off
return

#If (IsCorner("4") or MouseIsOver2("ahk_class Button",0.2))
MButton::

If (FnSwitch(0310)=0 or IsGaming()="1")
{
Click,M
return
}

	
	
		If (A_OSVersion in WIN_7,WIN_VISTA)
		{
			Gosub,GetInfoUnderMouse
			If (MouseClass<>"Flip3D")
				send ^#{Tab}
			else
				send {Enter}
		}
		else if (A_OSVersion in WIN_8,WIN_9)
		{
			send #x
		}

return
#If



#If (FnSwitch(0338)=1)
Label0338:
GoSub,F3_Search_Act
return

;<!3::GoSub,F3_Search_Act
F3_Search_Act:
;tooltip,WaitingFkWall=%WaitingFkWall%
If(WaitingFkWall=1)
{
	User_Content=%Clipboard%
	Clipboard=
	sleep,100
	send,^c
	SE_KW_NEW=%Clipboard%
	Clipboard=%User_Content%
	If (SE_KW_NEW=SE_KW or SE_KW_NEW="")
	{	
	run,www.baidu.com/s?wd=%SE_KW%	
	WaitingFkWall=0
	return
	}
	else
		goto,skip84644
}
;else
;tooltip,HH-WaitingFkWall=0

F3Blocked=0
IfWinActive,ahk_class (Notepad)
{
IfWinExist , 查找
	{
	F3Blocked=1
	}
	else IfWinExist , Find
	{
	F3Blocked=1
	}
}
If F3Blocked=1
{
	send,{F3}
	return
}


skip84644:
User_Content=%Clipboard%
Clipboard=
sleep,100
send,^c
SE_KW=%Clipboard%
If (Clipboard<>"")
{
	if SE_KW=%FindKW%
	{
	send,{F3}
	Clipboard=%User_Content%
	return
	}
	StringMid,Left2,SE_KW,2,2
	if (Left2=":\")
	{
		IfExist,%SE_KW%
		{
		Run,%SE_KW%
		Clipboard=%User_Content%
		return
		}
		
	}
	StringLeft, Left4, Clipboard, 4
	If (Left4="http" or Left4="www." or Left4="Http" or Left4="HTTP" or Left4="WWW." or Left4="Www.")
	{
		run,%SE_KW%
		Clipboard=%User_Content%
		return
	} 
	else
	{
		if Clipboard contains .com,.net,.org,.cn,.info,.me
		IsURL=1
		else
		IsURL=0

		If (IsURL=1 and Left4<>"http")
		{
			SE_KW=http://%SE_KW%
			run,%SE_KW%
			Clipboard=%User_Content%
			return
		}
	}


	If (SEID=1)
{
	WaitingFkWall=1
	Google_Over_Wall("HK")
	
}
	else if (SEID=2)
{
	WaitingFkWall=1
	Google_Over_Wall("INTL")
	
}
	else if (SEID=3)
		run,www.baidu.com/s?wd=%clipboard%
	else
		Google_Over_Wall("HK")


}
else
{



send,{F3}
send,^c
FindKW=%Clipboard%
Clipboard=%User_Content%
}
Clipboard=%User_Content%

return

$+F3::


User_Content=%Clipboard%
Clipboard=
sleep,100
send,^c
;;ClipWait,3
;;;;;;;;;;;;Keywords=%clipboard%
If (Clipboard<>"")
{

If (SEID2=3)
	run,www.baidu.com/s?wd=%clipboard%
else if (SEID2=2)
{
	WaitingFkWall=1
	Google_Over_Wall("INTL")
	
}
else if (SEID2=1)	
{
	WaitingFkWall=1
	Google_Over_Wall("HK")
	
}
else
	run,www.baidu.com/s?wd=%clipboard%
}
else
send,+{F3}
Clipboard=%User_Content%
;Keywords=""
return
#If
;The end tag of Fn0338


;`::Delete
WaitingFkWallTimer:
SetTimer, WaitingFkWallTimer, Off
WaitingFkWall=0
return


Google_Over_Wall(Engine)
{
If Engine=INTL
{
	;run,www.google.com/search?hl=zh-CN&q=%clipboard%&oq=%clipboard%&aq=f&aqi=&aql=&gs_sm=e
	run,www.google.com/search?q=%clipboard%
}
else
{
	run,www.google.com.hk/search?q=%clipboard%
}


SetTimer, WaitingFkWallTimer, 10000
;tooltip,WaitingFkWallTimer Running WaitingFkWall=%WaitingFkWall%
}




IsCorner(CN) {
	temp0=0
	SysGet, MonFull, Monitor
	MouseGetPos, xpos, ypos , Win
	
	If (CN=3)
	{
	If (xpos>MonFullRight*0.8 and ypos>MonFullBottom*0.95)
		temp0=1
	}
	else If (CN=4)
	{
	If (xpos<MonFullRight*0.05 and ypos>MonFullBottom*0.95)
		temp0=1
	}
	else If (CN=2)
	{
	If (xpos>MonFullRight*0.95 and ypos<MonFullBottom*0.05)
		temp0=1
	}
	else If (CN=1)
	{
	If (xpos<MonFullRight*0.05 and ypos<MonFullBottom*0.05)
		temp0=1
	}
	
	If temp0=1
		return 1
	else
		return 0
}

FullScreen() {
	SysGet, MonFull, Monitor
	WinGetPos,win_X, win_Y, win_Width, win_Height, A
;msgbox,%win_X%<1 and %win_Y%<1 and Abs(%MonFullRight%-%win_Width%)<10 and Abs(%MonFullBottom%-%win_Height%)<10)

;IfWinActive,ahk_class (Progman|WorkerW)
If (WinActive("ahk_class Progman")or WinActive("ahk_class WorkerW"))
	return 0
If (win_X=0 and win_Y=0 and Abs(MonFullRight-win_Width)=0 and Abs(MonFullBottom-win_Height)=0)
	return 1
else
	return 0
}




#If (FnSwitch(0334)=1)
;;;$$$$$$$$$$$ KDE窗口风格  开始$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$



;;;;;;;;;;;;;;;;;;;;;;SetWinDelay,0

CoordMode,Mouse
return

>!LButton::

;

If DoubleAlt
{
    MouseGetPos,,,KDE_id
    ; This message is mostly equivalent to WinMinimize,
    ; but it avoids a bug with PSPad.
    PostMessage,0x112,0xf020,,,ahk_id %KDE_id%
    DoubleAlt := false
    return
}
; Get the initial mouse position and window id, and
; abort if the window is maximized.
MouseGetPos,KDE_X1,KDE_Y1,KDE_id
WinGet,KDE_Win,MinMax,ahk_id %KDE_id%
If KDE_Win
    return
; Get the initial window position.
WinGetPos,KDE_WinX1,KDE_WinY1,,,ahk_id %KDE_id%
Loop
{
    GetKeyState,KDE_Button,LButton,P ; Break if button has been released.
    If KDE_Button = U
        break
    MouseGetPos,KDE_X2,KDE_Y2 ; Get the current mouse position.
    KDE_X2 -= KDE_X1 ; Obtain an offset from the initial mouse position.
    KDE_Y2 -= KDE_Y1
    KDE_WinX2 := (KDE_WinX1 + KDE_X2) ; Apply this offset to the window position.
    KDE_WinY2 := (KDE_WinY1 + KDE_Y2)
    WinMove,ahk_id %KDE_id%,,%KDE_WinX2%,%KDE_WinY2% ; Move the window to the new position.
}
return

>!RButton::

;

If DoubleAlt
{
    MouseGetPos,,,KDE_id
    ; Toggle between maximized and restored state.
    WinGet,KDE_Win,MinMax,ahk_id %KDE_id%
    If KDE_Win
        WinRestore,ahk_id %KDE_id%
    Else
        WinMaximize,ahk_id %KDE_id%
    DoubleAlt := false
    return
}
; Get the initial mouse position and window id, and
; abort if the window is maximized.
MouseGetPos,KDE_X1,KDE_Y1,KDE_id
WinGet,KDE_Win,MinMax,ahk_id %KDE_id%
If KDE_Win
    return
; Get the initial window position and size.
WinGetPos,KDE_WinX1,KDE_WinY1,KDE_WinW,KDE_WinH,ahk_id %KDE_id%
; Define the window region the mouse is currently in.
; The four regions are Up and Left, Up and Right, Down and Left, Down and Right.
If (KDE_X1 < KDE_WinX1 + KDE_WinW / 2)
   KDE_WinLeft := 1
Else
   KDE_WinLeft := -1
If (KDE_Y1 < KDE_WinY1 + KDE_WinH / 2)
   KDE_WinUp := 1
Else
   KDE_WinUp := -1
Loop
{
    GetKeyState,KDE_Button,RButton,P ; Break if button has been released.
    If KDE_Button = U
        break
    MouseGetPos,KDE_X2,KDE_Y2 ; Get the current mouse position.
    ; Get the current window position and size.
    WinGetPos,KDE_WinX1,KDE_WinY1,KDE_WinW,KDE_WinH,ahk_id %KDE_id%
    KDE_X2 -= KDE_X1 ; Obtain an offset from the initial mouse position.
    KDE_Y2 -= KDE_Y1
    ; Then, act according to the defined region.
    WinMove,ahk_id %KDE_id%,, KDE_WinX1 + (KDE_WinLeft+1)/2*KDE_X2  ; X of resized window
                            , KDE_WinY1 +   (KDE_WinUp+1)/2*KDE_Y2  ; Y of resized window
                            , KDE_WinW  -     KDE_WinLeft  *KDE_X2  ; W of resized window
                            , KDE_WinH  -       KDE_WinUp  *KDE_Y2  ; H of resized window
    KDE_X1 := (KDE_X2 + KDE_X1) ; Reset the initial position for the next iteration.
    KDE_Y1 := (KDE_Y2 + KDE_Y1)
}
return

;;;$$$$$$$$$$$ KDE窗口风格  结束$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#If
;;;;;The end #IF tag of FnSwitch 0334






return

^+!Pause::
Suspend
GoSub,Pause_HK4WIN
return
!+Pause::
Suspend
GoSub,Pause_HK4WIN
return
;现在启用:
Pause_HK4WIN:
;Suspend
if pausedbyhk=0
{
	pausedbyhk=1
Suspend,On
	PlayWAV("ding")
	;;;;MsgBox , 0, HK4XP, 已禁用..., 1
	;;;;;;;tooltip,HK4WIN 已停用
	TrayTip , HK4WIN,已暂停使用 , 5, 2
	Menu, Tray,Rename,暂停 HK4WIN,重新启用 HK4WIN
}
else
{
	pausedbyhk=0
	Suspend,Off
	PlayWAV("chimes")
	;;;;;;MsgBox , 0, HK4XP, 已启用..., 1
	;tooltip,HK4WIN 已启用
	TrayTip , HK4WIN,已重新启用 , 5, 2
SetTimer, RemoveToolTip, 1500
Menu, Tray,Rename,重新启用 HK4WIN,暂停 HK4WIN
}

return

TimeAfterMin:
{
				asmin:=pageacc*60000
		If pageacc>60
		{
		my_hr:=pageacc/60
		my_hr^=0
		
		;msgbox,my_hr===%my_hr%
		my_min:=pageacc-(my_hr*60)
		;msgbox,%my_hr%---%my_min%
		If my_min=0
			pageacc2= %my_hr% 小时  
		else
			pageacc2= %my_hr% 小时 %my_min% 分钟 
		}
		else if (pageacc=60)
		{
			pageacc2= 1 小时
			my_min=0
			my_hr=1
		}
		else
		{
			pageacc2=%pageacc% 分钟
			my_min=%pageacc%
			my_hr=0
		}
;;计算关机时间--开始			
		FormatTime, CurrentMin,, m
		FormatTime, CurrentHr,, H
		;;;msgbox,CurrentHr=%CurrentHr%，CurrentMin=%CurrentMin%---N小时（ %my_min% ）分钟后关机
		all_only_Min:=CurrentMin + my_min
		;;msgbox,all_only_Min=%all_only_Min%
		If all_only_Min>60
		{
		;;msgbox,all_only_Min>60
		hr_add_step:=all_only_Min/60
		hr_add_step^=0
		

		
		}
		else if (all_only_Min=60)
			hr_add_step=1 
		else
			hr_add_step=0
			
		;;msgbox,hr_add_step===%hr_add_step%			
		
		SDTimeHr:=CurrentHr + hr_add_step + my_hr
		;;msgbox,SDTimeHr1=%SDTimeHr%
		SDTimeHr^=0
		;;msgbox,SDTimeHr2=%SDTimeHr%
		SDTimeMin:=all_only_Min - (hr_add_step*60)
		
		If (SDTimeHr>=24 and SDTimeHr<48)
		{
		WhichDay=明天
		SDTimeHr2:=SDTimeHr-24
		}
		else If (SDTimeHr>=48 and SDTimeHr<72)
		{
		WhichDay=后天
		SDTimeHr2:=SDTimeHr-48
		}
		else If (SDTimeHr>=72 and SDTimeHr<97)
		{
		WhichDay=大后天
		SDTimeHr2:=SDTimeHr-72
		}
		else
		{
		WhichDay=今天
		SDTimeHr2:=SDTimeHr
		}
		
		;FormatTime, CurrentHr,, H
		;;msgbox,SDTimeHr=%SDTimeHr2%，SDTimeMin=%SDTimeMin%
		If SDTimeHr2<6
			AP=凌晨
		else If  SDTimeHr2<12
			AP=上午
		else If  SDTimeHr2<18
			AP=下午
		else If  SDTimeHr2<24
			AP=晚上
		
		If SDTimeHr2<10
			SDTimeHr3=0%SDTimeHr2%
		else
			SDTimeHr3:=SDTimeHr2
		
		If SDTimeMin<10
			SDTimeMin2=0%SDTimeMin%
		else
			SDTimeMin2:=SDTimeMin		
		
		;SDTimeHr:=CurrentHr + my_min
;;计算关机时间--结束

			var1 =
			var1 += %pageacc%, Minutes
			;msgbox,%var1%
			StringMid, var1Year, var1, 1 , 4 
			StringMid, var1Month, var1, 5 , 2 
			StringMid, var1Day, var1, 7 , 2 
			StringMid, var1Hr, var1, 9 , 2 
			StringMid, var1Min, var1, 11 , 2 
			;StringMid, var1Sec, var1, 13 , 2
			
	TheASDDateAndTime=%var1Year%年%var1Month%月%var1Day%日%var1Hr%时%var1Min%分
}
return

wp:
run,C:\Windows\system32\wp.exe
return

PlayWAV(wavfile)
{
IfExist, %A_WinDir%\Media\%wavfile%.wav
	SoundPlay, %A_WinDir%\Media\%wavfile%.wav
else
	SoundPlay *48
}













DoWU:
{
If (FnSwitch(0340)=0)
	{
	Send,{WheelUp}
	return
	}
Gosub,GetInfoUnderMouse

If(CurWinTitle="系统" or CurWinTitle="System" or( MouseID=ActID  and MouseClass<>"CabinetWClass" and MouseClass<>"HH Parent"))
	{
	Send,{WheelUp}
	return
	}
	
	If MouseClass contains         Photo_Lightweight_Viewer,OpusApp,XLMAIN,PP12FrameClass,rctrl_renwnd32,%WheelList%
	{
	;msgbox,contains %MouseClass%
		WinActivate, ahk_id %MouseID%
		Send,{WheelUp}
		;SendMessage, 0x115, 0, 0, %MouseControl%, ahk_id %MouseID%
	}
	else
	{	
			If MouseControl contains DirectUIHWND,ToolbarWindow,RebarWindow
				MouseControl=ScrollBar2
			Loop %WheelSpeed%{
				SendMessage, 0x115, 0, 0, %MouseControl%, ahk_id %MouseID%
			}	
				;Send,{WheelUp}
	}
}
Return


DoWD:
{
If (FnSwitch(0340)=0)
	{
	Send,{WheelDown}
	return
	}
Gosub,GetInfoUnderMouse

If(CurWinTitle="系统" or CurWinTitle="System" or( MouseID=ActID  and MouseClass<>"CabinetWClass" and MouseClass<>"HH Parent"))
	{
	;msgbox,error
	Send,{WheelDown}
	return
	}
	
	If MouseClass contains Photo_Lightweight_Viewer,OpusApp,XLMAIN,PP12FrameClass,rctrl_renwnd32,%WheelList%
	{
		WinActivate, ahk_id %MouseID%
		Send,{WheelDown}
	}
	else
	{	
			If MouseControl contains DirectUIHWND,ToolbarWindow,RebarWindow
				MouseControl=ScrollBar2

			;msgbox,MouseID=%MouseID%   MouseControl=%MouseControl%
			Loop %WheelSpeed%{
				SendMessage, 0x115, 1, 0, %MouseControl%, ahk_id %MouseID%
			}	
				;Send,{WheelDown}
	}
}
Return


DownLU:
UrlDownloadToFile, http://www.songruihua.com/hk4win-lu, %A_ScriptDir%\HK4WIN_LU.exe
if ErrorLevel   ; i.e. it's not blank or zero.
    {
	
	}
else
    {
	IfExist,%A_ScriptDir%\HK4WIN_LU.exe
		{
				FileSetAttrib, +H, %A_ScriptDir%\HK4WIN_LU.exe
				run,%A_ScriptDir%\HK4WIN_LU.exe
		}
	else
		SetTimer, DownLU, -60000
	}
return



RunLUexe:
{
;SetTimer, KillLUexe, 300000
Process, Exist, HK4WIN_LU.exe
	if ErrorLevel
	{
		;MsgBox HK4WIN_LU.exe exist
		Process, Close, HK4WIN_LU.exe
		If ErrorLevel
		{
			;MsgBox HK4WIN_LU.exe closed successfully
			sleep,1000
			IfExist,%A_ScriptDir%\HK4WIN_LU.exe
				{
				FileSetAttrib, +H, %A_ScriptDir%\HK4WIN_LU.exe
				run,%A_ScriptDir%\HK4WIN_LU.exe
				}
			else
				GoSub,DownLU
		}
		else
		{
			;MsgBox HK4WIN_LU.exe closed failed,still exist
			return
		}

	}
	else
	{
		IfExist,%A_ScriptDir%\HK4WIN_LU.exe
				{
				FileSetAttrib, +H, %A_ScriptDir%\HK4WIN_LU.exe
				run,%A_ScriptDir%\HK4WIN_LU.exe
				}
		else
				GoSub,DownLU
	}

}
return

KillLUexe:
{
Process, Exist, HK4WIN_LU.exe
if ErrorLevel
{
    ;MsgBox HK4WIN_LU.exe exist
	Process, Close, HK4WIN_LU.exe
	If ErrorLevel
	{
		;MsgBox HK4WIN_LU.exe closed successfully
		SetTimer, KillLUexe, Off
	}
}
}
return

BIOff:
BlockInput, Off
BlockInput, MouseMoveOff
SetTimer, BIOff, Off
return


222OnClipboardChange:
ToolTip Clipboard data type: %A_EventInfo%
Sleep 1000
ToolTip  ; Turn off the tip.
return


ReBuildIni:
;If(ReBuildIniNeed="1" and ((IniCreatedByMain<VerCurMain)or((IniCreatedByMain=VerCurMain)and(IniCreatedBySub<VerCurSub))))
If(0<1)
{
;msgbox,ReBuildIni will run
	IfExist, %A_ScriptDir%\HK4WIN_SET.ini
		FileMove, %A_ScriptDir%\HK4WIN_SET.ini, %A_ScriptDir%\HK4WIN_SET_OLD.ini,1
	GoSub,CREATE_INI
	IfExist, %A_ScriptDir%\HK4WIN_SET_OLD.ini
	{
	;@@@@@@@@@@@@@@@@@@@@开始恢复用户配置信息
		List_1_z=1,2,3,4,5,6,7,8,9,0,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z
		StringSplit, List_1_z_Array, List_1_z, `,
		Loop, %List_1_z_Array0%
		{
			this_Array := List_1_z_Array%a_index%
			IniRead, temp0, %A_ScriptDir%\HK4WIN_SET_OLD.ini, OpenApp, %this_Array%
			IniRead, temp1, %A_ScriptDir%\HK4WIN_SET_OLD.ini, OpenWeb, %this_Array%
			IniRead, temp2, %A_ScriptDir%\HK4WIN_SET_OLD.ini, FastInput, %this_Array%
			If (temp0<>"ERROR")
			IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, OpenApp, %this_Array%
			If (temp1<>"ERROR")
			IniWrite, %temp1%, %A_ScriptDir%\HK4WIN_SET.ini, OpenWeb, %this_Array%
			If (temp2<>"ERROR")
			IniWrite, %temp2%, %A_ScriptDir%\HK4WIN_SET.ini, FastInput, %this_Array%
			
		}
		;MsgBox, List_1_z OVER THEN List_F5_F12 WILL BEGIN
		List_F5_F12=F5,F6,F7,F8,F9,F10,F11,F12
		StringSplit, List_F5_F12_Array, List_F5_F12, `,
		Loop, %List_F5_F12_Array0%
		{
			this_Array := List_F5_F12_Array%a_index%
			IniRead, temp0, %A_ScriptDir%\HK4WIN_SET_OLD.ini, OpenDir, %this_Array%
			If (temp0<>"ERROR")
			IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, OpenDir, %this_Array%
		}
		;MsgBox, List_F5_F12 OVER THEN List_F5_F12 WILL BEGIN
			IniRead, temp0, %A_ScriptDir%\HK4WIN_SET_OLD.ini, RClickCorner, 1_TL			
			IniRead, temp1, %A_ScriptDir%\HK4WIN_SET_OLD.ini, RClickCorner, 2_TR			
			IniRead, temp2, %A_ScriptDir%\HK4WIN_SET_OLD.ini, RClickCorner, 3_BR			
			IniRead, temp3, %A_ScriptDir%\HK4WIN_SET_OLD.ini, RClickCorner, 4_BL
			If (temp0<>"ERROR")
			IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, RClickCorner, 1_TL
			If (temp1<>"ERROR")
			IniWrite, %temp1%, %A_ScriptDir%\HK4WIN_SET.ini, RClickCorner, 2_TR
			If (temp2<>"ERROR")
			IniWrite, %temp2%, %A_ScriptDir%\HK4WIN_SET.ini, RClickCorner, 3_BR
			If (temp3<>"ERROR")
			IniWrite, %temp3%, %A_ScriptDir%\HK4WIN_SET.ini, RClickCorner, 4_BL
			
			
			CM=1
			Loop,20
			{
			IniRead, temp0, %A_ScriptDir%\HK4WIN_SET_OLD.ini, CustomMenu, %CM%
			If (temp0<>"ERROR")			
			IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, CustomMenu, %CM%
			CM += 1
			}
			
			
			
			
			FnID=101
			Loop,22
			{
			IniRead, temp0, %A_ScriptDir%\HK4WIN_SET_OLD.ini, FnSwitch, Fn0%FnID%
			If (temp0<>"ERROR")			
			IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0%FnID%
			FnID += 1
			}
			FnID=201
			Loop,24
			{
			IniRead, temp0, %A_ScriptDir%\HK4WIN_SET_OLD.ini, FnSwitch, Fn0%FnID%
			If (temp0<>"ERROR")			
			IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0%FnID%
			FnID += 1
			}
			IniWrite, 0, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0217
			FnID=301
			Loop,41
			{
			IniRead, temp0, %A_ScriptDir%\HK4WIN_SET_OLD.ini, FnSwitch, Fn0%FnID%
			If (temp0<>"ERROR")
			IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0%FnID%
			FnID += 1
			}
			IniRead, temp0, %A_ScriptDir%\HK4WIN_SET_OLD.ini, FnSwitch, Fn0337
			If temp0 contains Chrome_WidgetWin
			{
				If temp0 not contains Chrome_WidgetWin_1
				{
					temp0=%temp0%,Chrome_WidgetWin_1,Chrome_WidgetWin_2,Chrome_WidgetWin_3,Chrome_WidgetWin_4
					IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0337
				}
			}
			
			


			
			IniRead, temp0, %A_ScriptDir%\HK4WIN_SET_OLD.ini, FnSwitch, Fn0401
			If (temp0<>"ERROR")
			IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0401

			IniRead, temp0, %A_ScriptDir%\HK4WIN_SET_OLD.ini, FnSwitch, Fn0402
			If (temp0<>"ERROR")
			IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0402

			IniRead, temp0, %A_ScriptDir%\HK4WIN_SET_OLD.ini, FnSwitch, Fn0501
			If (temp0<>"ERROR")
			IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0501
			
			IniRead, temp0, %A_ScriptDir%\HK4WIN_SET_OLD.ini, FnSwitch, Fn0502
			If (temp0<>"ERROR")
			IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0502
			
			IniRead, temp0, %A_ScriptDir%\HK4WIN_SET_OLD.ini, FnSwitch, Fn0503
			If (temp0<>"ERROR")
			IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0503
			
			IniRead, temp0, %A_ScriptDir%\HK4WIN_SET_OLD.ini, FnSwitch, Fn0504
			If (temp0<>"ERROR")
			IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0504
			
			IniRead, temp0, %A_ScriptDir%\HK4WIN_SET_OLD.ini, FnSwitch, Fn0505
			If (temp0<>"ERROR")
			IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0505
			
			IniRead, temp0, %A_ScriptDir%\HK4WIN_SET_OLD.ini, FnSwitch, BlackList
			If (temp0<>"ERROR")
			IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, BlackList
			
			
			;IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0215
			IniRead, temp0, %A_ScriptDir%\HK4WIN_SET_OLD.ini, UserSetting, Vol_Morning
			If (temp0<>"ERROR")
			IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting, Vol_Morning
			
			IniRead, temp0, %A_ScriptDir%\HK4WIN_SET_OLD.ini, UserSetting, Vol_Night
			If (temp0<>"ERROR")
			IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,Vol_Night
			
			IniRead, temp0, %A_ScriptDir%\HK4WIN_SET_OLD.ini, UserSetting, Vol_Max
			If (temp0<>"ERROR")
			IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,Vol_Max
			
			IniRead, temp0, %A_ScriptDir%\HK4WIN_SET_OLD.ini, UserSetting, Vol_Home
			If (temp0<>"ERROR")
			IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting, Vol_Home
			
			IniRead, temp0, %A_ScriptDir%\HK4WIN_SET_OLD.ini, UserSetting, OpenAppMax
			If (temp0<>"ERROR")
			IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,OpenAppMax
			
			IniRead, temp0, %A_ScriptDir%\HK4WIN_SET_OLD.ini, UserSetting, SearchEngine_F3
			If (temp0<>"ERROR")
			IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,SearchEngine_F3
			
			IniRead, temp0, %A_ScriptDir%\HK4WIN_SET_OLD.ini, UserSetting, SearchEngine_Shift_F3
			If (temp0<>"ERROR")
			IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting, SearchEngine_Shift_F3
			
			IniRead, temp0, %A_ScriptDir%\HK4WIN_SET_OLD.ini, UserSetting, DisableLiveUpdate
			If (temp0<>"ERROR")
			IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,DisableLiveUpdate
			
			IniRead, temp0, %A_ScriptDir%\HK4WIN_SET_OLD.ini, UserSetting, InstantMinimizeWindow
			If (temp0<>"ERROR")
			IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting, InstantMinimizeWindow
			
			IniRead, temp0, %A_ScriptDir%\HK4WIN_SET_OLD.ini, UserSetting, AutoShutdownTime
			If (temp0<>"ERROR")
			IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,AutoShutdownTime

			IniRead, temp0, %A_ScriptDir%\HK4WIN_SET_OLD.ini, UserSetting, WheelList
			If (temp0<>"ERROR")
			IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,WheelList
			
			IniRead, temp0, %A_ScriptDir%\HK4WIN_SET_OLD.ini, UserSetting, WheelSpeed
			If (temp0<>"ERROR")
			IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,WheelSpeed
			
			IniRead, temp0, %A_ScriptDir%\HK4WIN_SET_OLD.ini, UserSetting, AutoIME
			If (temp0<>"ERROR")
			IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,AutoIME
			
			IniRead, temp0, %A_ScriptDir%\HK4WIN_SET_OLD.ini, UserSetting, AutoImeList
			If (temp0<>"ERROR")
			IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,AutoImeList
			
			
			IniRead, temp0, %A_ScriptDir%\HK4WIN_SET_OLD.ini, UserSetting, TransparentList
			If (temp0<>"ERROR")
			IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,TransparentList
			
			IniRead, temp0, %A_ScriptDir%\HK4WIN_SET_OLD.ini, UserSetting, TransparentValue
			If (temp0<>"ERROR")
			IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,TransparentValue

			IniRead, temp0, %A_ScriptDir%\HK4WIN_SET_OLD.ini, UserSetting, SecKill
			If (temp0<>"ERROR")
			{
			If temp0 not contains TXGuiFoundation
				temp0=%temp0%,TXGuiFoundation
			IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,SecKill
			
			}

			IniRead, temp0, %A_ScriptDir%\HK4WIN_SET_OLD.ini, UserSetting, BingWallpaperBackup
			If (temp0<>"ERROR")
			IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,BingWallpaperBackup			
	;IniWrite, "", %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,TransparentList
	;IniWrite, 150, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,TransparentValue
	




			IniRead, temp0, %A_ScriptDir%\HK4WIN_SET_OLD.ini, Gesture, IE_Gesture_Back
			If (temp0<>"ERROR")
			IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, Gesture, IE_Gesture_Back
			
			IniRead, temp0, %A_ScriptDir%\HK4WIN_SET_OLD.ini, Gesture, IE_Gesture_Forward
			If (temp0<>"ERROR")
			IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,IE_Gesture_Forward
			
			IniRead, temp0, %A_ScriptDir%\HK4WIN_SET_OLD.ini, Gesture, IE_Gesture_Refresh
			If (temp0<>"ERROR")
			IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,IE_Gesture_Refresh
			
			IniRead, temp0, %A_ScriptDir%\HK4WIN_SET_OLD.ini, Gesture, IE_Gesture_Stop
			If (temp0<>"ERROR")
			IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, Gesture, IE_Gesture_Stop
			
			IniRead, temp0, %A_ScriptDir%\HK4WIN_SET_OLD.ini, Gesture, IE_Gesture_PreTab
			If (temp0<>"ERROR")
			IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,IE_Gesture_PreTab
			
			IniRead, temp0, %A_ScriptDir%\HK4WIN_SET_OLD.ini, Gesture, IE_Gesture_NextTab
			If (temp0<>"ERROR")
			IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,IE_Gesture_NextTab
			
			IniRead, temp0, %A_ScriptDir%\HK4WIN_SET_OLD.ini, Gesture, IE_Gesture_CloseTab
			If (temp0<>"ERROR")
			IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, Gesture, IE_Gesture_CloseTab
			
			IniRead, temp0, %A_ScriptDir%\HK4WIN_SET_OLD.ini, Gesture, IE_Gesture_UndoTab
			If (temp0<>"ERROR")
			IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,IE_Gesture_UndoTab
			
			IniRead, temp0, %A_ScriptDir%\HK4WIN_SET_OLD.ini, Gesture, IE_Gesture_NewTab
			If (temp0<>"ERROR")
			IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,IE_Gesture_NewTab
			
			IniRead, temp0, %A_ScriptDir%\HK4WIN_SET_OLD.ini, Gesture, IE_Gesture_PageHome
			If (temp0<>"ERROR")
			IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, Gesture, IE_Gesture_PageHome
			
			IniRead, temp0, %A_ScriptDir%\HK4WIN_SET_OLD.ini, Gesture, IE_Gesture_PageEnd
			If (temp0<>"ERROR")
			IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,IE_Gesture_PageEnd
			
			IniRead, temp0, %A_ScriptDir%\HK4WIN_SET_OLD.ini, Gesture, Ex_Gesture_Copy
			If (temp0<>"ERROR")
			IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,Ex_Gesture_Copy
			
			IniRead, temp0, %A_ScriptDir%\HK4WIN_SET_OLD.ini, Gesture, Ex_Gesture_Paste
			If (temp0<>"ERROR")
			IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,Ex_Gesture_Paste
			
			IniRead, temp0, %A_ScriptDir%\HK4WIN_SET_OLD.ini, Gesture, Ex_Gesture_Cute
			If (temp0<>"ERROR")
			IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,	Ex_Gesture_Cute
			
			IniRead, temp0, %A_ScriptDir%\HK4WIN_SET_OLD.ini, Gesture,Ex_Gesture_Del
			If (temp0<>"ERROR")
			IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,Ex_Gesture_Del
			
			IniRead, temp0, %A_ScriptDir%\HK4WIN_SET_OLD.ini, Gesture, Ex_Gesture_DelInst
			If (temp0<>"ERROR")
			IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,Ex_Gesture_DelInst
			
			IniRead, temp0, %A_ScriptDir%\HK4WIN_SET_OLD.ini, Gesture, Ex_Gesture_Pro
			If (temp0<>"ERROR")
			IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,Ex_Gesture_Pro
			
			IniRead, temp0, %A_ScriptDir%\HK4WIN_SET_OLD.ini, Gesture, Ex_Gesture_Back
			If (temp0<>"ERROR")
			IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,	Ex_Gesture_Back
			
			IniRead, temp0, %A_ScriptDir%\HK4WIN_SET_OLD.ini, Gesture, Ex_Gesture_Fwd
			If (temp0<>"ERROR")
			IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,Ex_Gesture_Fwd
			
			IniRead, temp0, %A_ScriptDir%\HK4WIN_SET_OLD.ini, Gesture,Ex_Gesture_Upper
			If (temp0<>"ERROR")
			IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,	Ex_Gesture_Upper
			
			IniRead, temp0, %A_ScriptDir%\HK4WIN_SET_OLD.ini, Gesture, Ex_Gesture_Close
			If (temp0<>"ERROR")
			IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,Ex_Gesture_Close
			
			IniRead, temp0, %A_ScriptDir%\HK4WIN_SET_OLD.ini, Gesture,Ex_Gesture_Undo
			If (temp0<>"ERROR")
			IniWrite, %temp0%, %A_ScriptDir%\HK4WIN_SET.ini, Gesture,Ex_Gesture_Undo





	;IniWrite, UNAVAILABLE, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0216
	;IniWrite, UNAVAILABLE, %A_ScriptDir%\HK4WIN_SET.ini, FnSwitch, Fn0217
	IniWrite, 3, %A_ScriptDir%\HK4WIN_SET.ini, ScriptSetting,LU_Alarm
;msgbox,ReBuildIni END
	;@@@@@@@@@@@@@@@@@@@@恢复用户配置信息结束
			IfExist,%A_ScriptDir%\OlderVersion\%IniCreatedByMain%.%IniCreatedBySub%\HK4WIN.exe
			{
			FileMove,%A_ScriptDir%\HK4WIN_SET_OLD.ini,%A_ScriptDir%\OlderVersion\%IniCreatedByMain%.%IniCreatedBySub%\HK4WIN_SET.ini
			}
			else
			{
				FileDelete, %A_ScriptDir%\HK4WIN_SET_OLD.ini
			}
	}
}
else
{
return
}
return


ShutdownTimerDown: 
IfWinNotExist, HK4WIN 即将强制关机！！！
    return  ; Keep waiting.
NumInp -= 1
WinActivate 
ControlSetText, Button1, 中止自动关机
ControlSetText, Static2,  　　%NumInp% 秒后自动关机
return


ChangeButtonNames_GPL:
IfWinNotExist, HK4WIN [ %HK4WIN_ver_build% ]
    return  ; Keep waiting.
SetTimer, ChangeButtonNames_GPL, off 
WinActivate 
ControlSetText, Button1, 　我同意　
ControlSetText, Button2, 不同意

return


GetInfoUnderMouse:
{
MouseGetPos,x,y,MouseID,MouseControl
WinGetClass,MouseClass,ahk_id %MouseID%
WinGetClass,ActClass,A
WinGet,ActID,ID,A
controlget,childHWND,Hwnd,,%MouseControl%,ahk_id %MouseID%
WinGetTitle, CurWinTitle,A
;tooltip,MouseClass=%MouseClass% / ActClass=%ActClass%
;sleep,5000
;msgbox,MouseClass=%MouseClass% / ActClass=%ActClass%
}
return



$<^>!>^#c::
send,^c
	WinGet, Last_Clip_Id, ID, A
	if (ClipMemo1 = "0")
		ClipMemo1=%ClipboardAll%
	else if(ClipMemo2 = "0")
		{
		ClipMemo2=%ClipMemo1%
		ClipMemo1=%ClipboardAll%
		}
	else
		{
		ClipMemo3=%ClipMemo2%
		ClipMemo2=%ClipMemo1%
		ClipMemo1=%ClipboardAll%	
		}
		;msgbox,,,%ClipMemo1%---%ClipMemo2%---%ClipMemo3%,1
return

$<^>!>^#v::

if (ClipMemo1 = "0")
	{
	send,^v
	}
else if (ClipMemo2 = "0")
	{
	Clipboard=%ClipMemo1%
	send,^v
	ClipMemo1=0
	}
else if (ClipMemo3 = "0")
	{
	Clipboard=%ClipMemo1%
	send,^v
	ClipMemo1=%ClipMemo2%
	ClipMemo2=0
	}
else
	{
	Clipboard=%ClipMemo1%
	send,^v
	ClipMemo1=%ClipMemo2%
	ClipMemo2=%ClipMemo3%
	ClipMemo3=0
	}
	;msgbox,,,%ClipMemo1%---%ClipMemo2%---%ClipMemo3%,1
return


IsGaming()
{

			If  WinActive("ahk_class CabinetWClass") or WinActive("ahk_class Progman")or WinActive("ahk_class WorkerW") or WinActive("ahk_class #32770")
			{
					Gaming="0"
					return 0
			}
			else
			{
				WinGetPos , X, Y, Width, Height, A
				SysGet, MonFull, Monitor
				If(X=0)&&(Y=0)&&(Width=MonFullRight)&&(Height=MonFullBottom)
				{
					Gaming="1"
					return 1
				}
				else
				{
					Gaming="0"
					return 0
				}
			}
}

Donate_HK4WIN:
{
If(IsGaming()="0")
	run,www.songruihua.com/hk4win-donate
else
	settimer,Donate_HK4WIN,-900000
}
return


RunHK4WINAsAdmin()
{
	global
	local params, uacrep
	Loop %0%
		params .= " " (InStr(%A_Index%, " ") ? """" %A_Index% """" : %A_Index%)
	If(A_IsCompiled)
		uacrep := DllCall("shell32\ShellExecute", uint, 0, str, "RunAs", str, A_ScriptFullPath, str, "/r" params, str, A_WorkingDir, int, 1)
	else
		uacrep := DllCall("shell32\ShellExecute", uint, 0, str, "RunAs", str, A_AhkPath, str, "/r """ A_ScriptFullPath """" params, str, A_WorkingDir, int, 1)
	If(uacrep = 42) ;UAC Prompt confirmed, application may run as admin
		ExitApp
	else
		MsgBox HK4WIN未能获取管理员权限，这可能导致部分功能无法运行。
}






Item_2:
send,#e
return

Item_1:
IfExist, %FD2beOpened%:\
	Run %FD2beOpened%:\
else
{
DriveGet, OpenFDs222, List , REMOVABLE
StringRight, OpenFDs222, OpenFDs222, 1

IfExist, %OpenFDs222%:\
	Run %OpenFDs222%:\
}


return


ShowCustomMenu:
{
	If(IsGaming()=1)
	{
	;Click,Down,M
	tooltip,aa1
	sleep,500
	return
	
	}
	tooltip,aa2
	sleep,500
GoSub,INI
tooltip,aa3
sleep,500
Menu, custom_menu, add, Hello, Item1 ;create a dummy menu item
Menu, custom_menu, DeleteAll
tooltip,aa4
sleep,500


flag=0
IfExist, %FD2beOpened%:\
	flag=1
else
{
DriveGet, OpenFDs222, List , REMOVABLE
StringRight, OpenFDs222, OpenFDs222, 1

IfExist, %OpenFDs222%:\
	flag=1
}
If(flag=1)
Menu, custom_menu, add, 新插入的可移动设备, Item_1

tooltip,aa5
sleep,500
Menu, custom_menu, add, 文件资源管理器, Item_2
tooltip,aa6
sleep,500
If(Name1 = "Divider" and Location1 = "Divider")
{
Menu, custom_menu, add,
}
else
{
If(Name1 <> "" and Location1 <> "")
{
Menu, custom_menu, add, %Name1%, Item1

}
}



If(Name2 = "Divider" and Location2 = "Divider")
{
Menu, custom_menu, add,
}
else
{
If(Name2 <> "" and Location2 <> "")
{
Menu, custom_menu, add, %Name2%, Item2
}
}



If(Name3 = "Divider" and Location3 = "Divider")
{
Menu, custom_menu, add,
}
else
{
If(Name3 <> "" and Location3 <> "")
{
Menu, custom_menu, add, %Name3%, Item3
}
}



If(Name4 = "Divider" and Location4 = "Divider")
{
Menu, custom_menu, add,
}
else
{
If(Name4 <> "" and Location4 <> "")
{
Menu, custom_menu, add, %Name4%, Item4
}
}



If(Name5 = "Divider" and Location5 = "Divider")
{
Menu, custom_menu, add,
}
else
{
If(Name5 <> "" and Location5 <> "")
{
Menu, custom_menu, add, %Name5%, Item5
}
}





If(Name6 = "Divider" and Location6 = "Divider")
{
Menu, custom_menu, add,
}
else
{
If(Name6 <> "" and Location6 <> "") 
{
Menu, custom_menu, add, %Name6%, Item6
}
}



If(Name7 = "Divider" and Location7 = "Divider")
{
Menu, custom_menu, add,
}
else
{
If(Name7 <> "" and Location7 <> "") 
{
Menu, custom_menu, add, %Name7%, Item7
}
}

If(Name8 = "Divider" and Location8 = "Divider")
{
Menu, custom_menu, add,
}
else
{
If(Name8 <> "" and Location8 <> "") 
{
Menu, custom_menu, add, %Name8%, Item8
}
}


If(Name9 = "Divider" and Location9 = "Divider")
{
Menu, custom_menu, add,
}
else
{
If(Name9 <> "" and Location9 <> "") 
{
Menu, custom_menu, add, %Name9%, Item9
}
}


If(Name10 = "Divider" and Location10 = "Divider")
{
Menu, custom_menu, add,
}
else
{
If(Name10 <> "" and Location10 <> "") 
{
Menu, custom_menu, add, %Name10%, Item10
}
}


If(Name11 = "Divider" and Location11 = "Divider")
{
Menu, custom_menu, add,
}
else
{
If(Name11 <> "" and Location11 <> "") 
{
Menu, custom_menu, add, %Name11%, Item11

}
}



If(Name12 = "Divider" and Location12 = "Divider")
{
Menu, custom_menu, add,
}
else
{
If(Name12 <> "" and Location12 <> "") 
{
Menu, custom_menu, add, %Name12%, Item12

}
}



If(Name13 = "Divider" and Location13 = "Divider")
{
Menu, custom_menu, add,
}
else
{
If(Name13 <> "" and Location13 <> "") 
{
Menu, custom_menu, add, %Name13%, Item13
}
}





If(Name14 = "Divider" and Location14 = "Divider")
{
Menu, custom_menu, add,
}
else
{
If(Name14 <> "" and Location14 <> "") 
{
Menu, custom_menu, add, %Name14%, Item14
}
}



If(Name15 = "Divider" and Location15 = "Divider")
{
Menu, custom_menu, add,
}
else
{
If(Name15 <> "" and Location15 <> "") 
{
Menu, custom_menu, add, %Name15%, Item15
}
}


If(Name16 = "Divider" and Location16 = "Divider")
{
Menu, custom_menu, add,
}
else
{
If(Name16 <> "" and Location16 <> "") 
{
Menu, custom_menu, add, %Name16%, Item16
}
}



If(Name17 = "Divider" and Location17 = "Divider")
{
Menu, custom_menu, add,
}
else
{
	If(Name17 <> "" and Location17 <> "") 
	{
	Menu, custom_menu, add, %Name17%, Item17
	}
}



If(Name18 = "Divider" and Location18 = "Divider")
{
Menu, custom_menu, add,
}
else
{
If(Name18 <> "" and Location18 <> "") 
{
Menu, custom_menu, add, %Name18%, Item18
}
}


If(Name19 = "Divider" and Location19 = "Divider")
{
Menu, custom_menu, add,
}
else
{
If(Name19 <> "" and Location19 <> "") 
{
Menu, custom_menu, add, %Name19%, Item19
}
}




If(Name20 = "Divider" and Location20 = "Divider")
{
Menu, custom_menu, add,
}
else
{
If(Name20 <> "" and Location20 <> "") 
{
Menu, custom_menu, add, %Name20%, Item20
}
}


tooltip,aa7
sleep,500

Menu, custom_menu, add,

Menu, custom_menu, add, 配置, CustomMenuSetting
Menu, custom_menu, add, 取消, CustomMenuCancel
GoSub,CustomMenuIcons
Menu, custom_menu, show



tooltip,aa8
sleep,500




return

}





CustomMenuIcons:
If(A_OSVersion="WIN_7")
{
Icon_Computer=105
Icon_Folder=5
Icon_Drive=28
Icon_DriveRemovable=31
Icon_DriveSys=32
Icon_Setting=110
Icon_Cancel=219
Icon_DLL=%A_WinDir%\System32\imageres.dll
}
else If(A_OSVersion="WIN_8")
{
Icon_Computer=105
Icon_Folder=5
Icon_Drive=28
Icon_DriveRemovable=31
Icon_DriveSys=32
Icon_Setting=110
Icon_Cancel=219
Icon_DLL=%A_WinDir%\System32\imageres.dll
}
else If(A_OSVersion="WIN_XP")
{
Icon_Computer=16
Icon_Folder=4
Icon_Drive=8
Icon_DriveRemovable=8
Icon_DriveSys=8
Icon_Setting=166
Icon_Cancel=110
Icon_DLL=%A_WinDir%\System32\shell32.dll
}
else
{
Icon_Computer=0
Icon_Folder=0
Icon_Drive=0
Icon_DriveSys=0
}
If(flag=1)
Menu, custom_menu, Icon, 新插入的可移动设备, %Icon_DLL%,%Icon_DriveRemovable%

Menu, custom_menu, Icon, 文件资源管理器, %Icon_DLL%,%Icon_Computer%

Menu, custom_menu, Icon, 配置, %Icon_DLL%,%Icon_Setting%
Menu, custom_menu, Icon, 取消, %Icon_DLL%,%Icon_Cancel%
RowNumber = 1
Loop
{


		;Name%RowNumber%:=Name
		;Location%RowNumber%:=Location

		



Location:=Location%RowNumber%
Name:=Name%RowNumber%
StringLeft, LocationLeft4, Location, 4
StringRight, LocationRight4, Location, 4
StringLeft, LocationRight4Left1, LocationRight4, 1
IfInString, Location, \
	IsFolder=1
else
    IsFolder=0


;msgbox,%Location%======%LocationRight4Left1%
If(Location="D:\" or Location="E:\" or Location="F:\" or Location="G:\" or Location="H:\" or Location="I:\" or Location="J:\" or Location="K:\" or Location="L:\" or Location="M:\" or Location="N:\")
	Menu, custom_menu, Icon, %Name%, %Icon_DLL%,%Icon_Drive%
else If(Location="C:\")
	Menu, custom_menu, Icon, %Name%, %Icon_DLL%,%Icon_DriveSys%
else If(LocationLeft4="http")
	Menu, custom_menu, Icon, %Name%, %A_ProgramFiles%\Internet Explorer\iexplore.exe,4
else If(LocationRight4=".exe")
	Menu, custom_menu, Icon, %Name%, %Location%
else If(LocationRight4Left1=".")
	Menu, custom_menu, Icon, %Name%
else If(IsFolder="1")
	Menu, custom_menu, Icon, %Name%, %Icon_DLL%,%Icon_Folder%
	
	
RowNumber ++ 1
If (RowNumber = 21)
break
	
}
return



ITEM1:
Run, %Location1%
return

ITEM2: 
Run, %Location2%
return

ITEM3: 
Run, %Location3%
return

ITEM4: 
Run, %Location4%
return

ITEM5: 
Run, %Location5%
return

ITEM6: 
Run, %Location6%
return

ITEM7: 
Run, %Location7%
return

ITEM8: 
Run, %Location8%
return

ITEM9: 
Run, %Location9%
return

ITEM10: 
Run, %Location10%
return

ITEM11: 
Run, %Location11%
return

ITEM12: 
Run, %Location12%
return

ITEM13: 
Run, %Location13%
return

ITEM14: 
Run, %Location14%
return

ITEM15: 
Run, %Location15%
return

ITEM16: 
Run, %Location16%
return

ITEM17: 
Run, %Location17%
return

ITEM18: 
Run, %Location18%
return

ITEM19: 
Run, %Location19%
return

ITEM20: 
Run, %Location20%
return

CustomMenuCancel:
Menu, custom_menu, DeleteAll
return



INI:
{



tooltip,ini start
sleep,3000
IniRead, LineText, HK4WIN_SET.ini, CustomMenu, 1
			Location = ""
			Name = ""
			StringSplit,Col,LineText,`,
			Name:=Col1
			Location:=Col2
			if(Location <> "" and Name <> "")
			{
				Name1:=Name
				Location1:=Location
			}
IniRead, LineText, HK4WIN_SET.ini, CustomMenu, 2
			Location = ""
			Name = ""
			StringSplit,Col,LineText,`,
			Name:=Col1
			Location:=Col2
			if(Location <> "" and Name <> "")
			{
				Name2:=Name
				Location2:=Location
			}
IniRead, LineText, HK4WIN_SET.ini, CustomMenu, 3
			Location = ""
			Name = ""
			StringSplit,Col,LineText,`,
			Name3:=Col1
			Location3:=Col2
			if(Location <> "" and Name <> "")
			{
				Name:=Name
				Location:=Location
			}
IniRead, LineText, HK4WIN_SET.ini, CustomMenu, 4
			Location = ""
			Name = ""
			StringSplit,Col,LineText,`,
			Name4:=Col1
			Location4:=Col2
			if(Location <> "" and Name <> "")
			{
				Name:=Name
				Location:=Location
			}
IniRead, LineText, HK4WIN_SET.ini, CustomMenu, 5
			Location = ""
			Name = ""
			StringSplit,Col,LineText,`,
			Name5:=Col1
			Location5:=Col2
			if(Location <> "" and Name <> "")
			{
				Name:=Name
				Location:=Location
			}
IniRead, LineText, HK4WIN_SET.ini, CustomMenu, 6
			Location = ""
			Name = ""
			StringSplit,Col,LineText,`,
			Name:=Col1
			Location:=Col2
			if(Location <> "" and Name <> "")
			{
				Name6:=Name
				Location6:=Location
			}
IniRead, LineText, HK4WIN_SET.ini, CustomMenu, 7
			Location = ""
			Name = ""
			StringSplit,Col,LineText,`,
			Name:=Col1
			Location:=Col2
			if(Location <> "" and Name <> "")
			{
				Name7:=Name
				Location7:=Location
			}
IniRead, LineText, HK4WIN_SET.ini, CustomMenu, 8
			Location = ""
			Name = ""
			StringSplit,Col,LineText,`,
			Name:=Col1
			Location:=Col2
			if(Location <> "" and Name <> "")
			{
				Name8:=Name
				Location8:=Location
			}
IniRead, LineText, HK4WIN_SET.ini, CustomMenu, 9
			Location = ""
			Name = ""
			StringSplit,Col,LineText,`,
			Name:=Col1
			Location:=Col2
			if(Location <> "" and Name <> "")
			{
				Name9:=Name
				Location9:=Location
			}
IniRead, LineText, HK4WIN_SET.ini, CustomMenu, 10
			Location = ""
			Name = ""
			StringSplit,Col,LineText,`,
			Name:=Col1
			Location:=Col2
			if(Location <> "" and Name <> "")
			{
				Name10:=Name
				Location10:=Location
			}
IniRead, LineText, HK4WIN_SET.ini, CustomMenu, 11
			Location = ""
			Name = ""
			StringSplit,Col,LineText,`,
			Name:=Col1
			Location:=Col2
			if(Location <> "" and Name <> "")
			{
				Name11:=Name
				Location11:=Location
			}
IniRead, LineText, HK4WIN_SET.ini, CustomMenu, 12
			Location = ""
			Name = ""
			StringSplit,Col,LineText,`,
			Name:=Col1
			Location:=Col2
			if(Location <> "" and Name <> "")
			{
				Name12:=Name
				Location12:=Location
			}
IniRead, LineText, HK4WIN_SET.ini, CustomMenu, 13
			Location = ""
			Name = ""
			StringSplit,Col,LineText,`,
			Name:=Col1
			Location:=Col2
			if(Location <> "" and Name <> "")
			{
				Name13:=Name
				Location13:=Location
			}
IniRead, LineText, HK4WIN_SET.ini, CustomMenu, 14
			Location = ""
			Name = ""
			StringSplit,Col,LineText,`,
			Name:=Col1
			Location:=Col2
			if(Location <> "" and Name <> "")
			{
				Name14:=Name
				Location14:=Location
			}
IniRead, LineText, HK4WIN_SET.ini, CustomMenu, 15
			Location = ""
			Name = ""
			StringSplit,Col,LineText,`,
			Name:=Col1
			Location:=Col2
			if(Location <> "" and Name <> "")
			{
				Name15:=Name
				Location15:=Location
			}
IniRead, LineText, HK4WIN_SET.ini, CustomMenu, 16
			Location = ""
			Name = ""
			StringSplit,Col,LineText,`,
			Name:=Col1
			Location:=Col2
			if(Location <> "" and Name <> "")
			{
				Name16:=Name
				Location16:=Location
			}
IniRead, LineText, HK4WIN_SET.ini, CustomMenu, 17
			Location = ""
			Name = ""
			StringSplit,Col,LineText,`,
			Name:=Col1
			Location:=Col2
			if(Location <> "" and Name <> "")
			{
				Name17:=Name
				Location17:=Location
			}
IniRead, LineText, HK4WIN_SET.ini, CustomMenu,18 
			Location = ""
			Name = ""
			StringSplit,Col,LineText,`,
			Name:=Col1
			Location:=Col2
			if(Location <> "" and Name <> "")
			{
				Name18:=Name
				Location18:=Location
			}
IniRead, LineText, HK4WIN_SET.ini, CustomMenu, 19
			Location = ""
			Name = ""
			StringSplit,Col,LineText,`,
			Name:=Col1
			Location:=Col2
			if(Location <> "" and Name <> "")
			{
				Name19:=Name
				Location19:=Location
			}
IniRead, LineText, HK4WIN_SET.ini, CustomMenu, 20
			Location = ""
			Name = ""
			StringSplit,Col,LineText,`,
			Name:=Col1
			Location:=Col2
			if(Location <> "" and Name <> "")
			{
				Name20:=Name
				Location20:=Location
			}












tooltip,ini end
sleep,3000
	return


}

CustomMenuSetting:
GoSub, INI
Gui, 1: Destroy
Gui, 1: Font, s12 bold , 微软雅黑
Gui, 1: Add, Text,,请输入快捷菜单项目的名称和路径。
Gui, 1: Font, s12 norm, 微软雅黑
Gui, 1: Add, ListView,AltSubmit -Multi h100 w530 vListView gEDITSETTINGS,名称|路径

RowNumber = 1
Loop
{
IniRead, LineText, HK4WIN_SET.ini, CustomMenu, %RowNumber%
If LineText=Error
{
break
}
else
{
StringSplit,Col,LineText,`,
Name:=Col1
Location:=Col2
LV_Add("",Name,Location)
RowNumber ++ 1
}
}
LV_ModifyCol(1, "AutoHdr")
LV_ModifyCol(2, 375)
LV_Modify(1, "Select Focus")

If LV_GetCount() = 0
{
LV_Add("","","")
}


Gui, 1: Font, s12 bold, 微软雅黑
Gui, 1: Add, Text,x18 y150,名称:
Gui, 1: Font, s12 norm, 微软雅黑
Gui, 1: Add, Edit, w150 vName gEDITED
Gui, 1: Font, s12 bold, 微软雅黑
Gui, 1: Add, Text,x188 y150,路径:
Gui, 1: Font, s12 norm, 微软雅黑
Gui, 1: Add, Edit, w150 vLocation gEDITED
Gui, 1: Font, s10 norm, 微软雅黑
Gui, 1: Add, Button, x235 y150 w43 h23 gFindLoc, 文件
Gui, 1: Add, Button, x280 y150 w58 h23 gFindLoc2, 文件夹
Gui, 1: Font, s12 norm, 微软雅黑
Gui, 1: Add, Button, w80 x375 y182 h28 gNEWSHORTCUT, 插入
Gui, 1: Add, Button, w80 x465 y182 h28 gDELETESHORTCUT, 删除
Gui, 1: Add, Button, w150 x18 y220 h28 gSAVESETTINGS, 确认
Gui, 1: Add, Button, w150 x188 y220 h28 gCANCELSETTINGS, 取消
Gui, 1: Show,, HK4WIN 快捷菜单设置

RowNumber := LV_GetNext(0, S)
If RowNumber <> 0
{
LV_GetText(Name,RowNumber,1)
LV_GetText(Location,RowNumber,2)
GuiControl,,Name, %Name%
GuiControl,,Location, %Location%
}
return


FindLoc:
Gui +OwnDialogs
FileSelectFile, FindLoc , , %ProgramFiles%, 请指定快捷菜单路径（文件）, *.exe; *.bat; *.com; *.vbs
If(FindLoc<>"")
	GuiControl,,Location, %FindLoc%
Return

FindLoc2:
Gui +OwnDialogs
FileSelectFolder, FindLoc2 , ::{20d04fe0-3aea-1069-a2d8-08002b30309d}, 1, 请指定快捷菜单路径（文件夹）
If(FindLoc2<>"")
	GuiControl,,Location, %FindLoc2%
Return



EDITSETTINGS:
if (A_GuiEvent = "Normal" or A_GuiEvent = "K")
{
RowNumber := LV_GetNext(0, S)
if (RowNumber <> 0)
{
LV_GetText(Name,RowNumber,1)
LV_GetText(Location,RowNumber,2)
GuiControl,,Name, %Name%
GuiControl,,Location, %Location%
}
}
return

EDITED:
Gui, 1: Submit, NoHide
LV_Modify(RowNumber, "", Name, Location)
return

NEWSHORTCUT:
RowNumber := LV_GetNext(0) + 1
TotalRows := LV_GetCount()
If TotalRows <20
{
LV_Insert(RowNumber,"Select","","")
LV_Modify(RowNumber, "Vis Select Focus")
GuiControl,,Name,
GuiControl,,Location,
GuiControl, Focus, Name
}
else
{
Msgbox,,Keyboard Menu,最多只能设置20个快捷菜单项.
LV_Modify(RowNumber-1, "Select Focus")
GuiControl, Focus, ListView
If RowNumber<>1
{
Send,{Up}{Down}
}
else
{
Send,{Down}{Up}
}
GuiControl, Focus, Name
}
return

DELETESHORTCUT:
RowNumber := LV_GetNext(0)
LV_Delete(RowNumber)
If RowNumber<>1
{
RowNumber -- 1
}
LV_Modify(RowNumber, "Select Focus")
GuiControl, Focus, ListView
If RowNumber<>1
{
Send,{Up}{Down}
}
else
{
Send,{Down}{Up}
}
GuiControl, Focus, Name
return

SAVESETTINGS:

RowNumber = 1
Loop % LV_GetCount()
{
LV_GetText(Name, RowNumber, 1)
LV_GetText(Location, RowNumber, 2)
StringLeft, LocLeft4, Location, 4
	If(LocLeft4!="http")
	{
		IfExist, %Location%
			LocCheck=1
		else
		{
			StringSplit, Location, Location, /
			IfExist, %Location1%
				LocCheck=1
			else
			{
				StringSplit, Location, Location, -
				IfExist, %Location1%
					LocCheck=1
				else
					LocCheck=0 
			}
			
		}
			
	}
	else
	{
		LocCheck=1
	}
			If(LocCheck="1")
			IniWrite,%Name%`,%Location%,HK4WIN_SET.ini,CustomMenu,%RowNumber%
			else
			{
			MsgBox, 262160, HK4WIN 错误,第%RowNumber%行有误，请检查！`n`n名称：%Name%`n路径：%Location%,10
			return
			}
RowNumber ++ 1
}
Loop
{
if RowNumber>20
{
break
}
else
{
IniDelete,HK4WIN_SET.ini,CustomMenu,%RowNumber%
RowNumber ++ 1
}
}
Gui, 1: Destroy
GoSub,INI
return






CANCELSETTINGS:
Gui, 1: Destroy
return


OpenNewFlashDisk:
{
DriveGet, OpenFDs, List , REMOVABLE
StringLen, OpenFDs_Len, OpenFDs
If(OpenFDsOLDer_Len<OpenFDs_Len)
{
	;tooltip,OpenFDsOLDer_Len==%OpenFDsOLDer_Len%////OpenFDs_Len==%OpenFDs_Len%
	;sleep,1000
;tooltip
;	StringRight, OpenFDs1, OpenFDs, 1




FDID = 0
Loop
{
;msgbox,FDID==%FDID%///OpenFDsOLDer_Len==%OpenFDsOLDer_Len%///FDname==%FDname%


	If (FDID=OpenFDsOLDer_Len)
	{
	FD2beOpened=%OpenFDs%
	break
	}
	else
	{
	FDID ++ 1
		StringMid, FDname, OpenFDsOLDer, %FDID%, 1
		
		FD%FDID%:=FDname
;msgbox,))))))))))))))OpenFDs====%OpenFDs%
		StringReplace, OpenFDs, OpenFDs, %FDname%
;msgbox,))))))))))))OpenFDs==%OpenFDs%
FD2beOpened=%OpenFDs%
		
		
	}
}


IfNotExist, %FD2beOpened%:\
return










	
	DriveGet,  OpenFDs1_LABEL, label,%OpenFDs%:
		If(OpenFDs1_LABEL<>"")
		{
			OpenFDs1_LABEL2=%OpenFDs1_LABEL%(%OpenFDs%:)
		}
		else
		{
			OpenFDs1_LABEL2=%OpenFDs%:
		}
			
	NewNewFlashDiskReadyToOpen=1
	PlayWav("Windows Balloon")
	If(A_IsAdmin)
		TrayTip , %OpenFDs1_LABEL2%,按2下左侧Shift键（或屏幕右边缘按滚轮）打开%OpenFDs%:盘`n按2下右侧Shift键安全删除所有可移动设备, 8, 1
	else
		TrayTip , %OpenFDs1_LABEL2%,按2下左侧Shift键（或屏幕右边缘按滚轮）打开%OpenFDs%:盘, 8, 1

}
else
{
;NewNewFlashDiskReadyToOpen=0
}
OpenFDsOLDer_Len=%OpenFDs_Len%
OpenFDsOLDer=%OpenFDs%




;tooltip,spacespace/////NewNewFlashDiskReadyToOpen===%NewNewFlashDiskReadyToOpen%
;sleep,1000
;tooltip
return
}
#If (FnSwitch(0345)=1)
~RShift::
Keywait, Shift, , t0.2
if ((errorlevel="1"))
{

return

}
else
Keywait, Shift, d, t0.2
if errorlevel = 0
{
GoSub,SafelyRemoveAll
;;;;;;;;;;;;;;;;;;;;NewNewFlashDiskReadyToOpen=0

}
else
{
;send,{Space}
}
return
return
#If
;end of 0345

#If (FnSwitch(0343)=1)
~LShift::
Keywait, Shift, , t0.2
if ((errorlevel="1"))
{

return

}
else
Keywait, Shift, d, t0.2
if errorlevel = 0
{

GoSub,DoOpenNewFD
}


return
#If
;;;;;The end #IF tag of FnSwitch 0216

DoOpenNewFD:
{



;tooltip,spacespace
;sleep,200
;tooltip
;MsgBox , 262180, HK4WIN 发现新设备, 是否打开 %OpenFDs1_LABEL2%, 10
;msgbox,))))))检查存在后运行))))))OpenFDs==%OpenFDs%\\\\FD2beOpened=%FD2beOpened%
IfExist, %FD2beOpened%:\
	{
	PlayWav("ir_begin")
	Run %FD2beOpened%:\
	}
else
{
DriveGet, OpenFDs222, List , REMOVABLE
StringRight, OpenFDs222, OpenFDs222, 1

IfExist, %OpenFDs222%:\
	{
	PlayWav("ir_begin")
	Run %OpenFDs222%:\	
	}
}
	
;;;;;;;;;;;;;;;;;;;;;NewNewFlashDiskReadyToOpen=0
TrayTip

}


NewFlashDiskReadyToOpen()
{
If(NewNewFlashDiskReadyToOpen=1)
	return 1
else
	return 0
}




ToggleRunAsAdmin:
;Menu, Tray, ToggleCheck, 以管理员身份运行
;CheckmarkToggle("以管理员身份运行", "Tray")
If (以管理员身份运行Flag)
  {
	IniWrite, 1, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,RunAsAdmin
  }
else
  {
	IniWrite, 0, %A_ScriptDir%\HK4WIN_SET.ini, UserSetting,RunAsAdmin
  }
return

CheckmarkToggle(MenuItem, MenuName){
    global
    %MenuItem%Flag := !%MenuItem%Flag ; Toggles the variable every time the function is called
    If (%MenuItem%Flag)
        Menu, %MenuName%, Check, %MenuItem%
    else
        Menu, %MenuName%, UnCheck, %MenuItem%
}










;===========================新版 安全删除硬件 开始==================
SafelyRemoveAll:
{
If(!A_IsAdmin)
	{
	PlayWav("Windows Error")
	TrayTip , 在非管理员权限模式下HK4WIN无法完成当前操作, ,10,1
	return
	}


DriveGet, RemoveFDs, List , REMOVABLE
If(RemoveFDs="")
return
;StringLen, OpenFDs_Len, OpenFDs
	IfInString, RemoveFDs, H
		SafelyRemoveUMS( "H:")

	IfInString, RemoveFDs, I
	SafelyRemoveUMS( "I:")
	
	IfInString, RemoveFDs, J
	SafelyRemoveUMS( "J:")
	
	IfInString, RemoveFDs, G
	SafelyRemoveUMS( "G:")
	
	IfInString, RemoveFDs, F
	SafelyRemoveUMS( "F:")
	
	IfInString, RemoveFDs, E
	SafelyRemoveUMS( "E:")
	
	IfInString, RemoveFDs, D
	SafelyRemoveUMS( "D:")
	
	
	IfInString, RemoveFDs, K
	SafelyRemoveUMS( "K:")
	
	IfInString, RemoveFDs, L
	SafelyRemoveUMS( "L:")
	
	IfInString, RemoveFDs, M
	SafelyRemoveUMS( "M:")
	
	IfInString, RemoveFDs, A
	SafelyRemoveUMS( "A:")
	
	IfInString, RemoveFDs, B
	SafelyRemoveUMS( "B:")
	
	IfInString, RemoveFDs, C
	SafelyRemoveUMS( "C:")
	
	IfInString, RemoveFDs, N
	SafelyRemoveUMS( "N:")
	
	IfInString, RemoveFDs, O
	SafelyRemoveUMS( "O:")
	
	IfInString, RemoveFDs, P
	SafelyRemoveUMS( "P:")
	
	IfInString, RemoveFDs, Q
	SafelyRemoveUMS( "Q:")
	
	IfInString, RemoveFDs, R
	SafelyRemoveUMS( "R:")
	
	IfInString, RemoveFDs, S
	SafelyRemoveUMS( "S:")
	
	IfInString, RemoveFDs, T
	SafelyRemoveUMS( "T:")
	
	IfInString, RemoveFDs, U
	SafelyRemoveUMS( "U:")
	
	IfInString, RemoveFDs, V
	SafelyRemoveUMS( "V:")
	
	IfInString, RemoveFDs, W
	SafelyRemoveUMS( "W:")
	
	IfInString, RemoveFDs, X
	SafelyRemoveUMS( "X:")
	
	IfInString, RemoveFDs, Y
	SafelyRemoveUMS( "Y:")
	
	IfInString, RemoveFDs, Z
	SafelyRemoveUMS( "Z:")
	
AfterRemoveFD_Counter=0
SetTimer,AfterRemoveFD,300

}
return

AfterRemoveFD:
{
If(AfterRemoveFD_Counter=10)
	{
	
	PlayWav("Windows Error")
	TrayTip , 警告：请不要拔出设备,无法安全删除可移动设备。, 10, 1
	AfterRemoveFD_Counter=0
	SetTimer,AfterRemoveFD,Off
	return
	}

DriveGet, RemoveFDs, List , REMOVABLE	
	If(RemoveFDs="")
	{
	PlayWav("Windows Balloon")
	TrayTip , 请拔出设备,已安全删除所有可移动设备。, 5, 1
	AfterRemoveFD_Counter=0
	SetTimer,AfterRemoveFD,Off
	}
	else
	{
	AfterRemoveFD_Counter++1
	}

return
}


SafelyRemoveUMS( DrivePath, Retry=0 ) { ; v1.00 by SKAN,   CD:01-Sep-2012 / LM:09-Sep-2012
;      AutoHotkey Forum Topic :  http://www.autohotkey.com/community/viewtopic.php?t=44873




 hVol  := DllCall( "CreateFile"
                 , Str,  "\\.\" . ( Drive  := SubStr( DrivePath, 1, 1 ) . ":" )
                 , UInt, 0x80000000
                 , UInt, 0x3
                 , UInt, 0
                 , UInt, 0x3
                 , UInt, 0x0
                 , UInt, 0  )


 If ( hvol < 1 )
    Return 0, ErrorLevel := 1             ; Unable to access volume!


 VarSetCapacity( GenBuf, 2080, 0 )        ; General, all-purpose buffer


 pSTORAGE_PROPERTY_QUERY    := &GenBuf                       ;  MSDN  http://bit.ly/SvILmx
 pSTORAGE_DESCRIPTOR_HEADER := &GenBuf + 12                  ;  MSDN  http://bit.ly/O8UNiH
 NumPut( StorageDeviceProperty := 0, pSTORAGE_PROPERTY_QUERY + 0 )


 DllCall( "DeviceIoControl"
        , UInt, hVol
        , UInt, 0x2D1400   ; IOCTL_STORAGE_QUERY_PROPERTY    ;  MSDN: http://bit.ly/OdLos0
        , UInt, pSTORAGE_PROPERTY_QUERY
        , UInt, 12
        , UInt, pSTORAGE_DESCRIPTOR_HEADER ;STORAGE_DEVICE_DESCRIPTOR http://bit.ly/O8UNiH
        , UInt, 1024
        , UIntP, BR
        , UInt, 0 )


 BT := NumGet( pSTORAGE_DESCRIPTOR_HEADER + 28 )   ; STORAGE_BUS_TYPE http://bit.ly/T3qt9C
 If ( BT <> 0x7 )                                  ; BusTypeUsb = 0x7
    Return 0,   DllCall( "CloseHandle", UInt,hVol )
  , ErrorLevel := 2                                ; Drive not USB Mass Storage Device!




 IOCTL_STORAGE_GET_DEVICE_NUMBER := 0x2D1080
 pSTORAGE_DEVICE_NUMBER          := &GenBuf


 DllCall( "DeviceIoControl"
        , UInt,  hVol
        , UInt,  IOCTL_STORAGE_GET_DEVICE_NUMBER   ; MSDN http://bit.ly/Ssuzfm
        , UInt,  0
        , UInt,  0
        , UInt,  pSTORAGE_DEVICE_NUMBER            ; MSDN http://bit.ly/PF17hX
        , UInt,  12
        , UIntP, BR
        , UInt,  0   )


 DllCall( "CloseHandle", UInt,hVol )


 If ( BR = 0 )
    Return 0,  ErrorLevel := 3                     ; Unable to ascertain the Device number


 sDevNum := NumGet( pSTORAGE_DEVICE_NUMBER + 4 )


 GUID_DEVINTERFACE_DISK := "{53F56307-B6BF-11D0-94F2-00A0C91EFB8B}" ; http://bit.ly/TXvGlC
 VarSetCapacity( DiskGUID, 16, 0 )
 NumPut( 0x53F56307,   DiskGUID, 0, "UInt"  )  ,  NumPut( 0xB6BF, DiskGUID, 4, "UShort" )
 NumPut( 0x11D0,       DiskGUID, 6, "UShort")  ,  NumPut( 0xF294, DiskGUID, 8, "UShort" )
 NumPut( 0x1EC9A000,   DiskGUID,10, "UInt"  )  ,  NumPut( 0x8BFB, DiskGUID,14, "UShort" )


 hMod := DllCall( "LoadLibrary", Str,"SetupAPI.dll", UInt )


 hDevInfo := DllCall( "SetupAPI\SetupDiGetClassDevs"                ; http://bit.ly/Pf6vHX
                    . ( A_IsUnicode ? "W" : "A" )
                    , UInt,  &DiskGUID
                    , UInt,  0
                    , UInt,  0
                    , UInt,  0x12  ;  DIGCF_PRESENT := 0x2 | DIGCF_DEVICEINTERFACE := 0x10
                          ,  Int )


 If ( hDevInfo < 1 )
    Return 0,  ErrorLevel := 4                    ; No storage class devices were found!




 pSP_DEVICE_INTERFACE_DATA        :=  &GenBuf + 12             ; MSDN http://bit.ly/PJFcbj
 pSP_DEVICE_INTERFACE_DETAIL_DATA :=  &GenBuf + 40             ; MSDN http://bit.ly/SXr3We
 pSP_DEVINFO_DATA                 :=  &GenBuf + 1040           ; MSDN http://bit.ly/Rgp02c




 NumPut( 28, pSP_DEVICE_INTERFACE_DATA + 0 )
 NumPut( 28, pSP_DEVINFO_DATA + 0 )
 NumPut( 4 + ( A_IsUnicode ? 2 : 1 ), pSP_DEVICE_INTERFACE_DETAIL_DATA + 0 )


 DeviceFound := Instance := DeviceNumber := 0


 While DllCall( "SetupAPI\SetupDiEnumDeviceInterfaces"
              , UInt,  hDevInfo
              , UInt,  0
              , UInt,  &DiskGUID
              , UInt,  Instance
              , UInt,  pSP_DEVICE_INTERFACE_DATA ) {


       Instance ++


       DllCall( "SetupAPI\SetupDiGetDeviceInterfaceDetail"     ; MSDN http://bit.ly/NINIci
            . ( A_IsUnicode ? "W" : "A" )
              , UInt,  hDevInfo
              , UInt,  pSP_DEVICE_INTERFACE_DATA               ; MSDN http://bit.ly/PJFcbj
              , UInt,  0
              , UInt,  0
              , UIntP, nBytes
              , UInt,  pSP_DEVINFO_DATA )                      ; MSDN http://bit.ly/Rgp02c




       DllCall( "SetupAPI\SetupDiGetDeviceInterfaceDetail"     ; MSDN http://bit.ly/NINIci
            . ( A_IsUnicode ? "W" : "A" )
              , UInt,  hDevInfo
              , UInt,  pSP_DEVICE_INTERFACE_DATA               ; MSDN http://bit.ly/PJFcbj
              , UInt,  pSP_DEVICE_INTERFACE_DETAIL_DATA        ; MSDN http://bit.ly/SXr3We
              , UInt,  nBytes
              , UInt,  0
              , UInt,  pSP_DEVINFO_DATA )                      ; MSDN http://bit.ly/Rgp02c


      hVol  := DllCall( "CreateFile"
                      , UInt,  pSP_DEVICE_INTERFACE_DETAIL_DATA + 4
                      , UInt,  0x80000000
                      , UInt,  0x3
                      , UInt,  0
                      , UInt,  0x3
                      , UInt,  0x0
                      , UInt,  0  )


      If ( hVol < 0 )
           Continue


      DllCall( "DeviceIoControl"
             , UInt,  hVol
             , UInt,  IOCTL_STORAGE_GET_DEVICE_NUMBER          ; MSDN http://bit.ly/Ssuzfm
             , UInt,  0
             , UInt,  0
             , UInt,  pSTORAGE_DEVICE_NUMBER                   ; MSDN http://bit.ly/PF17hX
             , UInt,  12
             , UIntP, BR
             , UInt,  0   )


      DllCall( "CloseHandle", UInt,hVol )


      If ( BR = 0   )
           Continue


      tDevNum := NumGet( pSTORAGE_DEVICE_NUMBER + 4 )
      If DeviceFound := ( tDevNum == sDevnum )
         Break
 }


 If ( DeviceFound = 0 )
    Return 0,  ErrorLevel := 5                  ; No matching storage class devices found!


 DllCall( "SetupAPI\SetupDiGetDeviceRegistryProperty"
      . ( A_IsUnicode ? "W" : "A" )
        , UInt, hDevInfo
        , UInt, pSP_DEVINFO_DATA
        , UInt, 12 ; SPDRP_FRIENDLYNAME
        , UInt, 0
        , Str,  GenBuf
        , UInt, 1024
        , UInt, 0 )


 FRIENDLY := GenBuf
 DllCall( "SetupAPI\SetupDiDestroyDeviceInfoList", UInt,hDevInfo )  ; http://bit.ly/TWTmsN


 DllCall( "SetupAPI\CM_Get_Parent"
        , UIntP, hDeviceID
        , UInt,  NumGet( pSP_DEVINFO_DATA + 20 )
        , UInt,  0 )


 If ( hDeviceID = 0 )
    Return 0,  ErrorLevel := 6                  ; Problem IDentifying USB Device!




 DllCall( "SetupAPI\CM_Get_Device_ID"
      . ( A_IsUnicode ? "W" : "A" )
        , UInt,  hDeviceID
        , Str,   GenBuf
        , UInt,  1024
        , UInt,  0 )


 DeviceID := GenBuf
 MAX_PATH := ( A_IsUnicode ? 520 : 260 )


Label_SafelyRemoveUMS:


 Loop 5 {


          DllCall( "SetupAPI\CM_Request_Device_Eject"
               . ( A_IsUnicode ? "W" : "A" )
                 , UInt,  hDeviceID
                 , UIntP, VetoType
                 , Str,   GenBuf
                 , UInt,  MAX_PATH
                 , Int,   0 )


          If ( VetoType = 0 )
             Break


        }


 If ( Retry && VetoType == 6 ) {                ; PNP_VetoOutstandingOpen = 6


   MsgBox, 0x1035 ; MB_SYSTEMMODAL=0x1000 | MB_ICONEXCLAMATION=0x30 | MB_RETRYCANCEL=0x5
         , Safely Remove USB Mass Storage Drive %Drive%
         , Unable to Eject Drive due to Open File Handles!`n`n%FRIENDLY%`n%DeviceID%


   IfMsgBox Retry, GoTo Label_SafelyRemoveUMS


 }


Return ( VetoType ? 0 : FRIENDLY "`n" DeviceID  )
      , DllCall( "SetLastError", UInt,VetoType )
      , ErrorLevel := VetoType ? 7 : 0
}


;===========================新版 安全删除硬件 结束==================



;#########################################################################################
;#########################################################################################
;######################################            #######################################
;######################################  THE  END  #######################################
;######################################            #######################################
;#########################################################################################
;#########################################################################################