'*******************************************************************************************************
'
'					   	    	 Surf'n Safari Premier 1991 VPX v1.3.3
'								http://www.ipdb.org/machine.cgi?id=2461
'
'											Created by Kiwi
'
'*******************************************************************************************************

Option Explicit
Randomize

On Error Resume Next
ExecuteGlobal GetTextFile("controller.vbs")
If Err Then MsgBox "You need the controller.vbs in order to run this table, available in the vp10 package"
On Error Goto 0

'********************************************** OPTIONS ************************************************

'****************************************** Volume Settings **********************************

Const RolVol = 1	'Ball Rolling
Const MroVol = 1	'Wire Ramps Rolling
Const ProVol = 1	'Plastic Ramps Rolling
Const ColVol = 1	'Ball Collision
Const DroVol = 1	'Ball drop (4)
Const RubVol = 1	'Rubbers Collision
Const MhiVol = 1	'Metals Hit
Const FlaVol = 0.1	'Flap Ramps Hit (2)
Const CujVol = 0.7	'Cup Jump (2)
Const NudVol = 1	'Nudge
Const TrfVol = 1	'Trough fire
Const PlpVol = 1	'Plunger pull
Const PlfVol = 1	'Plunger fire
Const SliVol = 1	'Slingshots (2)
Const BumVol = 1	'Bumpers (3)
Const SwiVol = 1	'Rollovers (6)
Const TarVol = 1	'Targets (2)
Const DtaVol = 1	'Droptargets (6)
Const DtrVol = 1	'Droptarget reset (2)
Const KitVol = 1	'Kicking Targets (1)
Const GatVol = 1	'Gates (5)
Const SpiVol = 1	'Spinner
Const KicVol = 0.5	'Kicker catch (2)
Const KieVol = 1	'Kicker eject (2)
Const KidVol = 1	'Kicker Drain
Const FluVol = 1	'Flippers up
Const FldVol = 1	'Flippers down
Const KnoVol = 1	'Knocker

'************************ ROM

Const cGameName = "surfnsaf"

'************************ Ball: 50 unit is standard ball size ** Mass=(50^3)/125000 ,(BallSize^3)/125000

Const BallSize = 50

Const BallMass = 1.07

'************************ Max ball momentum ** Momentum limiter: 0 off, 1 on.

Const Maxmom = 400

Const MomOn = 0

'************************ Ball Shadow: 0 hidden , 1 visible

Const BallSHW = 1

'************************ CabRails and rail lights Hidden/Visible in FS mode: 0 hidden , 1 visible

Const RailsLights = 0

'************************ Flashers Intensity

Const Lumens = 10

'************************ Color Grading LUT: 1 = Active, any other value = disabled

Const LutEnabled = 1

'************************ Rodney's Glasses Color: 1=White ,2=Yellow ,3=Orange ,4=Red ,5=Violet ,6=Green ,7=Blue

Const GlassesColor = 7

'************************ Rodney animation: 1 on, 0 off

Const RodneyAnim = 1

'************************ 0 Backglass on in FSS, 1 Backglass on and Backdrop off in DT, 2 Backglass on in FS

Const BackG = 0

'************************ Slingshot mode: 0 Walls , 1 Flippers

Const SlingM = 0

'************************ Slingshot hit threshold, with flippers (parm)

Const ThSling = 3

'************************ Ombre fori PF e apron

Const bladeArt	= 1	'1=On (Art), 2=Sideblades Off.

Dim o
For each o in aOmbre
	o.IntensityScale = 0.95
	o.Height = -25
Next

	Ombra009.IntensityScale = 0.95
	Ombra010.IntensityScale = 0.95

'************************************************* DMD *************************************************

Dim DmdHidden, ModePlay
ModePlay = Table1.ShowDT + Table1.ShowFSS - BackG
 If ModePlay = -1 Then DMDHidden = LedDMDDt

'************************ DT VpinMame or LedDMD visible: 0 VpinMame visible , 1 LedDMD visible

Const LedDMDDt = 1

'************************ DT LedDMD Digits Off: 0 invisible , 1 visible

 Frame.SetValue 1

'************************ FS VpinMame DMD Visible/Hidden: 0 visible , 1 hidden

 If ModePlay = 0 Then DMDHidden = 0

 If B2SOn = True Then DMDHidden = 1

'************************ FSS VpinMame DMD Visible/Hidden: 0 visible , 1 hidden

 If ModePlay = -2 Then DMDHidden = 1

'********************************************* OPTIONS END *********************************************

LoadVPM "01560000", "gts3.VBS", 3.26

'Set Controller = CreateObject("b2s.server")

Dim bsTrough, cdtBank, ddtBank, bsUK, bsLK, mHole, mHole1, mHole2, PinPlay

Const UseSolenoids = 2
Const UseLamps = 0
Const UseGI = 0
Const UseSync = 0
Const HandleMech = 0

' Standard Sounds
Const SSolenoidOn = "Solenoid"
Const SSolenoidOff = ""
Const SFlipperOn = ""
Const SFlipperOff = ""
Const SCoin = "coin3"


Const swLCoin = 0
Const swRCoin = 1
Const swCCoin = 2
Const swStartButton = 4

'************
' Table init.
'************

Sub Table1_Init
	vpmInit me
	With Controller
		.GameName = cGameName
		If Err Then MsgBox "Can't start Game" & cGameName & vbNewLine & Err.Description:Exit Sub
		.SplashInfoLine = "Surf'n Safari Premier (Gottlieb 1991)" & vbNewLine & "VPX table by Kiwi 1.3.3"
		.HandleMechanics = 0
		.HandleKeyboard = 0
		.ShowDMDOnly = 1
		.ShowFrame = 0
		.ShowTitle = 0
		.Hidden = 1
'		.DoubleSize = 1
'		.Games(cGameName).Settings.Value("dmd_pos_x")=0
'		.Games(cGameName).Settings.Value("dmd_pos_y")=0
'		.Games(cGameName).Settings.Value("dmd_width")=400
'		.Games(cGameName).Settings.Value("dmd_height")=92
'		.Games(cGameName).Settings.Value("rol") = 0
'		.Games(cGameName).Settings.Value("sound") = 1
'		.Games(cGameName).Settings.Value("ddraw") = 1
		.Games(cGameName).Settings.Value("dmd_red")=60
		.Games(cGameName).Settings.Value("dmd_green")=180
		.Games(cGameName).Settings.Value("dmd_blue")=255
         On Error Resume Next
         .Run GetPlayerHWnd
         If Err Then MsgBox Err.Description
         On Error Goto 0
     End With

	' Nudging
	vpmNudge.TiltSwitch = 151
	vpmNudge.Sensitivity = 2
	vpmNudge.TiltObj = Array(Bumper1, Bumper2, Bumper3, LeftSlingShot, RightSlingShot, sw15)

	' Trough
	Set bsTrough = New cvpmBallStack
	With bsTrough
		.InitSw 5, 0, 0, 25, 0, 0, 0, 0
		.InitKick BallRelease, 68, 6
'		.InitEntrySnd "Solenoid", "Solenoid"
'		.InitExitSnd SoundFX("popper",DOFContactors), SoundFX("Solenoid",DOFContactors)
		.Balls = 3
	End With

	' Top Upkicker
	Set bsUK = New cvpmBallStack
	With bsUK
		.InitSaucer sw21, 21, 0, 32
		.KickZ = 1.56
'		.InitExitSnd SoundFX("popper",DOFContactors), SoundFX("Solenoid",DOFContactors)
	End With

	' Left Upkicker
	Set bsLK = New cvpmBallStack
	With bsLK
		.InitSaucer sw35, 35, 0, 35
		.KickZ = 1.56
'		.InitExitSnd SoundFX("popper",DOFContactors), SoundFX("Solenoid",DOFContactors)
	End With

	' Drop targets
	set cdtBank = new cvpmdroptarget
	With cdtBank
		.initdrop array(sw16, sw26, sw36), array(16, 26, 36)
'		.initsnd SoundFX("DROPTARG",DOFContactors), SoundFX("DTResetB",DOFContactors)
	End With

	set ddtBank = new cvpmdroptarget
	With ddtBank
		.initdrop array(sw17, sw27, sw37), array(17, 27, 37)
'		.initsnd SoundFX("DROPTARG",DOFContactors), SoundFX("DTResetB",DOFContactors)
	End With

' Main Timer init
	PinMAMETimer.Interval = PinMAMEInterval
	PinMAMETimer.Enabled = 1

' GI Delay Timer
	GIDelay.Enabled = 1

	Bulb12T17.Visible=0
	Bulb12T27.Visible=0
	Bulb11T37.Visible=0

' Init Droptargets
	Arm2.IsDropped=1

	SlingFSx1.Enabled = SlingM
	SlingFSx2.Enabled = SlingM
	SlingFDx1.Enabled = SlingM
	SlingFDx2.Enabled = SlingM

	RightSlingshot.IsDropped = SlingM
	LeftSlingshot.IsDropped = SlingM

'************ DT Init

 If ModePlay = -1 Then
	RailSx.visible=1
	RailDx.visible=1
	Trim.visible=1
	TrimS1.visible=1
	TrimS2.visible=1
	TrimS3.visible=1
	TrimS4.visible=1

	fgit1L.visible=1
	fgit1R.visible=1
	f43a.visible=1
	f50a.visible=1
	f56a.visible=1
	f57a.visible=1
	Bulb10b.visible=1
	Frame.visible=LedDMDDt

	l60.Intensity = 16
	l61.Intensity = 16
	l62.Intensity = 16
	l63.Intensity = 16
	l64.Intensity = 16
	l65.Intensity = 16
	l77.Intensity = 16
	l87.Intensity = 16
	l97.Intensity = 16
	l107.Intensity = 16
	l117.Intensity = 16
End If

'************ FS Init

 If ModePlay = 0 Then
	RailSx.visible=RailsLights
	RailDx.visible=RailsLights
	'Trim.visible=RailsLights
	TrimS1.visible=RailsLights
	TrimS2.visible=RailsLights
	TrimS3.visible=RailsLights
	TrimS4.visible=RailsLights

	fgit1L.visible=RailsLights
	fgit1R.visible=RailsLights
	f43a.visible=RailsLights
	f50a.visible=RailsLights
	f56a.visible=RailsLights
	f57a.visible=RailsLights
	f171a.visible=RailsLights
	f172a.visible=RailsLights
	f175a.visible=RailsLights
	Bulb10b.visible=RailsLights
End If

 If ModePlay = 0 And RailsLights = 0 Then
	f172.ImageA = "fbl2"
	f172.ImageB = "fbl2"
	f175.ImageA = "fbl2"
	f175.ImageB = "fbl2"
End If


'************ FSS Init

 If ModePlay = -2 Then
	flb1.Visible = 1
	flb2.Visible = 1
	flb3.Visible = 1
	flb4.Visible = 1
	flb5.Visible = 1
	flb6.Visible = 1
	flb7.Visible = 1
	flb8.Visible = 1
	flb9.Visible = 1
	flb10.Visible = 1
	flb11.Visible = 1
	flb12.Visible = 1
	flb13.Visible = 1
	flb14.Visible = 1
	flb15.Visible = 1
	flb16.Visible = 1
	flb17.Visible = 1
	flb18.Visible = 1
	flb19.Visible = 1
	flb20.Visible = 1
	flb21.Visible = 1
	flb22.Visible = 1
	flb23.Visible = 1
	flb24.Visible = 1
	flb25.Visible = 1
	flb26.Visible = 1
	flb27.Visible = 1
	flb28.Visible = 1
	f131.Visible = 1
	f131a.Visible = 1
	f132.Visible = 1
	f132a.Visible = 1
	f133.Visible = 1
	f133a.Visible = 1
	f134.Visible = 1
	f134a.Visible = 1

	f60.Visible = 1
	f61.Visible = 1
	f62.Visible = 1
	f63.Visible = 1
	f64.Visible = 1
	f65.Visible = 1
	f77.Visible = 1
	f87.Visible = 1
	f97.Visible = 1
	f107.Visible = 1
	f117.Visible = 1

End If

' Backbox

Const Fpy = -10

	f60.Y = Fpy:f61.Y = Fpy:f62.Y = Fpy:f63.Y = Fpy:f64.Y = Fpy:f65.Y = Fpy:f77.Y = Fpy:f87.Y = Fpy:f97.Y = Fpy:f107.Y = Fpy:f117.Y = Fpy
	f131.Y = Fpy:f131a.Y = Fpy:f132.Y = Fpy:f132a.Y = Fpy:f133.Y = Fpy:f133a.Y = Fpy:f134.Y = Fpy:f134a.Y = Fpy
	flb1.Y = Fpy:flb2.Y = Fpy:flb3.Y = Fpy:flb4.Y = Fpy:flb5.Y = Fpy:flb6.Y = Fpy:flb7.Y = Fpy:flb8.Y = Fpy:flb9.Y = Fpy
	flb10.Y = Fpy:flb11.Y = Fpy:flb12.Y = Fpy:flb13.Y = Fpy:flb14.Y = Fpy:flb15.Y = Fpy:flb16.Y = Fpy:flb17.Y = Fpy:flb18.Y = Fpy:flb19.Y = Fpy
	flb20.Y = Fpy:flb21.Y = Fpy:flb22.Y = Fpy:flb23.Y = Fpy:flb24.Y = Fpy:flb25.Y = Fpy:flb26.Y = Fpy:flb27.Y = Fpy:flb28.Y = Fpy

Const Dpy = -10

	fa00.Y = Dpy:fa01.Y = Dpy:fa02.Y = Dpy:fa03.Y = Dpy:fa04.Y = Dpy:fa05.Y = Dpy:fa06.Y = Dpy:fa07.Y = Dpy:fa08.Y = Dpy:fa09.Y = Dpy:fa0a.Y = Dpy:fa0b.Y = Dpy:fa0c.Y = Dpy:fa0d.Y = Dpy:fa0e.Y = Dpy:fa0f.Y = Dpy
	fa10.Y = Dpy:fa11.Y = Dpy:fa12.Y = Dpy:fa13.Y = Dpy:fa14.Y = Dpy:fa15.Y = Dpy:fa16.Y = Dpy:fa17.Y = Dpy:fa18.Y = Dpy:fa19.Y = Dpy:fa1a.Y = Dpy:fa1b.Y = Dpy:fa1c.Y = Dpy:fa1d.Y = Dpy:fa1e.Y = Dpy:fa1f.Y = Dpy
	fa20.Y = Dpy:fa21.Y = Dpy:fa22.Y = Dpy:fa23.Y = Dpy:fa24.Y = Dpy:fa25.Y = Dpy:fa26.Y = Dpy:fa27.Y = Dpy:fa28.Y = Dpy:fa29.Y = Dpy:fa2a.Y = Dpy:fa2b.Y = Dpy:fa2c.Y = Dpy:fa2d.Y = Dpy:fa2e.Y = Dpy:fa2f.Y = Dpy
	fa30.Y = Dpy:fa31.Y = Dpy:fa32.Y = Dpy:fa33.Y = Dpy:fa34.Y = Dpy:fa35.Y = Dpy:fa36.Y = Dpy:fa37.Y = Dpy:fa38.Y = Dpy:fa39.Y = Dpy:fa3a.Y = Dpy:fa3b.Y = Dpy:fa3c.Y = Dpy:fa3d.Y = Dpy:fa3e.Y = Dpy:fa3f.Y = Dpy
	fa40.Y = Dpy:fa41.Y = Dpy:fa42.Y = Dpy:fa43.Y = Dpy:fa44.Y = Dpy:fa45.Y = Dpy:fa46.Y = Dpy:fa47.Y = Dpy:fa48.Y = Dpy:fa49.Y = Dpy:fa4a.Y = Dpy:fa4b.Y = Dpy:fa4c.Y = Dpy:fa4d.Y = Dpy:fa4e.Y = Dpy:fa4f.Y = Dpy
	fa50.Y = Dpy:fa51.Y = Dpy:fa52.Y = Dpy:fa53.Y = Dpy:fa54.Y = Dpy:fa55.Y = Dpy:fa56.Y = Dpy:fa57.Y = Dpy:fa58.Y = Dpy:fa59.Y = Dpy:fa5a.Y = Dpy:fa5b.Y = Dpy:fa5c.Y = Dpy:fa5d.Y = Dpy:fa5e.Y = Dpy:fa5f.Y = Dpy
	fa60.Y = Dpy:fa61.Y = Dpy:fa62.Y = Dpy:fa63.Y = Dpy:fa64.Y = Dpy:fa65.Y = Dpy:fa66.Y = Dpy:fa67.Y = Dpy:fa68.Y = Dpy:fa69.Y = Dpy:fa6a.Y = Dpy:fa6b.Y = Dpy:fa6c.Y = Dpy:fa6d.Y = Dpy:fa6e.Y = Dpy:fa6f.Y = Dpy
	fa70.Y = Dpy:fa71.Y = Dpy:fa72.Y = Dpy:fa73.Y = Dpy:fa74.Y = Dpy:fa75.Y = Dpy:fa76.Y = Dpy:fa77.Y = Dpy:fa78.Y = Dpy:fa79.Y = Dpy:fa7a.Y = Dpy:fa7b.Y = Dpy:fa7c.Y = Dpy:fa7d.Y = Dpy:fa7e.Y = Dpy:fa7f.Y = Dpy
	fa80.Y = Dpy:fa81.Y = Dpy:fa82.Y = Dpy:fa83.Y = Dpy:fa84.Y = Dpy:fa85.Y = Dpy:fa86.Y = Dpy:fa87.Y = Dpy:fa88.Y = Dpy:fa89.Y = Dpy:fa8a.Y = Dpy:fa8b.Y = Dpy:fa8c.Y = Dpy:fa8d.Y = Dpy:fa8e.Y = Dpy:fa8f.Y = Dpy
	fa90.Y = Dpy:fa91.Y = Dpy:fa92.Y = Dpy:fa93.Y = Dpy:fa94.Y = Dpy:fa95.Y = Dpy:fa96.Y = Dpy:fa97.Y = Dpy:fa98.Y = Dpy:fa99.Y = Dpy:fa9a.Y = Dpy:fa9b.Y = Dpy:fa9c.Y = Dpy:fa9d.Y = Dpy:fa9e.Y = Dpy:fa9f.Y = Dpy
	faa0.Y = Dpy:faa1.Y = Dpy:faa2.Y = Dpy:faa3.Y = Dpy:faa4.Y = Dpy:faa5.Y = Dpy:faa6.Y = Dpy:faa7.Y = Dpy:faa8.Y = Dpy:faa9.Y = Dpy:faaa.Y = Dpy:faab.Y = Dpy:faac.Y = Dpy:faad.Y = Dpy:faae.Y = Dpy:faaf.Y = Dpy
	fab0.Y = Dpy:fab1.Y = Dpy:fab2.Y = Dpy:fab3.Y = Dpy:fab4.Y = Dpy:fab5.Y = Dpy:fab6.Y = Dpy:fab7.Y = Dpy:fab8.Y = Dpy:fab9.Y = Dpy:faba.Y = Dpy:fabb.Y = Dpy:fabc.Y = Dpy:fabd.Y = Dpy:fabe.Y = Dpy:fabf.Y = Dpy
	fac0.Y = Dpy:fac1.Y = Dpy:fac2.Y = Dpy:fac3.Y = Dpy:fac4.Y = Dpy:fac5.Y = Dpy:fac6.Y = Dpy:fac7.Y = Dpy:fac8.Y = Dpy:fac9.Y = Dpy:faca.Y = Dpy:facb.Y = Dpy:facc.Y = Dpy:facd.Y = Dpy:face.Y = Dpy:facf.Y = Dpy
	fad0.Y = Dpy:fad1.Y = Dpy:fad2.Y = Dpy:fad3.Y = Dpy:fad4.Y = Dpy:fad5.Y = Dpy:fad6.Y = Dpy:fad7.Y = Dpy:fad8.Y = Dpy:fad9.Y = Dpy:fada.Y = Dpy:fadb.Y = Dpy:fadc.Y = Dpy:fadd.Y = Dpy:fade.Y = Dpy:fadf.Y = Dpy
	fae0.Y = Dpy:fae1.Y = Dpy:fae2.Y = Dpy:fae3.Y = Dpy:fae4.Y = Dpy:fae5.Y = Dpy:fae6.Y = Dpy:fae7.Y = Dpy:fae8.Y = Dpy:fae9.Y = Dpy:faea.Y = Dpy:faeb.Y = Dpy:faec.Y = Dpy:faed.Y = Dpy:faee.Y = Dpy:faef.Y = Dpy
	faf0.Y = Dpy:faf1.Y = Dpy:faf2.Y = Dpy:faf3.Y = Dpy:faf4.Y = Dpy:faf5.Y = Dpy:faf6.Y = Dpy:faf7.Y = Dpy:faf8.Y = Dpy:faf9.Y = Dpy:fafa.Y = Dpy:fafb.Y = Dpy:fafc.Y = Dpy:fafd.Y = Dpy:fafe.Y = Dpy:faff.Y = Dpy
	fb00.Y = Dpy:fb01.Y = Dpy:fb02.Y = Dpy:fb03.Y = Dpy:fb04.Y = Dpy:fb05.Y = Dpy:fb06.Y = Dpy:fb07.Y = Dpy:fb08.Y = Dpy:fb09.Y = Dpy:fb0a.Y = Dpy:fb0b.Y = Dpy:fb0c.Y = Dpy:fb0d.Y = Dpy:fb0e.Y = Dpy:fb0f.Y = Dpy
	fb10.Y = Dpy:fb11.Y = Dpy:fb12.Y = Dpy:fb13.Y = Dpy:fb14.Y = Dpy:fb15.Y = Dpy:fb16.Y = Dpy:fb17.Y = Dpy:fb18.Y = Dpy:fb19.Y = Dpy:fb1a.Y = Dpy:fb1b.Y = Dpy:fb1c.Y = Dpy:fb1d.Y = Dpy:fb1e.Y = Dpy:fb1f.Y = Dpy
	fb20.Y = Dpy:fb21.Y = Dpy:fb22.Y = Dpy:fb23.Y = Dpy:fb24.Y = Dpy:fb25.Y = Dpy:fb26.Y = Dpy:fb27.Y = Dpy:fb28.Y = Dpy:fb29.Y = Dpy:fb2a.Y = Dpy:fb2b.Y = Dpy:fb2c.Y = Dpy:fb2d.Y = Dpy:fb2e.Y = Dpy:fb2f.Y = Dpy
	fb30.Y = Dpy:fb31.Y = Dpy:fb32.Y = Dpy:fb33.Y = Dpy:fb34.Y = Dpy:fb35.Y = Dpy:fb36.Y = Dpy:fb37.Y = Dpy:fb38.Y = Dpy:fb39.Y = Dpy:fb3a.Y = Dpy:fb3b.Y = Dpy:fb3c.Y = Dpy:fb3d.Y = Dpy:fb3e.Y = Dpy:fb3f.Y = Dpy

	fb40.Y = Dpy:fb41.Y = Dpy:fb42.Y = Dpy:fb43.Y = Dpy:fb44.Y = Dpy:fb45.Y = Dpy:fb46.Y = Dpy:fb47.Y = Dpy:fb48.Y = Dpy:fb49.Y = Dpy:fb4a.Y = Dpy:fb4b.Y = Dpy:fb4c.Y = Dpy:fb4d.Y = Dpy:fb4e.Y = Dpy:fb4f.Y = Dpy
	fb50.Y = Dpy:fb51.Y = Dpy:fb52.Y = Dpy:fb53.Y = Dpy:fb54.Y = Dpy:fb55.Y = Dpy:fb56.Y = Dpy:fb57.Y = Dpy:fb58.Y = Dpy:fb59.Y = Dpy:fb5a.Y = Dpy:fb5b.Y = Dpy:fb5c.Y = Dpy:fb5d.Y = Dpy:fb5e.Y = Dpy:fb5f.Y = Dpy
	fb60.Y = Dpy:fb61.Y = Dpy:fb62.Y = Dpy:fb63.Y = Dpy:fb64.Y = Dpy:fb65.Y = Dpy:fb66.Y = Dpy:fb67.Y = Dpy:fb68.Y = Dpy:fb69.Y = Dpy:fb6a.Y = Dpy:fb6b.Y = Dpy:fb6c.Y = Dpy:fb6d.Y = Dpy:fb6e.Y = Dpy:fb6f.Y = Dpy
	fb70.Y = Dpy:fb71.Y = Dpy:fb72.Y = Dpy:fb73.Y = Dpy:fb74.Y = Dpy:fb75.Y = Dpy:fb76.Y = Dpy:fb77.Y = Dpy:fb78.Y = Dpy:fb79.Y = Dpy:fb7a.Y = Dpy:fb7b.Y = Dpy:fb7c.Y = Dpy:fb7d.Y = Dpy:fb7e.Y = Dpy:fb7f.Y = Dpy
	fb80.Y = Dpy:fb81.Y = Dpy:fb82.Y = Dpy:fb83.Y = Dpy:fb84.Y = Dpy:fb85.Y = Dpy:fb86.Y = Dpy:fb87.Y = Dpy:fb88.Y = Dpy:fb89.Y = Dpy:fb8a.Y = Dpy:fb8b.Y = Dpy:fb8c.Y = Dpy:fb8d.Y = Dpy:fb8e.Y = Dpy:fb8f.Y = Dpy
	fb90.Y = Dpy:fb91.Y = Dpy:fb92.Y = Dpy:fb93.Y = Dpy:fb94.Y = Dpy:fb95.Y = Dpy:fb96.Y = Dpy:fb97.Y = Dpy:fb98.Y = Dpy:fb99.Y = Dpy:fb9a.Y = Dpy:fb9b.Y = Dpy:fb9c.Y = Dpy:fb9d.Y = Dpy:fb9e.Y = Dpy:fb9f.Y = Dpy
	fba0.Y = Dpy:fba1.Y = Dpy:fba2.Y = Dpy:fba3.Y = Dpy:fba4.Y = Dpy:fba5.Y = Dpy:fba6.Y = Dpy:fba7.Y = Dpy:fba8.Y = Dpy:fba9.Y = Dpy:fbaa.Y = Dpy:fbab.Y = Dpy:fbac.Y = Dpy:fbad.Y = Dpy:fbae.Y = Dpy:fbaf.Y = Dpy
	fbb0.Y = Dpy:fbb1.Y = Dpy:fbb2.Y = Dpy:fbb3.Y = Dpy:fbb4.Y = Dpy:fbb5.Y = Dpy:fbb6.Y = Dpy:fbb7.Y = Dpy:fbb8.Y = Dpy:fbb9.Y = Dpy:fbba.Y = Dpy:fbbb.Y = Dpy:fbbc.Y = Dpy:fbbd.Y = Dpy:fbbe.Y = Dpy:fbbf.Y = Dpy
	fbc0.Y = Dpy:fbc1.Y = Dpy:fbc2.Y = Dpy:fbc3.Y = Dpy:fbc4.Y = Dpy:fbc5.Y = Dpy:fbc6.Y = Dpy:fbc7.Y = Dpy:fbc8.Y = Dpy:fbc9.Y = Dpy:fbca.Y = Dpy:fbcb.Y = Dpy:fbcc.Y = Dpy:fbcd.Y = Dpy:fbce.Y = Dpy:fbcf.Y = Dpy
	fbd0.Y = Dpy:fbd1.Y = Dpy:fbd2.Y = Dpy:fbd3.Y = Dpy:fbd4.Y = Dpy:fbd5.Y = Dpy:fbd6.Y = Dpy:fbd7.Y = Dpy:fbd8.Y = Dpy:fbd9.Y = Dpy:fbda.Y = Dpy:fbdb.Y = Dpy:fbdc.Y = Dpy:fbdd.Y = Dpy:fbde.Y = Dpy:fbdf.Y = Dpy
	fbe0.Y = Dpy:fbe1.Y = Dpy:fbe2.Y = Dpy:fbe3.Y = Dpy:fbe4.Y = Dpy:fbe5.Y = Dpy:fbe6.Y = Dpy:fbe7.Y = Dpy:fbe8.Y = Dpy:fbe9.Y = Dpy:fbea.Y = Dpy:fbeb.Y = Dpy:fbec.Y = Dpy:fbed.Y = Dpy:fbee.Y = Dpy:fbef.Y = Dpy
	fbf0.Y = Dpy:fbf1.Y = Dpy:fbf2.Y = Dpy:fbf3.Y = Dpy:fbf4.Y = Dpy:fbf5.Y = Dpy:fbf6.Y = Dpy:fbf7.Y = Dpy:fbf8.Y = Dpy:fbf9.Y = Dpy:fbfa.Y = Dpy:fbfb.Y = Dpy:fbfc.Y = Dpy:fbfd.Y = Dpy:fbfe.Y = Dpy:fbff.Y = Dpy
	fc00.Y = Dpy:fc01.Y = Dpy:fc02.Y = Dpy:fc03.Y = Dpy:fc04.Y = Dpy:fc05.Y = Dpy:fc06.Y = Dpy:fc07.Y = Dpy:fc08.Y = Dpy:fc09.Y = Dpy:fc0a.Y = Dpy:fc0b.Y = Dpy:fc0c.Y = Dpy:fc0d.Y = Dpy:fc0e.Y = Dpy:fc0f.Y = Dpy
	fc10.Y = Dpy:fc11.Y = Dpy:fc12.Y = Dpy:fc13.Y = Dpy:fc14.Y = Dpy:fc15.Y = Dpy:fc16.Y = Dpy:fc17.Y = Dpy:fc18.Y = Dpy:fc19.Y = Dpy:fc1a.Y = Dpy:fc1b.Y = Dpy:fc1c.Y = Dpy:fc1d.Y = Dpy:fc1e.Y = Dpy:fc1f.Y = Dpy
	fc20.Y = Dpy:fc21.Y = Dpy:fc22.Y = Dpy:fc23.Y = Dpy:fc24.Y = Dpy:fc25.Y = Dpy:fc26.Y = Dpy:fc27.Y = Dpy:fc28.Y = Dpy:fc29.Y = Dpy:fc2a.Y = Dpy:fc2b.Y = Dpy:fc2c.Y = Dpy:fc2d.Y = Dpy:fc2e.Y = Dpy:fc2f.Y = Dpy
	fc30.Y = Dpy:fc31.Y = Dpy:fc32.Y = Dpy:fc33.Y = Dpy:fc34.Y = Dpy:fc35.Y = Dpy:fc36.Y = Dpy:fc37.Y = Dpy:fc38.Y = Dpy:fc39.Y = Dpy:fc3a.Y = Dpy:fc3b.Y = Dpy:fc3c.Y = Dpy:fc3d.Y = Dpy:fc3e.Y = Dpy:fc3f.Y = Dpy
	fc40.Y = Dpy:fc41.Y = Dpy:fc42.Y = Dpy:fc43.Y = Dpy:fc44.Y = Dpy:fc45.Y = Dpy:fc46.Y = Dpy:fc47.Y = Dpy:fc48.Y = Dpy:fc49.Y = Dpy:fc4a.Y = Dpy:fc4b.Y = Dpy:fc4c.Y = Dpy:fc4d.Y = Dpy:fc4e.Y = Dpy:fc4f.Y = Dpy
	fc50.Y = Dpy:fc51.Y = Dpy:fc52.Y = Dpy:fc53.Y = Dpy:fc54.Y = Dpy:fc55.Y = Dpy:fc56.Y = Dpy:fc57.Y = Dpy:fc58.Y = Dpy:fc59.Y = Dpy:fc5a.Y = Dpy:fc5b.Y = Dpy:fc5c.Y = Dpy:fc5d.Y = Dpy:fc5e.Y = Dpy:fc5f.Y = Dpy
	fc60.Y = Dpy:fc61.Y = Dpy:fc62.Y = Dpy:fc63.Y = Dpy:fc64.Y = Dpy:fc65.Y = Dpy:fc66.Y = Dpy:fc67.Y = Dpy:fc68.Y = Dpy:fc69.Y = Dpy:fc6a.Y = Dpy:fc6b.Y = Dpy:fc6c.Y = Dpy:fc6d.Y = Dpy:fc6e.Y = Dpy:fc6f.Y = Dpy
	fc70.Y = Dpy:fc71.Y = Dpy:fc72.Y = Dpy:fc73.Y = Dpy:fc74.Y = Dpy:fc75.Y = Dpy:fc76.Y = Dpy:fc77.Y = Dpy:fc78.Y = Dpy:fc79.Y = Dpy:fc7a.Y = Dpy:fc7b.Y = Dpy:fc7c.Y = Dpy:fc7d.Y = Dpy:fc7e.Y = Dpy:fc7f.Y = Dpy

	TextLUT.Visible = 0
	TextLUT.Text = Table1.ColorGradeImage
	LoadLut

End Sub

' Choose Side Blades 
	if bladeArt = 1 then
		PinCab_Blades.Image = "Sidewalls SnS"
		PinCab_Blades.visible = 1
	elseif bladeArt = 2 then
		PinCab_Blades.visible = 0
	End if 



Sub Table1_Exit():Controller.Stop:End Sub
Sub Table1_Paused:Controller.Pause = 1:End Sub
Sub Table1_unPaused:Controller.Pause = 0:End Sub

' GI Init
Sub GIDelay_Timer()
	SetLamp 160, 1
	SetLamp 126, 1
	GIDelay.Enabled = 0
End Sub

' Glasses Color
 If GlassesColor=1 Then:Glasses.Image="GlassWhite":End If
 If GlassesColor=2 Then:Glasses.Image="GlassYellow":End If
 If GlassesColor=3 Then:Glasses.Image="GlassOrange":End If
 If GlassesColor=4 Then:Glasses.Image="GlassRed":End If
 If GlassesColor=5 Then:Glasses.Image="GlassViolet":End If
 If GlassesColor=6 Then:Glasses.Image="GlassGreen":End If
 If GlassesColor=7 Then:Glasses.Image="GlassBlue":End If

'**********
' Keys
'**********

Sub Table1_KeyDown(ByVal KeyCode)
	If KeyCode = LeftFlipperKey Then Controller.Switch(6) = 1
	If KeyCode = RightFlipperKey Then  Controller.Switch(7) = 1
	If keycode = LeftMagnaSave Then bLutActive = True:TextLUT.Visible = 1
	If keycode = RightMagnaSave Then
	If bLutActive And LutEnabled = 1 Then NextLUT: End If
	End If
	If keycode = PlungerKey Then Plunger.Pullback:PlaySoundAtVol "fx_plungerpull", Plunger, PlpVol
	If keycode = LeftTiltKey Then Nudge 90, 4:PlaySound SoundFX("fx_nudge",0), 0, NudVol, -0.1, 0.25
	If keycode = RightTiltKey Then Nudge 270, 4:PlaySound SoundFX("fx_nudge",0), 0, NudVol, 0.1, 0.25
	If keycode = CenterTiltKey Then Nudge 0, 5:PlaySound SoundFX("fx_nudge",0), 0, NudVol, 0, 0.25
	If vpmKeyDown(KeyCode) Then Exit Sub
    'debug key
	If KeyCode = KeyFront And Sw16.IsDropped = 1 And Sw26.IsDropped = 1 And Sw36.IsDropped = 1 Then
	Sw16.IsDropped = 0:Sw26.IsDropped = 0:Sw36.IsDropped = 0:cdtbank.DropSol_On
End If
	If KeyCode = KeyFront And Sw17.IsDropped = 1 And Sw27.IsDropped = 1 And Sw37.IsDropped = 1 Then
	Sw17.IsDropped = 0:Sw27.IsDropped = 0:Sw37.IsDropped = 0:ddtbank.DropSol_On
End If
'    If KeyCode = "3" Then
'        SetLamp 171, 1
'        SetLamp 172, 1
'        SetLamp 175, 1
'        SetLamp 190, 1
'        SetLamp 197, 1
'        SetLamp 198, 1
'        SetLamp 199, 1
'        f151.State = 1
'        f151a.State = 1
'        Muro1.IsDropped=ABS(Muro1.IsDropped+1)
'    End If
End Sub

Sub Table1_KeyUp(ByVal KeyCode)
	If KeyCode = LeftFlipperKey Then Controller.Switch(6) = 0
	If KeyCode = RightFlipperKey Then Controller.Switch(7) = 0
	If keycode = LeftMagnaSave Then bLutActive = False:TextLUT.Visible = 0
	If keycode = PlungerKey And Controller.Switch(30) Then Plunger.Fire:PlaySoundAtVol "fx_plunger", Plunger, PlfVol * (Plunger.Position/25)
	If keycode = PlungerKey And Not Controller.Switch(30) Then Plunger.Fire:PlaySoundAtVol "fx_plunger_empty", Plunger, PlfVol * (Plunger.Position/25)
	If vpmKeyUp(KeyCode) Then Exit Sub
    'debug key
'    If KeyCode = "3" Then
'        SetLamp 171, 0
'        SetLamp 172, 0
'        SetLamp 175, 0
'        SetLamp 190, 0
'        SetLamp 197, 0
'        SetLamp 198, 0
'        SetLamp 199, 0
'        f151.State = 0
'        f151a.State = 0
'    End If
End Sub

'*********
'   LUT
'*********

Dim bLutActive, LUTImage, x

Sub LoadLUT
	bLutActive = False
    x = LoadValue(cGameName, "LUTImage")
    If(x <> "") Then LUTImage = x Else LUTImage = 0
	UpdateLUT
End Sub

Sub SaveLUT
    SaveValue cGameName, "LUTImage", LUTImage
End Sub

Sub NextLUT:LUTImage = (LUTImage +1) MOD 10:UpdateLUT:SaveLUT:End Sub

Sub UpdateLUT
Select Case LutImage
	Case 0:Table1.ColorGradeImage = "LUT0"
	Case 1:Table1.ColorGradeImage = "LUT1"
	Case 2:Table1.ColorGradeImage = "LUT2"
	Case 3:Table1.ColorGradeImage = "LUT3"
	Case 4:Table1.ColorGradeImage = "LUT4"
	Case 5:Table1.ColorGradeImage = "LUT5"
	Case 6:Table1.ColorGradeImage = "LUT6"
	Case 7:Table1.ColorGradeImage = "LUT7"
	Case 8:Table1.ColorGradeImage = "LUT8"
	Case 9:Table1.ColorGradeImage = "LUT9"
End Select
TextLUT.Text = Table1.ColorGradeImage
End Sub

'*********
' Switches
'*********

' Slings
Dim LStep, RStep

Sub LeftSlingshot_Slingshot:vpmTimer.PulseSw 13:LeftSling.Visible=1:SxEmKickerT1.TransX=-28:LStep=0:Me.TimerEnabled=1:PlaySoundAtVol SoundFX("Slingshot",DOFContactors), SxEmKickerT1, SliVol:End Sub

Sub SlingFSx1_Collide(parm)
 If SxEmKickerT1.TransX=0 And PinPlay=1 And parm > ThSling Then
	vpmTimer.PulseSw 13:PlaySoundAtVol SoundFX("Slingshot",DOFContactors), SxEmKickerT1, SliVol:LStep=0
	LeftSling.Visible=1:SxEmKickerT1.TransX=-28:LeftSlingshot.TimerEnabled=1:SlingFSx1.RotateToEnd:SlingFSx2.RotateToEnd
End If
End Sub
Sub SlingFSx2_Collide(parm)
 If SxEmKickerT1.TransX=0 And PinPlay=1 And parm > ThSling Then
	vpmTimer.PulseSw 13:PlaySoundAtVol SoundFX("Slingshot",DOFContactors), SxEmKickerT1, SliVol:LStep=0
	LeftSling.Visible=1:SxEmKickerT1.TransX=-28:LeftSlingshot.TimerEnabled=1:SlingFSx1.RotateToEnd:SlingFSx2.RotateToEnd
End If
End Sub

Sub LeftSlingshot_Timer
	Select Case LStep
		Case 0:LeftSling.Visible = 1
		Case 1: 'pause
		Case 2:LeftSling.Visible = 0 :LeftSling1.Visible = 1:SxEmKickerT1.TransX=-23
		Case 3:LeftSling1.Visible = 0:LeftSling2.Visible = 1:SxEmKickerT1.TransX=-18.5:SlingFSx1.RotateToStart:SlingFSx2.RotateToStart
		Case 4:LeftSling2.Visible = 0:Me.TimerEnabled = 0:SxEmKickerT1.TransX=0
	End Select
	LStep = LStep + 1
End Sub

Sub RightSlingshot_Slingshot:vpmTimer.PulseSw 14:RightSling.Visible=1:DxEmKickerT1.TransX=-28:RStep=0:Me.TimerEnabled=1:PlaySoundAtVol SoundFX("Slingshot",DOFContactors), DxEmKickerT1, SliVol:End Sub

Sub SlingFDx1_Collide(parm)
 If DxEmKickerT1.TransX=0 And PinPlay=1 And parm > ThSling Then
	vpmTimer.PulseSw 14:PlaySoundAtVol SoundFX("Slingshot",DOFContactors), DxEmKickerT1, SliVol:RStep=0
	RightSling.Visible=1:DxEmKickerT1.TransX=-28:RightSlingshot.TimerEnabled=1:SlingFDx1.RotateToEnd:SlingFDx2.RotateToEnd
End If
End Sub
Sub SlingFDx2_Collide(parm)
 If DxEmKickerT1.TransX=0 And PinPlay=1 And parm > ThSling Then
	vpmTimer.PulseSw 14:PlaySoundAtVol SoundFX("Slingshot",DOFContactors), DxEmKickerT1, SliVol:RStep=0
	RightSling.Visible=1:DxEmKickerT1.TransX=-28:RightSlingshot.TimerEnabled=1:SlingFDx1.RotateToEnd:SlingFDx2.RotateToEnd
End If
End Sub

Sub RightSlingshot_Timer
	Select Case RStep
		Case 0:RightSling.Visible = 1
		Case 1: 'pause
		Case 2:RightSling.Visible = 0 :RightSling1.Visible = 1:DxEmKickerT1.TransX=-23
		Case 3:RightSling1.Visible = 0:RightSling2.Visible = 1:DxEmKickerT1.TransX=-18.5:SlingFDx1.RotateToStart:SlingFDx2.RotateToStart
		Case 4:RightSling2.Visible = 0:Me.TimerEnabled = 0:DxEmKickerT1.TransX=0
	End Select
	RStep = RStep + 1
End Sub

' Bumpers
Sub Bumper1_Hit:vpmTimer.PulseSw 10:PlaySoundAtVol SoundFX("jet1",DOFContactors), Bumper1, BumVol:End Sub
Sub Bumper2_Hit:vpmTimer.PulseSw 11:PlaySoundAtVol SoundFX("jet1",DOFContactors), Bumper2, BumVol:End Sub
Sub Bumper3_Hit:vpmTimer.PulseSw 12:PlaySoundAtVol SoundFX("jet1",DOFContactors), Bumper3, BumVol:End Sub

' Spinner
Sub sw20_Spin:vpmTimer.PulseSw 20:PlaySoundAtVol "spinner", sw20, SpiVol:End Sub

' Eject holes
Sub Drain_Hit:bsTrough.AddBall Me:PlaysoundAtVol "drain1a", Drain, KidVol:End Sub
Sub sw21_Hit:PlaysoundAtVol "fx_kicker_enter1", sw21, KicVol:bsUK.AddBall 0:End Sub
Sub sw35_Hit:PlaysoundAtVol "fx_kicker_enter1", sw35, KicVol:bsLK.AddBall 0:sw35Wire.RotX = 0:End Sub

' Rollovers
Sub sw23_Hit:  Controller.Switch(23) = 1:PlaySoundAtVol "sensor", sw23, SwiVol:Psw23.Z=-42:End Sub
Sub sw23_UnHit:Controller.Switch(23) = 0:Psw23.Z=-27:End Sub
Sub sw24_Hit:  Controller.Switch(24) = 1:PlaySoundAtVol "sensor", sw24, SwiVol:Psw24.Z=-42:End Sub
Sub sw24_UnHit:Controller.Switch(24) = 0:Psw24.Z=-27:End Sub
Sub sw30_Hit:  Controller.Switch(30) = 1:PlaySoundAtVol "sensor", sw30, SwiVol:Psw30.Z=-42:End Sub
Sub sw30_UnHit:Controller.Switch(30) = 0:Psw30.Z=-27:End Sub
Sub sw31_Hit:  Controller.Switch(31) = 1:PlaySoundAtVol "sensor", sw31, SwiVol:Psw31.Z=-42:End Sub
Sub sw31_UnHit:Controller.Switch(31) = 0:Psw31.Z=-27:End Sub
Sub sw33_Hit:  Controller.Switch(33) = 1:PlaySoundAtVol "sensor", sw33, SwiVol:Psw33.Z=-42:End Sub
Sub sw33_UnHit:Controller.Switch(33) = 0:Psw33.Z=-27:End Sub
Sub sw34_Hit:  Controller.Switch(34) = 1:PlaySoundAtVol "sensor", sw34, SwiVol:Psw34.Z=-42:End Sub
Sub sw34_UnHit:Controller.Switch(34) = 0:Psw34.Z=-27:End Sub

'Ramp sensors
Sub sw50_Hit:  Controller.Switch(50) = 1:End Sub
Sub sw50_UnHit:Controller.Switch(50) = 0:End Sub
Sub sw51_Hit:  Controller.Switch(51) = 1:End Sub
Sub sw51_UnHit:Controller.Switch(51) = 0:End Sub
Sub sw52_Hit:  Controller.Switch(52) = 1:End Sub
Sub sw52_UnHit:Controller.Switch(52) = 0:End Sub
Sub sw52a_Hit:  Controller.Switch(52) = 1:End Sub
Sub sw52a_UnHit:Controller.Switch(52) = 0:End Sub

' Targets
Sub sw32_Hit:vpmTimer.PulseSw 32:Psw32.TransY=-5:Me.TimerEnabled=1:PlaySoundAtBallVol SoundFX("target",DOFTargets), TarVol:End Sub
Sub sw32_Timer:Psw32.TransY=0:Me.TimerEnabled=0:End Sub

' Kicking Targets
Sub sw15_Slingshot:vpmTimer.PulseSw 15:KickingTsw15.RotY=7:Me.TimerEnabled=1:PlaySoundAtVol SoundFX("bumper5",DOFContactors), KickingTsw15, KitVol:End Sub
Sub sw15_Timer:KickingTsw15.RotY=0:Me.TimerEnabled=0:End Sub
Sub sw22_Hit:vpmTimer.PulseSw 22:KickingTsw22.RotY=-7:Me.TimerEnabled=1:PlaySoundAtBallVol SoundFX("target",DOFTargets), TarVol:End Sub
Sub sw22_Timer:KickingTsw22.RotY=0:Me.TimerEnabled=0:End Sub

' Droptargets
Sub sw16_Hit():PlaySoundAtVol SoundFX("DROPTARG",DOFDropTargets), sw16, DtaVol:End Sub
Sub sw16_Dropped:cdtbank.Hit 1:End Sub

Sub sw26_Hit():PlaySoundAtVol SoundFX("DROPTARG",DOFDropTargets), sw26, DtaVol:End Sub
Sub sw26_Dropped:cdtbank.Hit 2:End Sub

Sub sw36_Hit():PlaySoundAtVol SoundFX("DROPTARG",DOFDropTargets), sw36, DtaVol:End Sub
Sub sw36_Dropped:cdtbank.Hit 3:End Sub

Sub sw17_Hit():PlaySoundAtVol SoundFX("DROPTARG",DOFDropTargets), sw17, DtaVol:End Sub
Sub sw17_Dropped:ddtbank.Hit 1:Bulb12T17.Visible=1:End Sub

Sub sw27_Hit():PlaySoundAtVol SoundFX("DROPTARG",DOFDropTargets), sw27, DtaVol:End Sub
Sub sw27_Dropped:ddtbank.Hit 2:Bulb12T27.Visible=1:End Sub

Sub sw37_Hit():PlaySoundAtVol SoundFX("DROPTARG",DOFDropTargets), sw37, DtaVol:End Sub
Sub sw37_Dropped:ddtbank.Hit 3:Bulb11T37.Visible=1:End Sub

' Gates
Sub Gate1_Hit:PlaySoundAtBallVol "Gate5", GatVol:End Sub

' Fx Sounds
Sub Fx1_Hit:PlaySoundAtBallVol "fx_InMetalrolling", MhiVol:End Sub
Sub Fx2_Hit:PlaySoundAtBallVol "fx_InMetalrolling", MhiVol:End Sub

Sub EndStop1_Hit:PlaySoundAtBallVol "WireHit", MhiVol*2:End Sub
Sub EndStop2_Hit:PlaySoundAtBallVol "WireHit", MhiVol*2:End Sub
Sub StopVUK2_Hit:PlaySoundAtBallVol "WireHit", MhiVol:End Sub

Sub TriggerFlapSx_Hit:PlaySoundAtBallVol "FlapHit2", FlaVol:End Sub
Sub TriggerFlapDx_Hit:PlaySoundAtBallVol "FlapHit2", FlaVol:End Sub

Sub Fx3_Hit:PlaySoundAtBallVol "PlasticJump", CujVol*0.6:End Sub

Sub CupFX1_Hit():ActiveBall.VelY=ActiveBall.VelY+0.1:PlaySoundAtBallVol "PlasticJump", CujVol:End Sub
Sub CupFX2_Hit():ActiveBall.VelY=ActiveBall.VelY-0.1:PlaySoundAtBallVol "PlasticJump", CujVol:End Sub

'*********
'Solenoids
'*********

SolCallback(7) = "bsLKBallRelease"
SolCallback(8) = "dtcbank"
SolCallback(9) = "dtdbank"
SolCallback(10) = "bsCKBallRelease"
SolCallback(11) = "setlamp 131,"
SolCallback(12) = "setlamp 132,"
SolCallback(13) = "setlamp 133,"
SolCallback(14) = "setlamp 134,"
SolCallback(15) = "setlamp 125,"
SolCallback(16) = "setlamp 150,"	'lamp
SolCallback(17) = "setlamp 197,"
SolCallback(18) = "setlamp 198,"
SolCallback(19) = "setlamp 199,"
SolCallback(20) = "setlamp 190,"
SolCallback(21) = "setlamp 171,"
SolCallback(22) = "setlamp 172,"
SolCallback(23) = "setlamp 122,"
SolCallback(24) = "setlamp 151,"
SolCallback(25) = "setlamp 175,"
SolCallback(26) = "Lightbox"	' Lightbox Insert Illum. Relay (A)
SolCallback(28) = "bsTroughSolOut"	'"bsTrough.SolOut"
SolCallback(29) = "bsTrough.SolIn"
SolCallback(30) = "KnockerSound"
SolCallback(31) = "GIRelay"
Solcallback(32) = "SolRun"

Sub bsLKBallRelease(Enabled)
 If Enabled Then
	bsLK.ExitSol_On
	Arm.TransZ=30
	TimerArm.Enabled=1
	Arm2.IsDropped=0
	PlaySoundAtVol SoundFX("popper",DOFContactors), sw35, KieVol
End If
End Sub

Sub TimerArm_Timer
	Arm.TransZ=0
	TimerArm.Enabled=0
	Arm2.IsDropped=1
	sw35Wire.RotX = -10
End Sub

Sub dtcbank(Enabled)
 If Enabled Then
	cdtbank.DropSol_On
End If
	PlaySoundAtVol SoundFX("DTResetB",DOFContactors), sw26, DtrVol
End Sub

Sub dtdbank(Enabled)
 If Enabled Then
	ddtbank.DropSol_On
End If
	Bulb12T17.TimerEnabled=1
	PlaySoundAtVol SoundFX("DTResetB",DOFContactors), sw27, DtrVol
End Sub

Sub Bulb12T17_Timer()
	Bulb12T17.Visible=0
	Bulb12T27.Visible=0
	Bulb11T37.Visible=0
	Bulb12T17.TimerEnabled=0
End Sub

Sub bsCKBallRelease(Enabled)
 If Enabled Then
	bsUK.ExitSol_On
	PlaySoundAtVol SoundFX("popper",DOFContactors), sw21, KieVol
End If
End Sub

Sub bsTroughSolOut(Enabled)
 If Enabled Then
	bsTrough.ExitSol_On
	PlaySoundAtVol SoundFX("popper",DOFContactors), BallRelease, TrfVol
End If
End Sub

Sub KnockerSound(Enabled)
 If Enabled Then
	PlaySoundAtVol SoundFX("Knocker",DOFKnocker), l30, KnoVol
End If
End Sub

'**************
' GI
'**************

Sub GIRelay(Enabled)
	Dim GIoffon
	GIoffon = ABS(ABS(Enabled) -1)
	SetLamp 160, GIoffon
End Sub

Sub SolRun(Enabled)
	vpmNudge.SolGameOn Enabled
 If Enabled Then
	PinPlay=1
Else
	PinPlay=0
	SlingFSx1.RotateToStart:SlingFSx2.RotateToStart
	SlingFSx1.RotateToStart:SlingFSx2.RotateToStart
'	LeftFlipper.RotateToStart
'	RightFlipper.RotateToStart
End If
End Sub

Sub Lightbox(Enabled)
	Dim GIoffon
	GIoffon = ABS(ABS(Enabled) -1)
	SetLamp 126, GIoffon
End Sub

'**************
' Flipper Subs
'**************

SolCallback(sLRFlipper) = "SolRFlipper"
SolCallback(sLLFlipper) = "SolLFlipper"

Sub SolLFlipper(Enabled)
	If Enabled Then
		PlaySoundAtVol SoundFX("flipperup1",DOFFlippers), LeftFlipper, FluVol:LeftFlipper.RotateToEnd
	Else
		If LeftFlipper.CurrentAngle < LeftFlipper.StartAngle - 5 Then
			PlaySoundAtVol SoundFX("flipperdown1",DOFFlippers), LeftFlipper, FldVol
		End If	
        LeftFlipper.RotateToStart
	End If
End Sub

Sub SolRFlipper(Enabled)
	If Enabled Then
		PlaySoundAtVol SoundFX("flipperup1",DOFFlippers), RightFlipper, FluVol:RightFlipper.RotateToEnd
	Else
   		If RightFlipper.CurrentAngle > RightFlipper.StartAngle + 5 Then
			PlaySoundAtVol SoundFX("flipperdown1",DOFFlippers), RightFlipper, FldVol
		End If
		RightFlipper.RotateToStart
	End If
End Sub

Sub LeftFlipper_Collide(parm)
	PlaySound "rubber_flipper", 0, parm / 10, pan(ActiveBall), 0, Pitch(ActiveBall), 0, 0, AudioFade(ActiveBall)
End Sub

Sub RightFlipper_Collide(parm)
	PlaySound "rubber_flipper", 0, parm / 10, pan(ActiveBall), 0, Pitch(ActiveBall), 0, 0, AudioFade(ActiveBall)
End Sub

'**********************************
'       JP's VP10 Fading Lamps & Flashers v2
'       Based on PD's Fading Light System
' SetLamp 0 is Off
' SetLamp 1 is On
' fading for non opacity objects is 4 steps
'***************************************************

Dim LampState(200), FadingLevel(200)
Dim FlashSpeedUp(200), FlashSpeedDown(200), FlashMin(200), FlashMax(200), FlashLevel(200), DLSpeedUp(200), DLSpeedDown(200)

InitLamps()             ' turn off the lights and flashers and reset them to the default parameters
LampTimer.Interval = 10 'lamp fading speed
LampTimer.Enabled = 1

' Lamp & Flasher Timers

Sub LampTimer_Timer()
    Dim chgLamp, num, chg, ii
    chgLamp = Controller.ChangedLamps
    If Not IsEmpty(chgLamp) Then
        For ii = 0 To UBound(chgLamp)
            LampState(chgLamp(ii, 0) ) = chgLamp(ii, 1)       'keep the real state in an array
            FadingLevel(chgLamp(ii, 0) ) = chgLamp(ii, 1) + 4 'actual fading step
        Next
    End If
    UpdateLamps
 If ModePlay = -1 And LedDMDDt = 1 Then:UpdateLeds:End If
 If ModePlay = -2 Then:UpdateLedsF:End If
End Sub

Sub UpdateLamps
	NFadeL 0, l0
	NFadeL 1, l1
	NFadeL 2, l2
	NFadeL 3, l3
	NFadeL 4, l4
	NFadeL 5, l5
	NFadeL 6, l6
	NFadeL 7, l7
	NFadeL 10, l10
	NFadeL 11, l11
	NFadeL 12, l12
	NFadeL 13, l13
	NFadeL 14, l14
	NFadeL 15, l15
	NFadeL 16, l16
	NFadeL 17, l17
	NFadeL 20, l20
	NFadeL 21, l21
	NFadeL 22, l22
	NFadeL 23, l23
	NFadeL 24, l24
	NFadeL 25, l25
	NFadeL 26, l26
	NFadeL 27, l27
	NFadeL 30, l30
	NFadeL 31, l31
	NFadeL 32, l32
	NFadeL 33, l33
	NFadeL 34, l34
	NFadeL 35, l35
	NFadeL 36, l36
	NFadeL 37, l37
	NFadeL 40, l40
	NFadeL 41, l41

	NFadeL 67, l67
	NFadeL 70, l70
	NFadeL 71, l71
	NFadeL 72, l72
	NFadeL 73, l73
	NFadeL 74, l74

	NFadeLm 75, l75
	Flash 75, f75

	NFadeLm 76, l76
	Flash 76, f76

	NFadeL 80, l80
	NFadeL 81, l81
	NFadeL 82, l82
	NFadeL 83, l83
	NFadeL 84, l84

	NFadeLm 85, l85
	Flash 85, f85

	NFadeLm 86, l86
	Flash 86, f86

	NFadeL 90, l90
	NFadeL 91, l91
	NFadeL 92, l92
	NFadeL 93, l93
	NFadeL 94, l94

	NFadeLm 95, l95
	Flash 95, f95

	NFadeLm 96, l96
	Flash 96, f96

	NFadeL 100, l100
	NFadeL 101, l101
	NFadeL 102, l102
	NFadeL 103, l103
	NFadeL 104, l104

	NFadeLm 105, l105
	Flash 105, f105

	NFadeLm 106, l106
	Flash 106, f106

	NFadeL 110, l110
	NFadeL 111, l111
	NFadeL 112, l112
	NFadeL 113, l113
	NFadeL 114, l114

	NFadeLm 115, l115
	Flash 115, f115

	NFadeLm 116, l116
	Flash 116, f116

	NFadeL 122, l122
	NFadeL 125, l125

	Flashm 42, f42
	FlashDL 42, 0.5, BulbTop42
	Flashm 43, f43
	Flashm 43, f43a
	FlashDL 43, 0.5, BulbTop43
	FastFlashm 44, f44
	FastDL 44, 1, Led44
	FastFlashm 45, f45
	FastDL 45, 1, Led45
	FastFlashm 46, f46
	FastDL 46, 1, Led46
	FastFlashm 47, f47
	FastDL 47, 1, Led47
	Flashm 50, f50
	Flashm 50, f50a
	FlashDL 50, 0.5, BulbTop50
	Flashm 51, f51
	FlashDL 51, 0.5, BulbTop51
	FastFlashm 52, f52
	FastDL 52, 1, Led52
	FastFlashm 53, f53
	FastDL 53, 1, Led53
	FastFlashm 54, f54
	FastDL 54, 1, Led54
	FastFlashm 55, f55
	FastDL 55, 1, Led55
	Flashm 56, f56
	Flashm 56, f56a
	FlashDL 56, 0.5, Bulb56
	Flashm 57, f57
	Flashm 57, f57a
	FlashDL 57, 0.5, Bulb57
	FastFlashm 66, f66
	FastFlashm 66, f66a
	FastDLm 66, 1, Led66
	FastDL 66, 1, Led66a
	NFadeLm 150, fur1
	NFadeLm 150, fur2
	Flashm 150, fur1a
	Flash 150, fur2a
	NFadeLm 151, f151
	NFadeL 151, f151a

	NFadeLm 160, Bulb1
	NFadeLm 160, Bulb1a
	NFadeLm 160, Bulb2
	NFadeLm 160, Bulb2a
	NFadeLm 160, Bulb3
	NFadeLm 160, Bulb3a
	NFadeLm 160, Bulb4
	NFadeLm 160, Bulb4a
	NFadeLm 160, Bulb5
	NFadeLm 160, Bulb5a
	NFadeLm 160, Bulb6
	NFadeLm 160, Bulb6a
	NFadeLm 160, Bulb7
	NFadeLm 160, Bulb7a
	NFadeLm 160, Bulb8
	NFadeLm 160, Bulb8a
	NFadeLm 160, Bulb9
	NFadeLm 160, Bulb9a
	NFadeLm 160, Bulb10
	NFadeLm 160, Bulb10a
	NFadeLm 160, Bulb11
	NFadeLm 160, Bulb11a
	NFadeLm 160, Bulb12
	NFadeLm 160, Bulb12a
	NFadeLm 160, Bulb13
	NFadeLm 160, Bulb13a
	NFadeLm 160, Bulb14
	NFadeLm 160, Bulb14a
    NFadeLm 160, Bulb15
	NFadeLm 160, Bulb15a

	NFadeLm 160, Bulb12T17
	NFadeLm 160, Bulb12T27
	NFadeLm 160, Bulb11T37

	Flashm 160, fgit1
	Flashm 160, fgit1L
	Flashm 160, fgit1R
	Flashm 160, fgit2
	Flashm 160, fgit3
	Flashm 160, fgit4
	Flashm 160, fgit5
	Flashm 160, fgit6
	Flashm 160, fgit7
	Flashm 160, fgit8
	Flashm 160, fgit9
	Flashm 160, fgit10
	Flashm 160, fgit11
	Flashm 160, fgit12
	Flashm 160, fgit13
	Flashm 160, fgit14
	Flashm 160, Bulb10b

	FlashDLm 160, 0.2, BulbTop1
	FlashDLm 160, 0.2, BulbTop2
	FlashDLm 160, 0.2, BulbTop3
	FlashDLm 160, 0.2, BulbTop4
	FlashDLm 160, 0.2, BulbTop5
	FlashDLm 160, 0.2, BulbTop6
	FlashDLm 160, 0.2, BulbTop7
	FlashDLm 160, 0.2, BulbTop8
	FlashDLm 160, 0.2, BulbTop9
	FlashDLm 160, 0.2, BulbTop10
	FlashDLm 160, 0.2, BulbTop11
	FlashDLm 160, 0.2, BulbTop12
	FlashDLm 160, 0.2, BulbTop13
	FlashDL 160, 0.2, BulbTop14

	NFadeLm 171, l171
	Flashm 171, f171
	Flashm 171, f171a
	FlashDL 171, 0.2, Flasher24B171
	NFadeLm 172, l172
	Flashm 172, f172
	Flashm 172, f172a
	FlashDL 172, 0.2, Flasher24B172
	NFadeLm 175, l175
	Flashm 175, f175
	Flashm 175, f175a
	FlashDL 175, 0.2, Flasher24B175
	NFadeLm 190, l190
	Flashm 190, f190
	FlashDL 190, 0.2, Flasher24B190
	NFadeLm 197, l197
	Flashm 197, f197
	FlashDL 197, 0.2, Flasher24B197
	NFadeLm 198, l198
	Flashm 198, f198
	FlashDL 198, 0.2, Flasher24B198
	NFadeLm 199, l199
	Flashm 199, f199
	FlashDL 199, 0.2, Flasher24B199

' Backbox/Backglass

	NFadeLm 60, l60
	Flash 60, f60
	NFadeLm 61, l61
	Flash 61, f61
	NFadeLm 62, l62
	Flash 62, f62
	NFadeLm 63, l63
	Flash 63, f63
	NFadeLm 64, l64
	Flash 64, f64
	NFadeLm 65, l65
	Flash 65, f65

	NFadeLm 77, l77
	Flash 77, f77
	NFadeLm 87, l87
	Flash 87, f87
	NFadeLm 97, l97
	Flash 97, f97
	NFadeLm 107, l107
	Flash 107, f107
	NFadeLm 117, l117
	Flash 117, f117

	Flashm 131, f131
	Flash 131, f131a
	Flashm 132, f132
	Flash 132, f132a
	Flashm 133, f133
	Flash 133, f133a
	Flashm 134, f134
	Flash 134, f134a

	Flashm 126, flb1
	Flashm 126, flb2
	Flashm 126, flb3
	Flashm 126, flb4
	Flashm 126, flb5
	Flashm 126, flb6
	Flashm 126, flb7
	Flashm 126, flb8
	Flashm 126, flb9
	Flashm 126, flb10
	Flashm 126, flb11
	Flashm 126, flb12
	Flashm 126, flb13
	Flashm 126, flb14
	Flashm 126, flb15
	Flashm 126, flb16
	Flashm 126, flb17
	Flashm 126, flb18
	Flashm 126, flb19
	Flashm 126, flb20
	Flashm 126, flb21
	Flashm 126, flb22
	Flashm 126, flb23
	Flashm 126, flb24
	Flashm 126, flb25
	Flashm 126, flb26
	Flashm 126, flb27
	Flash 126, flb28

End Sub

' div lamp subs

Sub InitLamps()
    Dim x
    For x = 0 to 200
        LampState(x) = 0        ' current light state, independent of the fading level. 0 is off and 1 is on
        FadingLevel(x) = 4      ' used to track the fading state
        FlashSpeedUp(x) = 0.5   ' faster speed when turning on the flasher
        FlashSpeedDown(x) = 0.07	' slower speed when turning off the flasher
        DLSpeedUp(x) = 1	   	' faster speed when turning on the objects DisableLighting
        DLSpeedDown(x) = 0.14	' slower speed when turning off the objects DisableLighting
        FlashMax(x) = 1         ' the maximum value when on, usually 1
        FlashMin(x) = 0         ' the minimum value when off, usually 0
        FlashLevel(x) = 0       ' the intensity of the flashers, usually from 0 to 1
    Next
End Sub

Sub AllLampsOff
    Dim x
    For x = 0 to 200
        SetLamp x, 0
    Next
End Sub

Sub SetLamp(nr, value)
    If value <> LampState(nr) Then
        LampState(nr) = abs(value)
        FadingLevel(nr) = abs(value) + 4
    End If
End Sub

Sub SetModLamp(nr, level)
	FlashLevel(nr) = level /150 'lights & flashers
End Sub

' Lights: old method, using 4 images

Sub FadeL(nr, object, a, b, c, d)
    Select Case FadingLevel(nr)
        Case 4:object.image = b:FadingLevel(nr) = 6                   'fading to off...
        Case 5:object.image = a:object.State = 1:FadingLevel(nr) = 1   'ON
        Case 6, 7, 8:FadingLevel(nr) = FadingLevel(nr) + 1           'wait
        Case 9:object.image = c:FadingLevel(nr) = FadingLevel(nr) + 1 'fading...
        Case 10, 11, 12:FadingLevel(nr) = FadingLevel(nr) + 1        'wait
        Case 13:object.image = d:object.State = 0:FadingLevel(nr) = 0  'Off
    End Select
End Sub

Sub FadeLm(nr, object, a, b, c, d)
    Select Case FadingLevel(nr)
        Case 4:object.image = b
        Case 5:object.image = a
        Case 9:object.image = c
        Case 13:object.image = d
    End Select
End Sub

' Lights: used for VP10 standard lights, the fading is handled by VP itself

Sub NFadeL(nr, object)
    Select Case FadingLevel(nr)
        Case 4:object.state = 0:FadingLevel(nr) = 0
        Case 5:object.state = 1:FadingLevel(nr) = 1
    End Select
End Sub

Sub NFadeLm(nr, object) ' used for multiple lights
    Select Case FadingLevel(nr)
        Case 4:object.state = 0
        Case 5:object.state = 1
    End Select
End Sub

Sub LightMod(nr, object) ' modulated lights used as flashers
    Object.IntensityScale = FlashLevel(nr)
	Object.State = 1
End Sub

'Ramps & Primitives used as 4 step fading lights
'a,b,c,d are the images used from on to off

Sub FadeObj(nr, object, a, b, c, d)
    Select Case FadingLevel(nr)
        Case 4:object.image = b:FadingLevel(nr) = 6                   'fading to off...
        Case 5:object.image = a:FadingLevel(nr) = 1                   'ON
        Case 6, 7, 8:FadingLevel(nr) = FadingLevel(nr) + 1            'wait
        Case 9:object.image = c:FadingLevel(nr) = FadingLevel(nr) + 1 'fading...
        Case 10, 11, 12:FadingLevel(nr) = FadingLevel(nr) + 1         'wait
        Case 13:object.image = d:FadingLevel(nr) = 0                  'Off
    End Select
End Sub

Sub FadeObjm(nr, object, a, b, c, d)
    Select Case FadingLevel(nr)
        Case 4:object.image = b
        Case 5:object.image = a
        Case 9:object.image = c
        Case 13:object.image = d
    End Select
End Sub

Sub NFadeObj(nr, object, a, b)
    Select Case FadingLevel(nr)
        Case 4:object.image = b:FadingLevel(nr) = 0 'off
        Case 5:object.image = a:FadingLevel(nr) = 1 'on
    End Select
End Sub

Sub NFadeObjm(nr, object, a, b)
    Select Case FadingLevel(nr)
        Case 4:object.image = b
        Case 5:object.image = a
    End Select
End Sub

' Flasher objects

Sub Flash(nr, object)
    Select Case FadingLevel(nr)
        Case 4 'off
            FlashLevel(nr) = FlashLevel(nr) - FlashSpeedDown(nr)
            If FlashLevel(nr) < FlashMin(nr) Then
                FlashLevel(nr) = FlashMin(nr)
                FadingLevel(nr) = 0 'completely off
            End if
            Object.IntensityScale = Lumens*FlashLevel(nr)
        Case 5 ' on
            FlashLevel(nr) = FlashLevel(nr) + FlashSpeedUp(nr)
            If FlashLevel(nr) > FlashMax(nr) Then
                FlashLevel(nr) = FlashMax(nr)
                FadingLevel(nr) = 1 'completely on
            End if
            Object.IntensityScale = Lumens*FlashLevel(nr)
    End Select
End Sub

Sub Flashm(nr, object) 'multiple flashers, it just sets the flashlevel
    Object.IntensityScale = Lumens*FlashLevel(nr)
End Sub

Sub FlashMod(nr, object) 'sets the flashlevel from the SolModCallback
    Object.IntensityScale = Lumens*FlashLevel(nr)
End Sub

Sub FastFlash(nr, object)
    Select Case FadingLevel(nr)
		Case 4:object.Visible = 0:FadingLevel(nr) = 0 'off
		Case 5:object.Visible = 1:FadingLevel(nr) = 1 'on
		Object.IntensityScale = Lumens*FlashMax(nr)
    End Select
End Sub

Sub FastFlashm(nr, object)
    Select Case FadingLevel(nr)
		Case 4:object.Visible = 0 'off
		Case 5:object.Visible = 1 'on
		Object.IntensityScale = Lumens*FlashMax(nr)
    End Select
End Sub

' Objects DisableLighting

Sub FlashDL(nr, Limite, object)
    Select Case FadingLevel(nr)
        Case 4 'off
            FlashLevel(nr) = FlashLevel(nr) - DLSpeedDown(nr)
            If FlashLevel(nr) < FlashMin(nr) Then
                FlashLevel(nr) = FlashMin(nr)
                FadingLevel(nr) = 0 'completely off
            End if
            Object.BlendDisableLighting = Limite*FlashLevel(nr)
        Case 5 ' on
            FlashLevel(nr) = FlashLevel(nr) + DLSpeedUp(nr)
            If FlashLevel(nr) > FlashMax(nr) Then
                FlashLevel(nr) = FlashMax(nr)
                FadingLevel(nr) = 1 'completely on
            End if
            Object.BlendDisableLighting = Limite*FlashLevel(nr)
    End Select
End Sub

Sub FlashDLm(nr, Limite, object) 'multiple objects, it just sets the flashlevel
    Object.BlendDisableLighting = Limite*FlashLevel(nr)
End Sub

Sub FastDL(nr, Limite, object)
    Select Case FadingLevel(nr)
		Case 4:object.BlendDisableLighting = 0:FadingLevel(nr) = 0 'off
		Case 5:object.BlendDisableLighting = 1:FadingLevel(nr) = 1 'on
		Object.BlendDisableLighting = Limite*FlashMax(nr)
    End Select
End Sub

Sub FastDLm(nr, Limite, object)
    Select Case FadingLevel(nr)
		Case 4:object.BlendDisableLighting = 0 'off
		Case 5:object.BlendDisableLighting = 1 'on
		Object.BlendDisableLighting = Limite*FlashMax(nr)
    End Select
End Sub

' Desktop Objects: Reels & texts (you may also use lights on the desktop)

' Reels

Sub FadeR(nr, object)
    Select Case FadingLevel(nr)
        Case 4:object.SetValue 1:FadingLevel(nr) = 6                   'fading to off...
        Case 5:object.SetValue 0:FadingLevel(nr) = 1                   'ON
        Case 6, 7, 8:FadingLevel(nr) = FadingLevel(nr) + 1             'wait
        Case 9:object.SetValue 2:FadingLevel(nr) = FadingLevel(nr) + 1 'fading...
        Case 10, 11, 12:FadingLevel(nr) = FadingLevel(nr) + 1          'wait
        Case 13:object.SetValue 3:FadingLevel(nr) = 0                  'Off
    End Select
End Sub

Sub FadeRm(nr, object)
    Select Case FadingLevel(nr)
        Case 4:object.SetValue 1
        Case 5:object.SetValue 0
        Case 9:object.SetValue 2
        Case 3:object.SetValue 3
    End Select
End Sub

'Texts

Sub NFadeT(nr, object, message)
    Select Case FadingLevel(nr)
        Case 4:object.Text = "":FadingLevel(nr) = 0
        Case 5:object.Text = message:FadingLevel(nr) = 1
    End Select
End Sub

Sub NFadeTm(nr, object, b)
    Select Case FadingLevel(nr)
        Case 4:object.Text = ""
        Case 5:object.Text = message
    End Select
End Sub

' *********************************************************************
' 					Wall, rubber and metal hit sounds
' *********************************************************************

Sub Rubbers_Hit(idx):PlaySoundAtBallVol "rubber1", RubVol:End Sub

' *********************************************************************
'                      Supporting Ball & Sound Functions
' *********************************************************************

Function Vol(ball) ' Calculates the Volume of the sound based on the ball speed
    Vol = Csng(BallVel(ball) ^2 / 2000)
End Function

Function Pan(ball) ' Calculates the pan for a ball based on the X position on the table. "table1" is the name of the table
    Dim tmp
    tmp = ball.x * 2 / Table1.width-1
    If tmp > 0 Then
        Pan = Csng(tmp ^10)
    Else
        Pan = Csng(-((- tmp) ^10))
    End If
End Function

Function Pitch(ball) ' Calculates the pitch of the sound based on the ball speed
    Pitch = BallVel(ball) * 20
End Function

Function BallVel(ball) 'Calculates the ball speed
    BallVel = (SQR((ball.VelX ^2) + (ball.VelY ^2)))
End Function

Function AudioFade(ball) 'only on VPX 10.4 and newer
    Dim tmp
    tmp = ball.y * 2 / Table1.height-1
    If tmp > 0 Then
        AudioFade = Csng(tmp ^10)
    Else
        AudioFade = Csng(-((- tmp) ^10))
    End If
End Function

'*** Determines if a Points (px,py) is inside a 4 point polygon A-D in Clockwise/CCW order
Function InRect(px,py,ax,ay,bx,by,cx,cy,dx,dy)
	Dim AB, BC, CD, DA
	AB = (bx*py) - (by*px) - (ax*py) + (ay*px) + (ax*by) - (ay*bx)
	BC = (cx*py) - (cy*px) - (bx*py) + (by*px) + (bx*cy) - (by*cx)
	CD = (dx*py) - (dy*px) - (cx*py) + (cy*px) + (cx*dy) - (cy*dx)
	DA = (ax*py) - (ay*px) - (dx*py) + (dy*px) + (dx*ay) - (dy*ax)
 
	If (AB <= 0 AND BC <=0 AND CD <= 0 AND DA <= 0) Or (AB >= 0 AND BC >=0 AND CD >= 0 AND DA >= 0) Then
		InRect = True
	Else
		InRect = False       
	End If
End Function

'*****************************************
'PlaySound(string, int loopcount, float volume, float pan, float randompitch, int pitch, bool useexisting, bool restart, float front_rear_fade)

Sub PlaySoundAt(soundname, tableobj) 'play sound at X and Y position of an object, mostly bumpers, flippers and other fast objects
    PlaySound soundname, 0, 1, Pan(tableobj), 0, 0, 0, 0, AudioFade(tableobj)
End Sub

Sub PlaySoundAtVol(soundname, tableobj, Vol) 'play sound at X and Y position of an object, mostly bumpers, flippers and other fast objects
    PlaySound soundname, 0, Vol, Pan(tableobj), 0, 0, 0, 0, AudioFade(tableobj)
End Sub

Sub PlaySoundAtVolLoop(soundname, tableobj, Vol) 'play sound at X and Y position of an object, mostly bumpers, flippers and other fast objects
    PlaySound soundname, -1, Vol, Pan(tableobj), 0, 0, 1, 1, AudioFade(tableobj)
End Sub

Sub PlaySoundAtVolPitch(soundname, tableobj, Vol, Pitch) 'play sound at X and Y position of an object, mostly bumpers, flippers and other fast objects
    PlaySound soundname, 0, Vol, Pan(tableobj), 0, Pitch, 0, 0, AudioFade(tableobj)
End Sub

Sub PlaySoundAtBall(soundname) ' play a sound at the ball position, like rubbers, targets
    PlaySound soundname, 0, Vol(ActiveBall), pan(ActiveBall), 0, Pitch(ActiveBall), 0, 0, AudioFade(ActiveBall)
End Sub

Sub PlaySoundAtBallVol(soundname, VolMult) ' play a sound at the ball position, like rubbers, targets
    PlaySound soundname, 0, Vol(ActiveBall) * VolMult, pan(ActiveBall), 0, Pitch(ActiveBall), 0, 0, AudioFade(ActiveBall)
End Sub

'*******************************************
'   JP's VP10 Rolling Sounds + Ballshadow
' uses a collection of shadows, aBallShadow
'*******************************************

Const tnob = 19 ' total number of balls
Const lob = 0   'number of locked balls
ReDim rolling(tnob)
InitRolling

Sub InitRolling
    Dim i
    For i = 0 to tnob
        rolling(i) = False
    Next
End Sub

Sub RollingTimer_Timer()
    Dim BOT, b, momfactorx, momfactory, momfactorz
    BOT = GetBalls

    ' stop the sound of deleted balls
    For b = UBound(BOT) + 1 to tnob
		rolling(b) = False
		aBallShadow(b).Visible = 0
		StopSound("fx_ballrolling" & b)
		StopSound("fx_Rolling_Plastic" & b)
		StopSound("fx_Rolling_Metal" & b)
    Next

    ' exit the sub if no balls on the table
    If UBound(BOT) = lob - 1 Then Exit Sub

    ' play the rolling sound for each ball and draw the shadow
    For b = lob to UBound(BOT)

		aBallShadow(b).X = BOT(b).X
		aBallShadow(b).Y = BOT(b).Y
		aBallShadow(b).Height = BOT(b).Z - (BallSize / 2)+1

        If BallVel(BOT(b)) > 1 Then
            rolling(b) = True

'Playfield
			If BOT(b).z < 30 Then
					StopSound("fx_Rolling_Metal" & b):StopSound("fx_Rolling_Plastic" & b)
					PlaySound("fx_ballrolling" & b), -1, Vol(BOT(b) )*RolVol, Pan(BOT(b) ), 0, Pitch(BOT(b) ), 1, 0, AudioFade(BOT(b) )
			Else

'Wire Ramps
'VUK Ce
				If InRect(BOT(b).x, BOT(b).y, 465,138,890,398,860,451,427,202) And BOT(b).z > 150 Then
					StopSound("fx_ballrolling" & b):StopSound("fx_Rolling_Plastic" & b)
					PlaySound("fx_Rolling_Metal" & b), -1, Vol(BOT(b) )*3*MroVol, Pan(BOT(b) ), 0, Pitch(BOT(b) )*0.1, 1, 0, AudioFade(BOT(b) )
'VUK Sx
			ElseIf InRect(BOT(b).x, BOT(b).y, 37,974,112,967,144,1454,88,1459) And BOT(b).z > 60 Then
					StopSound("fx_ballrolling" & b):StopSound("fx_Rolling_Plastic" & b)
					PlaySound("fx_Rolling_Metal" & b), -1, Vol(BOT(b) )*3*MroVol, Pan(BOT(b) ), 0, Pitch(BOT(b) )*0.1, 1, 0, AudioFade(BOT(b) )

'Plastic Ramps
			Else 
					StopSound("fx_Rolling_Metal" & b):StopSound("fx_ballrolling" & b)
					PlaySound("fx_Rolling_Plastic" & b), -1, Vol(BOT(b) )*3*ProVol, Pan(BOT(b) ), 0, Pitch(BOT(b) ), 1, 0, AudioFade(BOT(b) ) 
			End If
			End If

        Else
            If rolling(b) = True Then
                StopSound("fx_ballrolling" & b)
				StopSound("fx_Rolling_Plastic" & b)
				StopSound("fx_Rolling_Metal" & b)
                rolling(b) = False
            End If
        End If

		' play ball drop sounds
		If BOT(b).VelZ < -8 And BOT(b).z < 50 And BOT(b).z > 27 Then 'height adjust for ball drop sounds
			PlaySound ("fx_ballhit" & b), 0, (ABS(BOT(b).velz)/17)*DroVol, Pan(BOT(b)), 0, Pitch(BOT(b)), 1, 0, AudioFade(BOT(b))
		End If

		If InRect(BOT(b).x, BOT(b).y, 881,395,928,423,928,480,862,450) And BOT(b).VelZ < -1 And BOT(b).z < 115 And BOT(b).z > 93 Then 'height adjust for ball drop sounds
			PlaySound "WoodHit", 0, (ABS(BOT(b).velz)/17)*CujVol, Pan(BOT(b)), 0, Pitch(BOT(b)), 1, 0, AudioFade(BOT(b))
		End If

		' Ball Shadow
		If BallSHW = 1 Then
			aBallShadow(b).Visible = 1
		Else
			aBallShadow(b).Visible = 0
		End If

        ' ball momentum control
        If BOT(b).AngMomX AND BOT(b).AngMomY AND BOT(b).AngMomZ <> 0 And MomOn = 1 Then
            momfactorx = ABS(Maxmom / BOT(b).AngMomX)
            momfactory = ABS(Maxmom / BOT(b).AngMomY)
            momfactorz = ABS(Maxmom / BOT(b).AngMomZ)
            If momfactorx < 1 And MomOn = 1 Then
                BOT(b).AngMomX = BOT(b).AngMomX * momfactorx
                BOT(b).AngMomY = BOT(b).AngMomY * momfactorx
                BOT(b).AngMomZ = BOT(b).AngMomZ * momfactorx
            End If
            If momfactory < 1 And MomOn = 1 Then
                BOT(b).AngMomX = BOT(b).AngMomX * momfactory
                BOT(b).AngMomY = BOT(b).AngMomY * momfactory
                BOT(b).AngMomZ = BOT(b).AngMomZ * momfactory
            End If
            If momfactorz < 1 And MomOn = 1 Then
                BOT(b).AngMomX = BOT(b).AngMomX * momfactorz
                BOT(b).AngMomY = BOT(b).AngMomY * momfactorz
                BOT(b).AngMomZ = BOT(b).AngMomZ * momfactorz
            End If
        End If

    Next
End Sub

'**********************
' Ball Collision Sound
'**********************

Sub OnBallBallCollision(ball1, ball2, velocity)
    PlaySound("fx_collide"), 0, Csng(ColVol*((velocity) ^2 / 200)), Pan(ball1), 0, Pitch(ball1), 0, 0, AudioFade(ball1)
End Sub

'******************
' RealTime Updates
'******************
Set MotorCallback = GetRef("GameTimer")

Sub GameTimer
	UpdateFlipperLogos
 If RodneyAnim = 1 Then
	TrackSounds
End If
End Sub

Dim PI
PI = Round(4 * Atn(1), 6) '3.1415926535897932384626433832795

Sub UpdateFlipperLogos
	FlipperSx.RotZ = LeftFlipper.CurrentAngle
	FlipperDx.RotZ = RightFlipper.CurrentAngle
	pSpinnerRod.TransY = sin((sw20.CurrentAngle+180) * (PI/180)) * 8
	pSpinnerRod.TransZ = sin((sw20.CurrentAngle- 90) * (PI/180)) * 8
	pSpinnerRod.RotX = sin(sw20.CurrentAngle * (PI/180)) * 6
End Sub

'*********************
' Leds Display DT
'*********************

Dim Digits(40)

Digits(0) = Array(a00, a05, a0c, a0d, a08, a01, a06, a0f, a02, a03, a04, a07, a0b, a0a, a09, a0e)
Digits(1) = Array(a10, a15, a1c, a1d, a18, a11, a16, a1f, a12, a13, a14, a17, a1b, a1a, a19, a1e)
Digits(2) = Array(a20, a25, a2c, a2d, a28, a21, a26, a2f, a22, a23, a24, a27, a2b, a2a, a29, a2e)
Digits(3) = Array(a30, a35, a3c, a3d, a38, a31, a36, a3f, a32, a33, a34, a37, a3b, a3a, a39, a3e)
Digits(4) = Array(a40, a45, a4c, a4d, a48, a41, a46, a4f, a42, a43, a44, a47, a4b, a4a, a49, a4e)
Digits(5) = Array(a50, a55, a5c, a5d, a58, a51, a56, a5f, a52, a53, a54, a57, a5b, a5a, a59, a5e)
Digits(6) = Array(a60, a65, a6c, a6d, a68, a61, a66, a6f, a62, a63, a64, a67, a6b, a6a, a69, a6e)
Digits(7) = Array(a70, a75, a7c, a7d, a78, a71, a76, a7f, a72, a73, a74, a77, a7b, a7a, a79, a7e)
Digits(8) = Array(a80, a85, a8c, a8d, a88, a81, a86, a8f, a82, a83, a84, a87, a8b, a8a, a89, a8e)
Digits(9) = Array(a90, a95, a9c, a9d, a98, a91, a96, a9f, a92, a93, a94, a97, a9b, a9a, a99, a9e)
Digits(10) = Array(aa0, aa5, aac, aad, aa8, aa1, aa6, aaf, aa2, aa3, aa4, aa7, aab, aaa, aa9, aae)
Digits(11) = Array(ab0, ab5, abc, abd, ab8, ab1, ab6, abf, ab2, ab3, ab4, ab7, abb, aba, ab9, abe)
Digits(12) = Array(ac0, ac5, acc, acd, ac8, ac1, ac6, acf, ac2, ac3, ac4, ac7, acb, aca, ac9, ace)
Digits(13) = Array(ad0, ad5, adc, add, ad8, ad1, ad6, adf, ad2, ad3, ad4, ad7, adb, ada, ad9, ade)
Digits(14) = Array(ae0, ae5, aec, aed, ae8, ae1, ae6, aef, ae2, ae3, ae4, ae7, aeb, aea, ae9, aee)
Digits(15) = Array(af0, af5, afc, afd, af8, af1, af6, aff, af2, af3, af4, af7, afb, afa, af9, afe)

Digits(16) = Array(b00, b05, b0c, b0d, b08, b01, b06, b0f, b02, b03, b04, b07, b0b, b0a, b09, b0e)
Digits(17) = Array(b10, b15, b1c, b1d, b18, b11, b16, b1f, b12, b13, b14, b17, b1b, b1a, b19, b1e)
Digits(18) = Array(b20, b25, b2c, b2d, b28, b21, b26, b2f, b22, b23, b24, b27, b2b, b2a, b29, b2e)
Digits(19) = Array(b30, b35, b3c, b3d, b38, b31, b36, b3f, b32, b33, b34, b37, b3b, b3a, b39, b3e)
Digits(20) = Array(b40, b45, b4c, b4d, b48, b41, b46, b4f, b42, b43, b44, b47, b4b, b4a, b49, b4e)
Digits(21) = Array(b50, b55, b5c, b5d, b58, b51, b56, b5f, b52, b53, b54, b57, b5b, b5a, b59, b5e)
Digits(22) = Array(b60, b65, b6c, b6d, b68, b61, b66, b6f, b62, b63, b64, b67, b6b, b6a, b69, b6e)
Digits(23) = Array(b70, b75, b7c, b7d, b78, b71, b76, b7f, b72, b73, b74, b77, b7b, b7a, b79, b7e)
Digits(24) = Array(b80, b85, b8c, b8d, b88, b81, b86, b8f, b82, b83, b84, b87, b8b, b8a, b89, b8e)
Digits(25) = Array(b90, b95, b9c, b9d, b98, b91, b96, b9f, b92, b93, b94, b97, b9b, b9a, b99, b9e)
Digits(26) = Array(ba0, ba5, bac, bad, ba8, ba1, ba6, baf, ba2, ba3, ba4, ba7, bab, baa, ba9, bae)
Digits(27) = Array(bb0, bb5, bbc, bbd, bb8, bb1, bb6, bbf, bb2, bb3, bb4, bb7, bbb, bba, bb9, bbe)
Digits(28) = Array(bc0, bc5, bcc, bcd, bc8, bc1, bc6, bcf, bc2, bc3, bc4, bc7, bcb, bca, bc9, bce)
Digits(29) = Array(bd0, bd5, bdc, bdd, bd8, bd1, bd6, bdf, bd2, bd3, bd4, bd7, bdb, bda, bd9, bde)
Digits(30) = Array(be0, be5, bec, bed, be8, be1, be6, bef, be2, be3, be4, be7, beb, bea, be9, bee)
Digits(31) = Array(bf0, bf5, bfc, bfd, bf8, bf1, bf6, bff, bf2, bf3, bf4, bf7, bfb, bfa, bf9, bfe)

Digits(32) = Array(c00, c05, c0c, c0d, c08, c01, c06, c0f, c02, c03, c04, c07, c0b, c0a, c09, c0e)
Digits(33) = Array(c10, c15, c1c, c1d, c18, c11, c16, c1f, c12, c13, c14, c17, c1b, c1a, c19, c1e)
Digits(34) = Array(c20, c25, c2c, c2d, c28, c21, c26, c2f, c22, c23, c24, c27, c2b, c2a, c29, c2e)
Digits(35) = Array(c30, c35, c3c, c3d, c38, c31, c36, c3f, c32, c33, c34, c37, c3b, c3a, c39, c3e)
Digits(36) = Array(c40, c45, c4c, c4d, c48, c41, c46, c4f, c42, c43, c44, c47, c4b, c4a, c49, c4e)
Digits(37) = Array(c50, c55, c5c, c5d, c58, c51, c56, c5f, c52, c53, c54, c57, c5b, c5a, c59, c5e)
Digits(38) = Array(c60, c65, c6c, c6d, c68, c61, c66, c6f, c62, c63, c64, c67, c6b, c6a, c69, c6e)
Digits(39) = Array(c70, c75, c7c, c7d, c78, c71, c76, c7f, c72, c73, c74, c77, c7b, c7a, c79, c7e)

Sub UpdateLeds()
	Dim ChgLED, ii, num, chg, stat, obj
	ChgLED = Controller.ChangedLEDs(&Hffffffff, &Hffffffff)
	If Not IsEmpty(ChgLED) Then
		For ii = 0 To UBound(chgLED)
			num = chgLED(ii, 0):chg = chgLED(ii, 1):stat = chgLED(ii, 2)
			For Each obj In Digits(num)
				If chg And 1 Then obj.State = stat And 1
				chg = chg \ 2:stat = stat \ 2
			Next
		Next
	End If
End Sub

'*****************
' Leds Display FSS
'*****************

Dim DigitsF(40)

DigitsF(0) = Array(fa00, fa05, fa0c, fa0d, fa08, fa01, fa06, fa0f, fa02, fa03, fa04, fa07, fa0b, fa0a, fa09, fa0e)
DigitsF(1) = Array(fa10, fa15, fa1c, fa1d, fa18, fa11, fa16, fa1f, fa12, fa13, fa14, fa17, fa1b, fa1a, fa19, fa1e)
DigitsF(2) = Array(fa20, fa25, fa2c, fa2d, fa28, fa21, fa26, fa2f, fa22, fa23, fa24, fa27, fa2b, fa2a, fa29, fa2e)
DigitsF(3) = Array(fa30, fa35, fa3c, fa3d, fa38, fa31, fa36, fa3f, fa32, fa33, fa34, fa37, fa3b, fa3a, fa39, fa3e)
DigitsF(4) = Array(fa40, fa45, fa4c, fa4d, fa48, fa41, fa46, fa4f, fa42, fa43, fa44, fa47, fa4b, fa4a, fa49, fa4e)
DigitsF(5) = Array(fa50, fa55, fa5c, fa5d, fa58, fa51, fa56, fa5f, fa52, fa53, fa54, fa57, fa5b, fa5a, fa59, fa5e)
DigitsF(6) = Array(fa60, fa65, fa6c, fa6d, fa68, fa61, fa66, fa6f, fa62, fa63, fa64, fa67, fa6b, fa6a, fa69, fa6e)
DigitsF(7) = Array(fa70, fa75, fa7c, fa7d, fa78, fa71, fa76, fa7f, fa72, fa73, fa74, fa77, fa7b, fa7a, fa79, fa7e)
DigitsF(8) = Array(fa80, fa85, fa8c, fa8d, fa88, fa81, fa86, fa8f, fa82, fa83, fa84, fa87, fa8b, fa8a, fa89, fa8e)
DigitsF(9) = Array(fa90, fa95, fa9c, fa9d, fa98, fa91, fa96, fa9f, fa92, fa93, fa94, fa97, fa9b, fa9a, fa99, fa9e)
DigitsF(10) = Array(faa0, faa5, faac, faad, faa8, faa1, faa6, faaf, faa2, faa3, faa4, faa7, faab, faaa, faa9, faae)
DigitsF(11) = Array(fab0, fab5, fabc, fabd, fab8, fab1, fab6, fabf, fab2, fab3, fab4, fab7, fabb, faba, fab9, fabe)
DigitsF(12) = Array(fac0, fac5, facc, facd, fac8, fac1, fac6, facf, fac2, fac3, fac4, fac7, facb, faca, fac9, face)
DigitsF(13) = Array(fad0, fad5, fadc, fadd, fad8, fad1, fad6, fadf, fad2, fad3, fad4, fad7, fadb, fada, fad9, fade)
DigitsF(14) = Array(fae0, fae5, faec, faed, fae8, fae1, fae6, faef, fae2, fae3, fae4, fae7, faeb, faea, fae9, faee)
DigitsF(15) = Array(faf0, faf5, fafc, fafd, faf8, faf1, faf6, faff, faf2, faf3, faf4, faf7, fafb, fafa, faf9, fafe)

DigitsF(16) = Array(fb00, fb05, fb0c, fb0d, fb08, fb01, fb06, fb0f, fb02, fb03, fb04, fb07, fb0b, fb0a, fb09, fb0e)
DigitsF(17) = Array(fb10, fb15, fb1c, fb1d, fb18, fb11, fb16, fb1f, fb12, fb13, fb14, fb17, fb1b, fb1a, fb19, fb1e)
DigitsF(18) = Array(fb20, fb25, fb2c, fb2d, fb28, fb21, fb26, fb2f, fb22, fb23, fb24, fb27, fb2b, fb2a, fb29, fb2e)
DigitsF(19) = Array(fb30, fb35, fb3c, fb3d, fb38, fb31, fb36, fb3f, fb32, fb33, fb34, fb37, fb3b, fb3a, fb39, fb3e)
DigitsF(20) = Array(fb40, fb45, fb4c, fb4d, fb48, fb41, fb46, fb4f, fb42, fb43, fb44, fb47, fb4b, fb4a, fb49, fb4e)
DigitsF(21) = Array(fb50, fb55, fb5c, fb5d, fb58, fb51, fb56, fb5f, fb52, fb53, fb54, fb57, fb5b, fb5a, fb59, fb5e)
DigitsF(22) = Array(fb60, fb65, fb6c, fb6d, fb68, fb61, fb66, fb6f, fb62, fb63, fb64, fb67, fb6b, fb6a, fb69, fb6e)
DigitsF(23) = Array(fb70, fb75, fb7c, fb7d, fb78, fb71, fb76, fb7f, fb72, fb73, fb74, fb77, fb7b, fb7a, fb79, fb7e)
DigitsF(24) = Array(fb80, fb85, fb8c, fb8d, fb88, fb81, fb86, fb8f, fb82, fb83, fb84, fb87, fb8b, fb8a, fb89, fb8e)
DigitsF(25) = Array(fb90, fb95, fb9c, fb9d, fb98, fb91, fb96, fb9f, fb92, fb93, fb94, fb97, fb9b, fb9a, fb99, fb9e)
DigitsF(26) = Array(fba0, fba5, fbac, fbad, fba8, fba1, fba6, fbaf, fba2, fba3, fba4, fba7, fbab, fbaa, fba9, fbae)
DigitsF(27) = Array(fbb0, fbb5, fbbc, fbbd, fbb8, fbb1, fbb6, fbbf, fbb2, fbb3, fbb4, fbb7, fbbb, fbba, fbb9, fbbe)
DigitsF(28) = Array(fbc0, fbc5, fbcc, fbcd, fbc8, fbc1, fbc6, fbcf, fbc2, fbc3, fbc4, fbc7, fbcb, fbca, fbc9, fbce)
DigitsF(29) = Array(fbd0, fbd5, fbdc, fbdd, fbd8, fbd1, fbd6, fbdf, fbd2, fbd3, fbd4, fbd7, fbdb, fbda, fbd9, fbde)
DigitsF(30) = Array(fbe0, fbe5, fbec, fbed, fbe8, fbe1, fbe6, fbef, fbe2, fbe3, fbe4, fbe7, fbeb, fbea, fbe9, fbee)
DigitsF(31) = Array(fbf0, fbf5, fbfc, fbfd, fbf8, fbf1, fbf6, fbff, fbf2, fbf3, fbf4, fbf7, fbfb, fbfa, fbf9, fbfe)

DigitsF(32) = Array(fc00, fc05, fc0c, fc0d, fc08, fc01, fc06, fc0f, fc02, fc03, fc04, fc07, fc0b, fc0a, fc09, fc0e)
DigitsF(33) = Array(fc10, fc15, fc1c, fc1d, fc18, fc11, fc16, fc1f, fc12, fc13, fc14, fc17, fc1b, fc1a, fc19, fc1e)
DigitsF(34) = Array(fc20, fc25, fc2c, fc2d, fc28, fc21, fc26, fc2f, fc22, fc23, fc24, fc27, fc2b, fc2a, fc29, fc2e)
DigitsF(35) = Array(fc30, fc35, fc3c, fc3d, fc38, fc31, fc36, fc3f, fc32, fc33, fc34, fc37, fc3b, fc3a, fc39, fc3e)
DigitsF(36) = Array(fc40, fc45, fc4c, fc4d, fc48, fc41, fc46, fc4f, fc42, fc43, fc44, fc47, fc4b, fc4a, fc49, fc4e)
DigitsF(37) = Array(fc50, fc55, fc5c, fc5d, fc58, fc51, fc56, fc5f, fc52, fc53, fc54, fc57, fc5b, fc5a, fc59, fc5e)
DigitsF(38) = Array(fc60, fc65, fc6c, fc6d, fc68, fc61, fc66, fc6f, fc62, fc63, fc64, fc67, fc6b, fc6a, fc69, fc6e)
DigitsF(39) = Array(fc70, fc75, fc7c, fc7d, fc78, fc71, fc76, fc7f, fc72, fc73, fc74, fc77, fc7b, fc7a, fc79, fc7e)

Sub UpdateLedsF
    Dim ChgLED, ii, num, chg, stat, obj
    ChgLED = Controller.ChangedLEDs(&Hffffffff, &Hffffffff)
    If Not IsEmpty(ChgLED)Then
        For ii = 0 To UBound(chgLED)
            num = chgLED(ii, 0):chg = chgLED(ii, 1):stat = chgLED(ii, 2)
            For Each obj In DigitsF(num)
                If chg And 1 Then obj.Visible = stat And 1
                chg = chg \ 2:stat = stat \ 2
            Next
        Next
    End If
End Sub

'********************************
' Sound Subs from Destruk's table
'********************************

'Music & Sound Stuff
Sub TrackSounds
    Dim NewSounds, ii, Snd
    NewSounds = Controller.NewSoundCommands
    If Not IsEmpty(NewSounds) Then
        For ii = 0 To UBound(NewSounds)
            Snd = NewSounds(ii, 0)
            If Snd = 6 Then JawAnim:AnimStep=19				'006  06-Excellent
            If Snd = 7 Then JawAnim:AnimStep=17				'007  07-Extraball
            If Snd = 20 Then JawAnim:AnimStep=17			'020  14-Million
            If Snd = 21 Then JawAnim:AnimStep=3				'021  15-Advance souvenirs target for extraball
            If Snd = 23 Then JawAnim:AnimStep=11			'023  17-The arcade target is lit
            If Snd = 24 Then JawAnim:AnimStep=17			'024  18-Lit the birth
            If Snd = 25 Then JawAnim:AnimStep=13			'025  19-You wont to pet my monkey
            If Snd = 26 Then JawAnim:AnimStep=11			'026  1a-Ho ho ho ho ha ha ha ha
            If Snd = 27 Then JawAnim:AnimStep=15			'027  1b-Later Gator
            If Snd = 28 Then JawAnim:AnimStep=15			'028  1c-Nice shoot man
            If Snd = 29 Then JawAnim:AnimStep=7				'029  1d-Shoot the rapids to light the whirlpool million
            If Snd = 30 Then JawAnim:AnimStep=11			'030  1e-The whirlpool million is lit
            If Snd = 33 Then JawAnim:AnimStep=7				'033  21-You got absolutly nothing
            If Snd = 34 Then JawAnim:AnimStep=11			'034  22-You advance the boomerang
            If Snd = 35 Then JawAnim:AnimStep=11			'035  23-You advance the splash
            If Snd = 36 Then JawAnim:AnimStep=11			'036  24-You advance the whirlpool
            If Snd = 37 Then JawAnim:AnimStep=11			'037  25-You advance the rapids
            If Snd = 38 Then JawAnim:AnimStep=13			'038  26-You advance the pipeline
            If Snd = 39 Then JawAnim:AnimStep=17			'039  27-Shoot the ball
            If Snd = 40 Then JawAnim:AnimStep=15			'040  28-He he heeee
            If Snd = 46 Then JawAnim:AnimStep=1				'046  2e-Shoot all lights lit to light super jackpot
            If Snd = 47 Then JawAnim:AnimStep=5				'047  2f-Shoot all lights lit to light jackpot
            If Snd = 48 Then JawAnim:AnimStep=5				'048  30-Shoot the rapids for super jackpot
            If Snd = 49 Then JawAnim:AnimStep=9				'049  31-Shoot the rapids for jackpot
            If Snd = 51 Then JawAnim:AnimStep=5				'051  33-Shoot all lights lit for extraball
            If Snd = 52 Then JawAnim:AnimStep=13			'052  34-Shoot the spinner
            If Snd = 53 Then JawAnim:AnimStep=13			'053  35-Your time is up
            If Snd = 54 Then JawAnim:AnimStep=9				'054  36-Hit the three million target
            If Snd = 56 Then JawAnim:AnimStep=13			'056  38-Hey man shoot again
            If Snd = 57 Then JawAnim:AnimStep=15			'057  39-You shoot to hard
            If Snd = 58 Then JawAnim:LegsAnim:AnimStep=17	'058  3a-Shoot gently
            If Snd = 59 Then JawAnim:AnimStep=11			'059  3b-Shoot the pipeline for multiball
            If Snd = 60 Then JawAnim:AnimStep=11			'060  3c-One more for the record
            If Snd = 61 Then JawAnim:AnimStep=11			'061  3d-One more for the whirlpool
            If Snd = 62 Then JawAnim:AnimStep=13			'062  3e-One more for the boomerang
            If Snd = 63 Then JawAnim:AnimStep=11			'063  3f-One more for the splash
            If Snd = 65 Then JawAnim:AnimStep=13			'065  41-One more for the rapids
            If Snd = 66 Then JawAnim:AnimStep=13			'066  42-One more for the pipeline
            If Snd = 67 Then JawAnim:AnimStep=15			'067  43-One more for double
            If Snd = 68 Then JawAnim:AnimStep=15			'068  44-you shoot too sofly
            If Snd = 70 Then JawAnim:AnimStep=13			'070  46-Extra special
            If Snd = 71 Then JawAnim:AnimStep=13			'071  47-Super jackpot
            If Snd = 72 Then JawAnim:AnimStep=15			'072  48-Super score
            If Snd = 73 Then JawAnim:AnimStep=13			'073  49-Three million
            If Snd = 74 Then JawAnim:AnimStep=19			'074  4a-Super
            If Snd = 77 Then JawAnim:AnimStep=21			'077  4d-One
            If Snd = 78 Then JawAnim:AnimStep=21			'078  4e-Two
            If Snd = 79 Then JawAnim:AnimStep=21			'079  4f-Three
            If Snd = 80 Then JawAnim:AnimStep=21			'080  50-Four
            If Snd = 81 Then JawAnim:AnimStep=21			'081  51-Five
            If Snd = 85 Then JawAnim:AnimStep=9				'085  55-Get all animals for special
            If Snd = 89 Then JawAnim:AnimStep=15			'089  59-Oh noo
            If Snd = 105 Then JawAnim:AnimStep=15			'105  69-Another coin please
            If Snd = 107 Then JawAnim:AnimStep=15			'107  6b-Jackpot
            If Snd = 109 Then JawAnim:AnimStep=15			'109  6d-Feel the power
        Next
    End If
End Sub

Dim AnimStep
Sub JawAnim:TimerJaw.Enabled=0:TimerJaw.Enabled=1:Jaw.RotX = 0:End Sub
Sub TimerJaw_Timer()
	Select Case AnimStep
		Case 1:Jaw.RotX = Jaw.RotX - 1
			If Jaw.RotX = -8 Then:AnimStep=2:End If
		Case 2:Jaw.RotX = Jaw.RotX + 1
			If Jaw.RotX = 0 Then:AnimStep=3:End If
		Case 3:Jaw.RotX = Jaw.RotX - 1
			If Jaw.RotX = -8 Then:AnimStep=4:End If
		Case 4:Jaw.RotX = Jaw.RotX + 1
			If Jaw.RotX = 0 Then:AnimStep=5:End If
		Case 5:Jaw.RotX = Jaw.RotX - 1
			If Jaw.RotX = -8 Then:AnimStep=6:End If
		Case 6:Jaw.RotX = Jaw.RotX + 1
			If Jaw.RotX = 0 Then:AnimStep=7:End If
		Case 7:Jaw.RotX = Jaw.RotX - 1
			If Jaw.RotX = -8 Then:AnimStep=8:End If
		Case 8:Jaw.RotX = Jaw.RotX + 1
			If Jaw.RotX = 0 Then:AnimStep=9:End If
		Case 9:Jaw.RotX = Jaw.RotX - 1
			If Jaw.RotX = -8 Then:AnimStep=10:End If
		Case 10:Jaw.RotX = Jaw.RotX + 1
			If Jaw.RotX = 0 Then:AnimStep=11:End If
		Case 11:Jaw.RotX = Jaw.RotX - 1
			If Jaw.RotX = -8 Then:AnimStep=12:End If
		Case 12:Jaw.RotX = Jaw.RotX + 1
			If Jaw.RotX = 0 Then:AnimStep=13:End If
		Case 13:Jaw.RotX = Jaw.RotX - 1
			If Jaw.RotX = -8 Then:AnimStep=14:End If
		Case 14:Jaw.RotX = Jaw.RotX + 1
			If Jaw.RotX = 0 Then:AnimStep=15:End If
		Case 15:Jaw.RotX = Jaw.RotX - 1
			If Jaw.RotX = -8 Then:AnimStep=16:End If
		Case 16:Jaw.RotX = Jaw.RotX + 1
			If Jaw.RotX = 0 Then:AnimStep=17:End If
		Case 17:Jaw.RotX = Jaw.RotX - 1
			If Jaw.RotX = -8 Then:AnimStep=18:End If
		Case 18:Jaw.RotX = Jaw.RotX + 1
			If Jaw.RotX = 0 Then:AnimStep=19:End If
		Case 19:Jaw.RotX = Jaw.RotX - 1
			If Jaw.RotX = -8 Then:AnimStep=20:End If
		Case 20:Jaw.RotX = Jaw.RotX + 1
			If Jaw.RotX = 0 Then:AnimStep=21:End If
		Case 21:Jaw.RotX = Jaw.RotX - 1
			If Jaw.RotX = -8 Then:AnimStep=22:End If
		Case 22:Jaw.RotX = Jaw.RotX + 1
			If Jaw.RotX = 0 Then:TimerJaw.Enabled = 0:End If
	End Select
End Sub

Dim AnimStep1
Sub LegsAnim:AnimStep1=1:TimerLegs.Enabled=1:End Sub
Sub TimerLegs_Timer()
	Select Case AnimStep1
		Case 1:LegSx.RotX = LegSx.RotX - 1:LegDx.RotX = LegDx.RotX + 1
			If LegSx.RotX = -60 Then:AnimStep1=2:End If
		Case 2:LegSx.RotX = LegSx.RotX + 2:LegDx.RotX = LegDx.RotX - 2
			If LegSx.RotX = -40 Then:AnimStep1=3:End If
		Case 3:LegSx.RotX = LegSx.RotX - 2:LegDx.RotX = LegDx.RotX + 2
			If LegSx.RotX = -70 Then:AnimStep1=4:End If
		Case 4:LegSx.RotX = LegSx.RotX + 1:LegDx.RotX = LegDx.RotX - 1
			If LegSx.RotX = -0 Then:TimerLegs.Enabled = 0:End If
	End Select
End Sub

'16/10, FSS X/Y Scale 1,41
'16/9, FSS X/Y Scale 1,57