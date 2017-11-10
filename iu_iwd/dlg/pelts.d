/*
cdpelts
1 - mirek says to go see orrick

cdwuff, cdyeti
1 - pelt upgrade in progress
2 - pelt upgrade complete

cdorrickwufftimer, cdorrickyetitimer
time until upgraded items are complete
*/

ADD_TRANS_TRIGGER DMIREK 6 ~!Global("CDPelts","GLOBAL",0)~ DO 0
EXTEND_BOTTOM DMIREK 6
  IF ~Global("CDPelts","GLOBAL",0)~ THEN DO ~SetGlobal("CDPelts","GLOBAL",1)~ GOTO MentionPelts
END

APPEND DMIREK

  IF ~~ THEN BEGIN MentionPelts SAY @2
    COPY_TRANS DMIREK 6
  END

END

EXTEND_BOTTOM DORRICK 0
  IF ~Global("CDPelts","GLOBAL",1)
      PartyHasItem("misc01")
      Global("CDOrrickWuff","MYAREA",0)~ THEN REPLY @3 GOTO WuffPelt
  IF ~Global("CDPelts","GLOBAL",1)
      PartyHasItem("yeti")
      Global("CDOrrickYeti","MYAREA",0)~ THEN REPLY @4 GOTO YetiPelt
END

EXTEND_BOTTOM DORRICK 2
  IF ~Global("CDPelts","GLOBAL",1)
      PartyHasItem("misc01")
      Global("CDOrrickWuff","MYAREA",0)~ THEN REPLY @3 GOTO WuffPelt
  IF ~Global("CDPelts","GLOBAL",1)
      PartyHasItem("yeti")
      Global("CDOrrickYeti","MYAREA",0)~ THEN REPLY @4 GOTO YetiPelt
END

EXTEND_BOTTOM DORRICK 18
  IF ~Global("CDPelts","GLOBAL",1)
      PartyHasItem("misc01")
      Global("CDOrrickWuff","MYAREA",0)~ THEN REPLY @3 GOTO WuffPelt
  IF ~Global("CDPelts","GLOBAL",1)
      PartyHasItem("yeti")
      Global("CDOrrickYeti","MYAREA",0)~ THEN REPLY @4 GOTO YetiPelt
END

EXTEND_BOTTOM DORRICK 19
  IF ~Global("CDPelts","GLOBAL",1)
      PartyHasItem("misc01")
      Global("CDOrrickWuff","MYAREA",0)~ THEN REPLY @3 GOTO WuffPelt
  IF ~Global("CDPelts","GLOBAL",1)
      PartyHasItem("yeti")
      Global("CDOrrickYeti","MYAREA",0)~ THEN REPLY @4 GOTO YetiPelt
END

APPEND DORRICK

  IF WEIGHT #0 ~Global("CDOrrickWuff","MYAREA",1)
                GlobalTimerExpired("CDOrrickWuffTimer","MYAREA")~ THEN BEGIN WuffDone SAY @0
    IF ~~ THEN DO ~GiveItemCreate("cdwuff",Protagonist,0,0,0)
                   SetGlobal("CDOrrickWuff","MYAREA",2)~ GOTO OrrickReset
    IF ~Global("CDOrrickYeti","MYAREA",1)
        GlobalTimerExpired("CDOrrickYetiTimer","MYAREA")~ THEN DO ~GiveItemCreate("cdwuff",Protagonist,0,0,0)
                                                                   SetGlobal("CDOrrickWuff","MYAREA",2)~ GOTO YetiDone
  END
  
  IF WEIGHT #0 ~Global("CDOrrickYeti","MYAREA",1)
                GlobalTimerExpired("CDOrrickYetiTimer","MYAREA")~ THEN BEGIN YetiDone SAY @1
    IF ~~ THEN DO ~GiveItemCreate("cdharmor",Protagonist,0,0,0)
                   SetGlobal("CDOrrickYeti","MYAREA",2)~ GOTO OrrickReset
  END
  
  IF ~~ THEN BEGIN WuffPelt SAY @7 = @8
    IF ~NumItemsPartyGT("misc01",4)
        PartyGoldGT(3499)~ REPLY @9 DO ~TakePartyGold(3500)
                                         TakePartyItem("misc01")
                                         TakePartyItem("misc01")
                                         TakePartyItem("misc01")
                                         TakePartyItem("misc01")
                                         TakePartyItem("misc01")
                                         SetGlobal("CDOrrickWuff","MYAREA",1)
                                         SetGlobalTimer("CDOrrickWuffTimer","MYAREA",ONE_DAY)~ GOTO MakeWuff
    IF ~PartyHasItem("yeti")~ REPLY @6 GOTO YetiPelt
    IF ~~ REPLY @10 GOTO OrrickReset
  END
  
  IF ~~ THEN BEGIN YetiPelt SAY @11 = @12 = @13
    IF ~NumItemsPartyGT("yeti",9)
        PartyGoldGT(2499)~ REPLY @9 DO ~TakePartyGold(2500)
                                         TakePartyItem("yeti")
                                         TakePartyItem("yeti")
                                         TakePartyItem("yeti")
                                         TakePartyItem("yeti")
                                         TakePartyItem("yeti")
                                         TakePartyItem("yeti")
                                         TakePartyItem("yeti")
                                         TakePartyItem("yeti")
                                         TakePartyItem("yeti")
                                         TakePartyItem("yeti")
                                         SetGlobal("CDOrrickYeti","MYAREA",1)
                                         SetGlobalTimer("CDOrrickYetiTimer","MYAREA",THREE_DAYS)~ GOTO MakeYeti
    IF ~PartyHasItem("misc01")~ REPLY @5 GOTO WuffPelt
    IF ~~ REPLY @10 GOTO OrrickReset
  END
  
  IF ~~ THEN BEGIN MakeWuff SAY @14
    IF ~~ THEN GOTO OrrickReset
  END
  
  IF ~~ THEN BEGIN MakeYeti SAY @15
    IF ~~ THEN GOTO OrrickReset
  END
  
  IF ~~ THEN BEGIN OrrickReset SAY @16
    COPY_TRANS DORRICK 18
  END

END