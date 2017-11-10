EXTEND_BOTTOM DPLANAR 16
  IF ~PartyHasItem("lxbowbm")~ THEN REPLY @0 DO ~TakePartyItem("lxbowbm")
                                                 GiveItemCreate("cdxbowbm",Protagonist,1,1,1)~ GOTO BrenMuller
END

EXTEND_BOTTOM DPLANAR 26
  IF ~PartyHasItem("lxbowbm")~ THEN REPLY @0 DO ~TakePartyItem("lxbowbm")
                                                 GiveItemCreate("cdxbowbm",Protagonist,1,1,1)~ GOTO BrenMuller
END

EXTEND_BOTTOM DPLANAR 45
  IF ~PartyHasItem("lxbowbm")~ THEN REPLY @0 DO ~TakePartyItem("lxbowbm")
                                                 GiveItemCreate("cdxbowbm",Protagonist,1,1,1)~ GOTO BrenMuller
END

EXTEND_BOTTOM DPLANAR 51
  IF ~PartyHasItem("lxbowbm")~ THEN REPLY @0 DO ~TakePartyItem("lxbowbm")
                                                 GiveItemCreate("cdxbowbm",Protagonist,1,1,1)~ GOTO BrenMuller
END

EXTEND_BOTTOM DPLANAR 57
  IF ~PartyHasItem("lxbowbm")~ THEN REPLY @0 DO ~TakePartyItem("lxbowbm")
                                                 GiveItemCreate("cdxbowbm",Protagonist,1,1,1)~ GOTO BrenMuller
END

EXTEND_BOTTOM DPLANAR 69
  IF ~PartyHasItem("lxbowbm")~ THEN REPLY @0 DO ~TakePartyItem("lxbowbm")
                                                 GiveItemCreate("cdxbowbm",Protagonist,1,1,1)~ GOTO BrenMuller
END

APPEND DPLANAR

  IF ~~ THEN BEGIN BrenMuller SAY @1 = @2 = @3 = @4 = @5
    IF ~~ THEN DO ~StartCutScene("gnDstSlf")~ EXIT
  END

END