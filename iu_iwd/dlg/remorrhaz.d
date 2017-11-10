/*
cdrem
1 - upgrade in progress
2 - upgrade finished, helm given to party

CDRemTimer
timer until completion
*/

EXTEND_BOTTOM DDIRTYLL 0
  IF ~PartyHasItem("cdrem")
      Global("CDRem","MYAREA",0)~ THEN REPLY @0 GOTO RemMale
  IF ~Global("CDRem","MYAREA",1)
      GlobalTimerExpired("CDRemTimer","MYAREA")~ THEN REPLY @6 DO ~SetGlobal("CDRem","MYAREA",2)
                                                                   GiveItemCreate("cdrelm",Protagonist,0,0,0)~ GOTO HelmReady
END

EXTEND_BOTTOM DDIRTYLL 1
  IF ~PartyHasItem("cdrem")
      Global("CDRem","MYAREA",0)~ THEN REPLY @0 GOTO RemFemale
  IF ~Global("CDRem","MYAREA",1)
      GlobalTimerExpired("CDRemTimer","MYAREA")~ THEN REPLY @6 DO ~SetGlobal("CDRem","MYAREA",2)
                                                                   GiveItemCreate("cdrelm",Protagonist,0,0,0)~ GOTO HelmReady
END

EXTEND_BOTTOM DDIRTYLL 2
  IF ~PartyHasItem("cdrem")
      Global("CDRem","MYAREA",0)~ THEN REPLY @0 GOTO RemHotFemale
  IF ~Global("CDRem","MYAREA",1)
      GlobalTimerExpired("CDRemTimer","MYAREA")~ THEN REPLY @6 DO ~SetGlobal("CDRem","MYAREA",2)
                                                                   GiveItemCreate("cdrelm",Protagonist,0,0,0)~ GOTO HelmReady
END

APPEND DDIRTYLL

  IF ~~ THEN BEGIN RemMale SAY @1
    IF ~PartyGoldGT(7999)~ THEN REPLY #10098 DO ~TakePartyGold(8000)
                                                 TakePartyItem("cdrem")
                                                 DestroyItem("cdrem")
                                                 SetGlobal("CDRem","MYAREA",1)
                                                 SetGlobalTimer("CDRemTimer","MYAREA",THREE_DAYS)~ GOTO GoForIt
    IF ~~ THEN REPLY @2 GOTO LlewResetMale
    IF ~~ THEN REPLY @3 GOTO LlewResetMale
  END
  
  IF ~~ THEN BEGIN RemFemale SAY @8
    IF ~PartyGoldGT(6999)~ THEN REPLY #10098 DO ~TakePartyGold(7000)
                                                 TakePartyItem("cdrem")
                                                 DestroyItem("cdrem")
                                                 SetGlobal("CDRem","MYAREA",1)
                                                 SetGlobalTimer("CDRemTimer","MYAREA",THREE_DAYS)~ GOTO GoForIt
    IF ~~ THEN REPLY @2 GOTO LlewResetFemale
    IF ~~ THEN REPLY @3 GOTO LlewResetFemale
  END
  
  IF ~~ THEN BEGIN RemHotFemale SAY @9
    IF ~PartyGoldGT(4999)~ THEN REPLY #10098 DO ~TakePartyGold(5000)
                                                 TakePartyItem("cdrem")
                                                 DestroyItem("cdrem")
                                                 SetGlobal("CDRem","MYAREA",1)
                                                 SetGlobalTimer("CDRemTimer","MYAREA",THREE_DAYS)~ GOTO GoForIt
    IF ~~ THEN REPLY @2 GOTO LlewResetHotFemale
    IF ~~ THEN REPLY @3 GOTO LlewResetHotFemale
  END
  
  IF ~~ THEN BEGIN GoForIt SAY @4
    IF ~Gender(Protagonist,MALE)~ THEN GOTO LlewResetMale
    IF ~Gender(Protagonist,FEMALE)
        CheckStatLT(Protagonist,16,CHR)~ THEN GOTO LlewResetFemale
    IF ~Gender(Protagonist,FEMALE)
        CheckStatGT(Protagonist,15,CHR)~ THEN GOTO LlewResetHotFemale
  END
  
  IF ~~ THEN BEGIN LlewResetMale SAY @5
    COPY_TRANS DDIRTYLL 0
  END
  
  IF ~~ THEN BEGIN LlewResetFemale SAY @5
    COPY_TRANS DDIRTYLL 1
  END
  
  IF ~~ THEN BEGIN LlewResetHotFemale SAY @5
    COPY_TRANS DDIRTYLL 2
  END
  
  IF ~~ THEN BEGIN HelmReady SAY @7
    IF ~Gender(Protagonist,MALE)~ THEN GOTO LlewResetMale
    IF ~Gender(Protagonist,FEMALE)
        CheckStatLT(Protagonist,16,CHR)~ THEN GOTO LlewResetFemale
    IF ~Gender(Protagonist,FEMALE)
        CheckStatGT(Protagonist,15,CHR)~ THEN GOTO LlewResetHotFemale
  END

END