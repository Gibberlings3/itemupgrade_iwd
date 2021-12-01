ADD_TRANS_TRIGGER dplanar ~%dplanar_totlm%~ ~!PartyHasItem("vexed") !PartyHasItem("vexed2")~ DO 5

EXTEND_BOTTOM DPLANAR ~%dplanar_totlm%~
  IF ~Global("Know_Vexing","GLOBAL",1)
      !Global("Know_Truename","GLOBAL",1)
      OR(2)
        PartyHasItem("vexed")
        PartyHasItem("vexed2")~ THEN REPLY #25298 DO ~SetGlobal("Know_Truename","GLOBAL",1)~ GOTO VexedVexed
END