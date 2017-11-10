/*
CDStoutInGame 
1 - set in ar2004 if stoutward is randomly spawned
2 - adds mithril hammer to dorn's deep if stout is in game (ar6003)

CDStoutUpgrade
1 - learned it can be upgraded
2 - upgrade in progress
3 - upgrade finished

CDStoutUpgradeTimer
timer until upgrade ready

CDScales
1 - learned it can be upgraded
2 - upgrade in progress
3 - upgrade finished

CDScalesTimer
timer until upgrade ready
*/

EXTEND_BOTTOM DCONLAN 0
  IF ~Global("CDStoutUpgrade","MYAREA",0)
      PartyHasItem("cdmitham")~ THEN REPLY @0 DO ~SetGlobal("CDStoutUpgrade","MYAREA",1)~ GOTO StoutUpgrade
  IF ~Global("CDStoutUpgrade","MYAREA",1)
      PartyHasItem("cdmitham")~ THEN REPLY @25 GOTO Focus
  IF ~Global("CDScales","MYAREA",0)
      PartyHasItem("cdscales")~ THEN REPLY @29 DO ~SetGlobal("CDScales","MYAREA",1)~ GOTO ScaleUpgrade
  IF ~Global("CDScales","MYAREA",1)
      PartyHasItem("cdscales")~ THEN REPLY @37 GOTO AskScalesAgain
END

EXTEND_BOTTOM DCONLAN 1
  IF ~Global("CDStoutUpgrade","MYAREA",0)
      PartyHasItem("cdmitham")~ THEN REPLY @0 DO ~SetGlobal("CDStoutUpgrade","MYAREA",1)~ GOTO StoutUpgrade
  IF ~Global("CDStoutUpgrade","MYAREA",1)
      PartyHasItem("cdmitham")~ THEN REPLY @25 GOTO Focus
  IF ~Global("CDScales","MYAREA",0)
      PartyHasItem("cdscales")~ THEN REPLY @29 DO ~SetGlobal("CDScales","MYAREA",1)~ GOTO ScaleUpgrade
  IF ~Global("CDScales","MYAREA",1)
      PartyHasItem("cdscales")~ THEN REPLY @37 GOTO AskScalesAgain
END

EXTEND_BOTTOM DCONLAN 13
  IF ~Global("CDStoutUpgrade","MYAREA",0)
      PartyHasItem("cdmitham")~ THEN REPLY @0 DO ~SetGlobal("CDStoutUpgrade","MYAREA",1)~ GOTO StoutUpgrade
  IF ~Global("CDStoutUpgrade","MYAREA",1)
      PartyHasItem("cdmitham")~ THEN REPLY @25 GOTO Focus
  IF ~Global("CDScales","MYAREA",0)
      PartyHasItem("cdscales")~ THEN REPLY @29 DO ~SetGlobal("CDScales","MYAREA",1)~ GOTO ScaleUpgrade
  IF ~Global("CDScales","MYAREA",1)
      PartyHasItem("cdscales")~ THEN REPLY @37 GOTO AskScalesAgain
END

EXTEND_BOTTOM DCONLAN 14
  IF ~Global("CDStoutUpgrade","MYAREA",0)
      PartyHasItem("cdmitham")~ THEN REPLY @0 DO ~SetGlobal("CDStoutUpgrade","MYAREA",1)~ GOTO StoutUpgrade
  IF ~Global("CDStoutUpgrade","MYAREA",1)
      PartyHasItem("cdmitham")~ THEN REPLY @25 GOTO Focus
  IF ~Global("CDScales","MYAREA",0)
      PartyHasItem("cdscales")~ THEN REPLY @29 DO ~SetGlobal("CDScales","MYAREA",1)~ GOTO ScaleUpgrade
  IF ~Global("CDScales","MYAREA",1)
      PartyHasItem("cdscales")~ THEN REPLY @37 GOTO AskScalesAgain
END

EXTEND_BOTTOM DCONLAN 17
  IF ~Global("CDStoutUpgrade","MYAREA",0)
      PartyHasItem("cdmitham")~ THEN REPLY @0 DO ~SetGlobal("CDStoutUpgrade","MYAREA",1)~ GOTO StoutUpgrade
  IF ~Global("CDStoutUpgrade","MYAREA",1)
      PartyHasItem("cdmitham")~ THEN REPLY @25 GOTO Focus
  IF ~Global("CDScales","MYAREA",0)
      PartyHasItem("cdscales")~ THEN REPLY @29 DO ~SetGlobal("CDScales","MYAREA",1)~ GOTO ScaleUpgrade
  IF ~Global("CDScales","MYAREA",1)
      PartyHasItem("cdscales")~ THEN REPLY @37 GOTO AskScalesAgain
END

APPEND DCONLAN 

  IF WEIGHT #0 ~Global("CDStoutUpgrade","MYAREA",2)
                GlobalTimerExpired("CDStoutUpgradeTimer","MYAREA")
                Global("Kuldahar_Murder","GLOBAL",0)
                OR(2)
                  !GlobalGT("Sheemish_Escape","GLOBAL",1)
                  !Global("Conlan_Thanked","GLOBAL",0)~ THEN BEGIN StoutReady SAY @26 = @27 = @28
    IF ~~ THEN DO ~SetGlobal("CDStoutUpgrade","MYAREA",3)
                   GiveItemCreate("cdstout",Protagonist,0,0,0)~ GOTO ConlanReset
  END

  IF WEIGHT #0 ~Global("CDScales","MYAREA",2)
                GlobalTimerExpired("CDScalesTimer","MYAREA")
                Global("Kuldahar_Murder","GLOBAL",0)
                OR(2)
                  !GlobalGT("Sheemish_Escape","GLOBAL",1)
                  !Global("Conlan_Thanked","GLOBAL",0)~ THEN BEGIN ScalesReady SAY @38 = @39 = @40
    IF ~~ THEN DO ~SetGlobal("CDScales","MYAREA",3)
                   GiveItemCreate("cdscale",Protagonist,0,0,0)~ GOTO ConlanReset
  END
  
  
  IF ~~ THEN BEGIN StoutUpgrade SAY @1 = @2
    IF ~~ THEN REPLY @3 GOTO Focus
    IF ~~ THEN REPLY @4 GOTO ConlanReset
  END
  
  IF ~~ THEN BEGIN Focus SAY @5
    IF ~~ THEN REPLY @6 GOTO MoreFocus
    IF ~~ THEN REPLY @4 GOTO ConlanReset
  END
  
  IF ~~ THEN BEGIN MoreFocus SAY @7 = @8
    IF ~PartyHasItem("stout")~ THEN REPLY @9 GOTO OfferStout
    IF ~~ THEN REPLY @4 GOTO ConlanReset
  END
  
  IF ~~ THEN BEGIN OfferStout SAY @10 = @11 = @12
    IF ~~ THEN REPLY @13 GOTO Process
    IF ~~ THEN REPLY @14 GOTO Declined
  END
  
  IF ~~ THEN BEGIN Process SAY @15 = @16
    IF ~~ GOTO Expenso
    IF ~Global("Conlan_Thanked","GLOBAL",1)~ GOTO Cheapo
  END
  
  IF ~~ THEN BEGIN Cheapo SAY @17
    IF ~PartyGoldGT(999)~ THEN REPLY @20 DO ~TakePartyItem("stout")
                                             DestroyItem("stout")
                                             TakePartyItem("cdmitham")
                                             DestroyItem("cdmitham")
                                             TakePartyGold(1000)
                                             SetGlobal("CDStoutUpgrade","MYAREA",2)
                                             SetGlobalTimer("CDStoutUpgradeTimer","MYAREA",ONE_DAY)~ GOTO MakeIt
    IF ~~ THEN REPLY @22 GOTO NoMoola
    IF ~~ THEN REPLY @14 GOTO Declined
  END
  
  IF ~~ THEN BEGIN Expenso SAY @21
    IF ~PartyGoldGT(4499)~ THEN REPLY @20 DO ~TakePartyItem("stout")
                                              DestroyItem("stout")
                                              TakePartyItem("cdmitham")
                                              DestroyItem("cdmitham")
                                              TakePartyGold(4500)
                                              SetGlobal("CDStoutUpgrade","MYAREA",2)
                                              SetGlobalTimer("CDStoutUpgradeTimer","MYAREA",ONE_DAY)~ GOTO MakeIt
    IF ~~ THEN REPLY @22 GOTO NoMoola
    IF ~~ THEN REPLY @14 GOTO Declined
  END
  
  IF ~~ THEN BEGIN MakeIt SAY @24
    IF ~~ THEN GOTO ConlanReset
  END
  
  IF ~~ THEN BEGIN NoMoola SAY @23
    IF ~~ THEN GOTO ConlanReset
  END
  
  IF ~~ THEN BEGIN Declined SAY @18
    IF ~~ THEN GOTO ConlanReset
  END
  
  IF ~~ THEN BEGIN ScaleUpgrade SAY @30 = @31
    IF ~~ THEN GOTO AskScalesAgain
  END
  
  IF ~~ THEN BEGIN AskScalesAgain SAY @32 = @33
    IF ~PartyGoldGT(4999)~ THEN REPLY @34 DO ~TakePartyItem("cdscales")
                                             DestroyItem("cdscales")
                                             TakePartyGold(5000)
                                             SetGlobal("CDScales","MYAREA",2)
                                             SetGlobalTimer("CDScalesTimer","MYAREA",THREE_DAYS)~ GOTO MakeScales
    IF ~~ THEN REPLY @22 GOTO NoMoola
    IF ~~ THEN REPLY @36 GOTO Declined
  END
  
  IF ~~ THEN BEGIN MakeScales SAY @35
    IF ~~ THEN GOTO ConlanReset
  END
  
  IF ~~ THEN BEGIN ConlanReset SAY @19
    COPY_TRANS DCONLAN 14
    IF ~Global("CDStoutUpgrade","MYAREA",0)
        PartyHasItem("cdmitham")~ THEN REPLY @0 DO ~SetGlobal("CDStoutUpgrade","MYAREA",1)~ GOTO StoutUpgrade
    IF ~Global("CDStoutUpgrade","MYAREA",1)
        PartyHasItem("cdmitham")~ THEN REPLY @25 GOTO Focus
    IF ~Global("CDScales","MYAREA",0)
        PartyHasItem("cdscales")~ THEN REPLY @29 DO ~SetGlobal("CDScales","MYAREA",1)~ GOTO ScaleUpgrade
    IF ~Global("CDScales","MYAREA",1)
        PartyHasItem("cdscales")~ THEN REPLY @37 GOTO AskScalesAgain
  END

END


