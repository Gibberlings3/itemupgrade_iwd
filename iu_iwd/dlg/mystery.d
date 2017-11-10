/*
CDMystery
1 - told of upgrade
2 - upgrade in progress
3 - upgrade finished

CDMysteryTimer
4 hours for completion of upgrade

CDYoung
1 - told of upgrade
2 - start upgrade - edion path
3 - cutscene finished, start dialogue - edion path
4 - post-cutscene dialogue with tiernon done, go see edion - edion path
5 - edion want money
6 - start cutscene - nonedion path
7 - end cutscene, start dialogue - nonedion path
8 - upgrade complete, either via edion or party necro
*/


EXTEND_BOTTOM DEDION 16
  IF ~PartyHasItem("mystery")
      Global("Know_Edion_Wizard","GLOBAL",1)
      Global("CDMystery","MYAREA",0)~ THEN REPLY @0 DO ~SetGlobal("CDMystery","MYAREA",1)~ GOTO UnlockMystery
  IF ~PartyHasItem("mystery")
      Global("Know_Edion_Wizard","GLOBAL",1)
      Global("CDMystery","MYAREA",1)
      NumItemsPartyGT("misc58",2)~ THEN REPLY @9 DO ~TakePartyItem("misc58")
                                                     TakePartyItem("misc58")
                                                     TakePartyItem("misc58")
                                                     TakePartyItem("mystery")
                                                     DestroyItem("mystery")
                                                     SetGlobalTimer("CDMysteryTimer","MYAREA",1200) // four hours
                                                     SetGlobal("CDMystery","MYAREA",2)~ GOTO Upgrading
  IF ~PartyHasItem("young")
      PartyHasItem("cdyoungn")
      Global("CDYoung","GLOBAL",4)~ THEN REPLY @28 DO ~SetGlobal("CDYoung","GLOBAL",5)~ GOTO YoungRage
  IF ~PartyHasItem("young")
      Global("CDYoung","GLOBAL",5)~ THEN REPLY @35 GOTO YR3
END

EXTEND_BOTTOM DTIERNON 33
  IF ~PartyHasItem("young")
      Global("CDYoung","GLOBAL",0)~ THEN REPLY @12 DO ~SetGlobal("CDYoung","GLOBAL",1)~ GOTO YoungRage
  IF ~PartyHasItem("young")
      Global("CDYoung","GLOBAL",1)~ THEN REPLY @25 GOTO YoungRage2
  IF ~PartyHasItem("young")
      Global("CDYoung","GLOBAL",4)~ THEN REPLY @26 GOTO GoSeeEdionAlready
END

APPEND DEDION

  IF WEIGHT #-1 ~!Global("YoungNed_Dead","GLOBAL",1)
                 Global("CDMystery","MYAREA",2)
                 GlobalTimerExpired("CDMysteryTimer","MYAREA")~ THEN BEGIN HeresJohnny SAY @10 = @11
    IF ~~ THEN DO ~GiveItemCreate("cdmyst",Protagonist,1,1,1)
                   SetGlobal("CDMystery","MYAREA",3)~ GOTO EdionReset
  END
  
  IF ~~ THEN BEGIN YoungRage SAY @34
    IF ~~ THEN REPLY @30 DO ~TakePartyItem("cdyoungn")
                             DestroyItem("cdyoungn")~ GOTO YR2
  END

  IF ~~ THEN BEGIN YR2 SAY @31 = @32
    IF ~PartyGoldGT(299)~ THEN REPLY @5 DO ~TakePartyGold(300)  
                                            TakePartyItem("young")
                                            DestroyItem("young")
                                            GiveItemCreate("cdyoung",Protagonist,0,0,0)
                                            SetGlobal("CDYoung","GLOBAL",8)~ GOTO EdionReset
    IF ~~ THEN REPLY @33 GOTO EdionReset
  END

  IF ~~ THEN BEGIN YR3 SAY @35
    IF ~PartyGoldGT(299)~ THEN REPLY @5 DO ~TakePartyGold(300)  
                                            TakePartyItem("young")
                                            DestroyItem("young")
                                            GiveItemCreate("cdyoung",Protagonist,0,0,0)
                                            SetGlobal("CDYoung","GLOBAL",8)~ GOTO EdionReset
    IF ~~ THEN REPLY @33 GOTO EdionReset
  END

  IF ~~ THEN BEGIN UnlockMystery SAY @1 = @2 = @3 = @4
    IF ~NumItemsPartyGT("misc58",2)~ THEN REPLY @5 DO ~TakePartyItem("misc58")
                                                       TakePartyItem("misc58")
                                                       TakePartyItem("misc58")
                                                       TakePartyItem("mystery")
                                                       DestroyItem("mystery")
                                                       SetGlobalTimer("CDMysteryTimer","MYAREA",1200) // four hours
                                                       SetGlobal("CDMystery","MYAREA",2)~ GOTO Upgrading
    IF ~~ THEN REPLY @6 GOTO EdionReset
  END
  
  IF ~~ THEN BEGIN Upgrading SAY @7
    IF ~~ THEN GOTO EdionReset
  END
  
  IF ~~ THEN BEGIN EdionReset SAY @8
    COPY_TRANS DEDION 16
  END

END

APPEND DTIERNON

  IF WEIGHT #-1 ~Global("CDYoung","GLOBAL",7)~ THEN BEGIN PostCutscene SAY @22
    IF ~~ THEN DO ~TakePartyItem("young")
                   DestroyItem("young")
                   GiveItemCreate("cdyoung",Protagonist,0,0,0)
                   SetGlobal("CDYoung","GLOBAL",8)~ GOTO TiernonReset
  END
  
  IF WEIGHT #-1 ~Global("CDYoung","GLOBAL",3)~ THEN BEGIN GoSeeEdion SAY @23 = @24
    IF ~~ THEN DO ~GiveItemCreate("cdyoungn",Protagonist,0,0,0)
                   SetGlobal("CDYoung","GLOBAL",4)~ GOTO TiernonReset
  END
  
  IF ~~ THEN BEGIN YoungRage SAY @13
    IF ~~ THEN GOTO YoungRage2
  END
  
  IF ~~ THEN BEGIN GoSeeEdionAlready SAY @27
    IF ~~ THEN GOTO TiernonReset
  END
  
  IF ~~ THEN BEGIN YoungRage2 SAY @14 = @15
    IF ~Global("Know_Edion_Wizard","GLOBAL",1)
        !Dead("edion")~ THEN REPLY @16  DO ~SetGlobal("CDYoung","GLOBAL",2)~ GOTO Edion
    IF ~OR(6)
          School(Player1,Necromancer)
          School(Player2,Necromancer)
          School(Player3,Necromancer)
          School(Player4,Necromancer)
          School(Player5,Necromancer)
          School(Player6,Necromancer)~ THEN REPLY @17  DO ~SetGlobal("CDYoung","GLOBAL",6)~ GOTO MakeIt
    IF ~~ THEN REPLY @18 GOTO TiernonReset
  END
  
  IF ~~ THEN BEGIN Edion SAY @20 = @21
    IF ~~ THEN DO ~StartCutSceneMode()
                   StartCutScene("cdyoung")~ EXIT
  END
  
  IF ~~ THEN BEGIN MakeIt SAY @22
    IF ~~ THEN DO ~StartCutSceneMode()
                   StartCutScene("cdyoung")~ EXIT
  END
  
  IF ~~ THEN BEGIN TiernonReset SAY @19
    COPY_TRANS DTIERNON 33
  END

END