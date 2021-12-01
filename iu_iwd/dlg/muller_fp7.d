EXTEND_BOTTOM DPLANAR ~%dplanar_totlm%~
  IF ~PartyHasItem("lxbowbm")~ THEN REPLY @0 DO ~TakePartyItem("lxbowbm")
                                                 GiveItemCreate("cdxbowbm",Protagonist,1,1,1)~ GOTO BrenMuller
END