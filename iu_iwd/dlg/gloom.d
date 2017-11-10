/*
cdgloom
1 - learned it can be upgraded
2 - upgrade accepted, start cutscene
3 - script trips cutscene
4 - cutscene over, item upgraded
*/

EXTEND_BOTTOM DKIERAN2 20 // also 22, 24
  IF ~PartyHasItem("cynicis")
      Global("CDGloom","MYAREA",0)
      Global("Know_Mirror_Door","GLOBAL",2)~ THEN REPLY @0 DO ~SetGlobal("CDGloom","MYAREA",1)~ GOTO CynicismUpgrade
  IF ~PartyHasItem("cynicis")
      PartyHasItem("scemot")
      Global("CDGloom","MYAREA",1)
      Global("Know_Mirror_Door","GLOBAL",2)~ THEN REPLY @10 DO ~TakePartyItem("scemot")
                                                                DestroyItem("scemot")
                                                                TakePartyItem("cynicis")
                                                                DestroyItem("cynicis")~ GOTO StartCut
END

APPEND DKIERAN2

  IF WEIGHT #-1 ~Global("CDGloom","MYAREA",5)~ THEN BEGIN GloomReady SAY @9
    IF ~~ THEN DO ~GiveItemCreate("cdgloom",Protagonist,1,2,2)
                   SetGlobal("CDGloom","MYAREA",6)~ GOTO KieranReset
  END
  
  IF ~~ THEN BEGIN CynicismUpgrade SAY @1 = @2 = @3 = @4
    IF ~PartyHasItem("scemot")~ THEN REPLY @5 DO ~TakePartyItem("scemot")
                                                   DestroyItem("scemot")
                                                   TakePartyItem("cynicis")
                                                   DestroyItem("cynicis")~ GOTO StartCut
    IF ~~ THEN REPLY @6 GOTO KieranReset
  END
  
  IF ~~ THEN BEGIN StartCut SAY @7
    IF ~~ THEN DO ~SetGlobal("CDGloom","MYAREA",2)~ EXIT
  END
  
  IF ~~ THEN BEGIN KieranReset SAY @8
    COPY_TRANS DKIERAN2 20
  END

END
