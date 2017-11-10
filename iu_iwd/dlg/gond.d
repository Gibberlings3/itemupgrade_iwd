/*
CDOswaldItem
1 - offered to buy tolls, offer declined
2 - sold tools
3 - wanted to borrow belt, declined
4 - lent belt, wanted downpayment
5 - lent belt, no downpayment
6 - declined offer to upgrade belt, wanted downpayment previously
7 - declined offer to upgrade belt, did not want downpayment previously
8 - accepted offer to upgrade
9 - upgraded belt given
*/

EXTEND_BOTTOM DOSWALD 14
  IF ~PartyHasItem("cdtools")
      Global("CDOswaldItem","MYAREA",1)~ THEN REPLY @22 GOTO StillWantTools
  IF ~PartyHasItem("beltgon")
      Global("CDOswaldItem","MYAREA",3)~ THEN REPLY @39 GOTO BeltRedux
  IF ~PartyHasItem("beltgon")
      Global("CDOswaldItem","MYAREA",6)~ THEN REPLY @52 GOTO ImproveOffer
  IF ~PartyHasItem("beltgon")
      Global("CDOswaldItem","MYAREA",7)~ THEN REPLY @52 GOTO ImproveOfferLikes
END

APPEND DOSWALD

  IF WEIGHT #0 ~Global("Kuldahar_Murder","GLOBAL",0)
                Global("CDOswaldItem","MYAREA",0)
                PartyHasItem("cdtools")~ THEN BEGIN OohShinies SAY @0
    IF ~~ THEN REPLY @1 GOTO Sure
    IF ~~ THEN REPLY @2 GOTO Sure
  END

  IF WEIGHT #0 ~Global("Kuldahar_Murder","GLOBAL",0)
                PartyHasItem("beltgon")
                Global("CDOswaldItem","MYAREA",2)
                GlobalTimerExpired("CDOswaldTimer","MYAREA")~ THEN BEGIN LookAtBelt SAY @25 = @26 = @27
    IF ~~ THEN GOTO BeltRedux
  END

  IF WEIGHT #0 ~Global("Kuldahar_Murder","GLOBAL",0)
                GlobalGT("CDOswaldItem","MYAREA",3)
                GlobalLT("CDOswaldItem","MYAREA",6)
                GlobalTimerExpired("CDOswaldTimer","MYAREA")~ THEN BEGIN ImproveBelt SAY @40 = @41 = @42
    IF ~Global("CDOswaldItem","MYAREA",4)~ THEN GOTO ImproveOffer
    IF ~Global("CDOswaldItem","MYAREA",5)~ THEN GOTO ImproveOfferLikes
  END

  IF WEIGHT #0 ~Global("Kuldahar_Murder","GLOBAL",0)
                Global("CDOswaldItem","MYAREA",8)
                GlobalTimerExpired("CDOswaldTimer","MYAREA")~ THEN BEGIN ImprovedBeltDone SAY @50 = @51
    IF ~~ THEN DO ~SetGlobal("CDOswaldItem","MYAREA",9)
                   GiveItemCreate("cdgond",Protagonist,0,0,0)~ GOTO GenericReset
  END
  
  IF ~~ THEN BEGIN Sure SAY @3 = @4
    IF ~~ THEN REPLY @5 GOTO Offer
    IF ~~ THEN REPLY @6 GOTO NoMatter
    IF ~~ THEN REPLY @7 GOTO NoMatter
  END
  
  IF ~~ THEN BEGIN NoMatter SAY @8
    IF ~~ THEN GOTO Offer
  END
  
  IF ~~ THEN BEGIN Offer SAY @9 = @10
    IF ~~ THEN REPLY @11 GOTO WantGold
    IF ~~ THEN REPLY @12 GOTO WhatPotions
    IF ~~ THEN REPLY @13 DO ~TakePartyItem("cdtools")
                             GiveItemCreate("potn08",Protagonist,0,0,0)
                             GiveItemCreate("potn08",Protagonist,0,0,0)
                             GiveItemCreate("potn09",Protagonist,0,0,0)
                             GiveItemCreate("potn10",Protagonist,0,0,0)
                             SetGlobalTimer("CDOswaldTimer","MYAREA",ONE_DAY)
                             SetGlobal("CDOswaldItem","MYAREA",2)~ GOTO OfferAccepted
    IF ~~ THEN REPLY @16 DO ~SetGlobal("CDOswaldItem","MYAREA",1)~ GOTO NotInterested
  END
  
  IF ~~ THEN BEGIN WantGold SAY @14
    IF ~~ THEN REPLY @15 GOTO WhatPotions
    IF ~~ THEN REPLY @17 DO ~TakePartyItem("cdtools")
                             GiveGoldForce(150)
                             SetGlobalTimer("CDOswaldTimer","MYAREA",ONE_DAY)
                             SetGlobal("CDOswaldItem","MYAREA",2)~ GOTO OfferAccepted
    IF ~~ THEN REPLY @16 DO ~SetGlobal("CDOswaldItem","MYAREA",1)~ GOTO NotInterested
  END
  
  IF ~~ THEN BEGIN WhatPotions SAY @18
    IF ~~ THEN REPLY @11 GOTO WantGold
    IF ~~ THEN REPLY @13 DO ~TakePartyItem("cdtools")
                             GiveItemCreate("potn08",Protagonist,0,0,0)
                             GiveItemCreate("potn08",Protagonist,0,0,0)
                             GiveItemCreate("potn09",Protagonist,0,0,0)
                             GiveItemCreate("potn10",Protagonist,0,0,0)
                             SetGlobalTimer("CDOswaldTimer","MYAREA",ONE_DAY)
                             SetGlobal("CDOswaldItem","MYAREA",2)~ GOTO OfferAccepted
    IF ~~ THEN REPLY @16 DO ~SetGlobal("CDOswaldItem","MYAREA",1)~ GOTO NotInterested
  END
  
  IF ~~ THEN BEGIN OfferAccepted SAY @19
    COPY_TRANS DOSWALD 14
  END
  
  IF ~~ THEN BEGIN NotInterested SAY @20
    IF ~~ THEN GOTO GenericReset
  END
  
  IF ~~ THEN BEGIN GenericReset SAY @21
    COPY_TRANS DOSWALD 14
  END

  IF ~~ THEN BEGIN StillWantTools SAY @23
    IF ~~ THEN REPLY @11 GOTO WantGold
    IF ~~ THEN REPLY @13 DO ~TakePartyItem("cdtools")
                             GiveItemCreate("potn08",Protagonist,0,0,0)
                             GiveItemCreate("potn08",Protagonist,0,0,0)
                             GiveItemCreate("potn09",Protagonist,0,0,0)
                             GiveItemCreate("potn10",Protagonist,0,0,0)
                             SetGlobalTimer("CDOswaldTimer","MYAREA",ONE_DAY)
                             SetGlobal("CDOswaldItem","MYAREA",2)~ GOTO OfferAccepted
    IF ~~ THEN REPLY @24 GOTO NotInterested
  END

  IF ~~ THEN BEGIN BeltRedux SAY @28
    IF ~~ THEN REPLY @29 DO ~TakePartyItem("beltgon")
                             DestroyItem("beltgon")
                             SetGlobalTimer("CDOswaldTimer","MYAREA",ONE_DAY)
                             SetGlobal("CDOswaldItem","MYAREA",5)~ GOTO TakeBelt
    IF ~~ THEN REPLY @30 GOTO WhatchooGonnaDo
    IF ~~ THEN REPLY @31 GOTO Collat
    IF ~~ THEN REPLY @32 DO ~SetGlobal("CDOswaldItem","MYAREA",3)~ GOTO GenericReset
  END

  IF ~~ THEN BEGIN WhatchooGonnaDo SAY @33
    IF ~~ THEN REPLY @34 DO ~TakePartyItem("beltgon")
                             DestroyItem("beltgon")
                             SetGlobalTimer("CDOswaldTimer","MYAREA",ONE_DAY)
                             SetGlobal("CDOswaldItem","MYAREA",5)~ GOTO TakeBelt
    IF ~~ THEN REPLY @31 GOTO Collat
    IF ~~ THEN REPLY @32 DO ~SetGlobal("CDOswaldItem","MYAREA",3)~ GOTO GenericReset
  END

  IF ~~ THEN BEGIN Collat SAY @35
    IF ~~ THEN REPLY @36 DO ~TakePartyItem("beltgon")
                             DestroyItem("beltgon")
                             SetGlobalTimer("CDOswaldTimer","MYAREA",ONE_DAY)
                             SetGlobal("CDOswaldItem","MYAREA",5)~ GOTO TakeBelt
    IF ~~ THEN REPLY @37 DO ~TakePartyItem("beltgon")
                             DestroyItem("beltgon")
                             SetGlobalTimer("CDOswaldTimer","MYAREA",ONE_DAY)
                             GiveGoldForce(50)
                             SetGlobal("CDOswaldItem","MYAREA",4)~ GOTO TakeBelt
    IF ~~ THEN REPLY @30 GOTO WhatchooGonnaDo
    IF ~~ THEN REPLY @32 DO ~SetGlobal("CDOswaldItem","MYAREA",3)~ GOTO GenericReset
  END

  IF ~~ THEN BEGIN TakeBelt SAY @38
    IF ~~ THEN GOTO GenericReset
  END
  
  IF ~~ THEN BEGIN ImproveOffer SAY @44
    IF ~PartyGoldGT(1599)~ THEN REPLY @45 DO ~TakePartyGold(1600)
                                              TakePartyItem("beltgon")
                                              SetGlobal("CDOswaldItem","MYAREA",8)
                                              SetGlobalTimer("CDOswaldTimer","MYAREA",ONE_DAY)~ GOTO GetToWork
    IF ~PartyGoldLT(1600)~ THEN REPLY @46 DO ~SetGlobal("CDOswaldItem","MYAREA",6)
                                              GiveItemCreate("beltgon",Protagonist,0,0,0)~ GOTO Nope
    IF ~!Global("CDOswaldItem","MYAREA",6)~ THEN REPLY @47 DO ~SetGlobal("CDOswaldItem","MYAREA",6)
                                                               GiveItemCreate("beltgon",Protagonist,0,0,0)~ GOTO Nope
    IF ~Global("CDOswaldItem","MYAREA",6)~ THEN REPLY @47 GOTO Nope
  END
  
  IF ~~ THEN BEGIN ImproveOfferLikes SAY @43
    IF ~PartyGoldGT(1199)~ THEN REPLY @45 DO ~TakePartyGold(1200)
                                              TakePartyItem("beltgon")
                                              SetGlobal("CDOswaldItem","MYAREA",8)
                                              SetGlobalTimer("CDOswaldTimer","MYAREA",ONE_DAY)~ GOTO GetToWork
    IF ~PartyGoldLT(1200)~ THEN REPLY @46 DO ~SetGlobal("CDOswaldItem","MYAREA",7)
                                              GiveItemCreate("beltgon",Protagonist,0,0,0)~ GOTO Nope
    IF ~!Global("CDOswaldItem","MYAREA",7)~ THEN REPLY @47 DO ~SetGlobal("CDOswaldItem","MYAREA",7)
                                                               GiveItemCreate("beltgon",Protagonist,0,0,0)~ GOTO Nope
    IF ~Global("CDOswaldItem","MYAREA",7)~ THEN REPLY @47 GOTO Nope
  END
  
  IF ~~ THEN BEGIN Nope SAY @48
    IF ~~ THEN GOTO GenericReset
  END
  
  IF ~~ THEN BEGIN GetToWork SAY @49
    IF ~~ THEN GOTO GenericReset
  END

END