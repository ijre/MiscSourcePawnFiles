int GetDmgTypeNamesFromBitMask(int bitMask, char[] buff, int buffSize)
{
  char DMG_PREVENT_PHYSICS_FORCE_STRING[28];
  char DMG_BLAST_SURFACE_STRING[18];

  EngineVersion eng;

  //! i never looked into any other games here besides these two, my apologies if you're wanting cs:go or w/e
  if ((eng = GetEngineVersion()) == Engine_TF2)
  {
    // regarding tf2, these types can only ever be used in a TakeHealth call, since they're re-using a dmg flag that means something else
      // #define DMG_IGNORE_MAXHEALTH	(DMG_BULLET)
      // #define DMG_IGNORE_DEBUFFS		(DMG_SLASH)
    DMG_PREVENT_PHYSICS_FORCE_STRING = "DMG_PREVENT_PHYSICS_FORCE";
    DMG_BLAST_SURFACE_STRING = "DMG_MELEE";
  }
  else
  {
    DMG_PREVENT_PHYSICS_FORCE_STRING = "DMG_BLAMELESS_FRIENDLY_FIRE";
    DMG_BLAST_SURFACE_STRING = "DMG_BLAST_SURFACE";
  }

  #define TOTAL_DMG_TYPES 30
  char dmgTypes[TOTAL_DMG_TYPES][30] =
  {
    "DMG_CRUSH",
    "DMG_BULLET",
    "DMG_SLASH",
    "DMG_BURN",
    "DMG_VEHICLE",
    "DMG_FALL",
    "DMG_BLAST",
    "DMG_CLUB",
    "DMG_SHOCK",
    "DMG_SONIC",
    "DMG_RADIUS_MAX",
    "", // DMG_PREVENT_PHYSICS_FORCE_STRING, index 11
    "DMG_NEVERGIB",
    "DMG_ALWAYSGIB",
    "DMG_DROWN",
    "DMG_PARALYZE",
    "DMG_NERVEGAS",
    "DMG_NOCLOSEDISTANCEMOD",
    "DMG_HALF_FALLOFF",
    "DMG_DROWNRECOVER",
    "DMG_CRIT",
    "DMG_USEDISTANCEMOD",
    "DMG_REMOVENORAGDOLL",
    "DMG_PHYSGUN",
    "DMG_IGNITE",
    "DMG_USE_HITLOCATIONS",
    "DMG_DISSOLVE",
    "", // DMG_BLAST_SURFACE_STRING, index 28
    "DMG_DIRECT",
    "DMG_BUCKSHOT"
  };
  dmgTypes[11] = DMG_PREVENT_PHYSICS_FORCE_STRING;
  dmgTypes[28] = DMG_BLAST_SURFACE_STRING;

  char[] ret = new char[256];

  if (eng == Engine_TF2)
  {
    if (bitMask <= 0)
    {
      return strcopy(buff, buffSize, "DMG_GENERIC");
    }
  }
  else
  {
    if (bitMask == 0)
    {
      return strcopy(buff, buffSize, "DMG_GENERIC");
    }
    else if (bitMask < 0)
    {
      return strcopy(buff, buffSize, "DMG_DISMEMBER");
    }
  }

  bool isRetEmpty = true;

  for (int type = 0; type < TOTAL_DMG_TYPES; type++)
  {
    if (bitMask & (1 << type))
    {
      FormatEx(ret, 1000, "%s%s%s", ret, (isRetEmpty && type != TOTAL_DMG_TYPES - 1 ? "" : " "), dmgTypes[type]);
      isRetEmpty = false;
    }
  }

  return strcopy(buff, buffSize, ret);
}