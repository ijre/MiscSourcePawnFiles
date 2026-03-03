#if (!defined _TF2 && !defined _L4D2) || (defined _TF2 && defined _L4D2)
  #error #define _TF2 or _L4D2 for whatever game you're using this for
#endif

#if defined _TF2
  // This can only ever be used on a TakeHealth call, since it re-uses a dmg flag that means something else
  #define DMG_IGNORE_MAXHEALTH	(DMG_BULLET)
  #define DMG_IGNORE_DEBUFFS		(DMG_SLASH)

  #define DMG_PREVENT_PHYSICS_FORCE_STRING "DMG_PREVENT_PHYSICS_FORCE"
  #define DMG_BLAST_SURFACE_STRING         "DMG_MELEE"
#endif

#if defined _L4D2
  #define DMG_PREVENT_PHYSICS_FORCE_STRING "DMG_BLAMELESS_FRIENDLY_FIRE"
  #define DMG_BLAST_SURFACE_STRING         "DMG_BLAST_SURFACE"
#endif

char[] GetDmgTypeNames(int bitMask)
{
  #define TOTAL_DMG_TYPES 30

  static char dmgTypes[TOTAL_DMG_TYPES][30] =
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
    DMG_PREVENT_PHYSICS_FORCE_STRING,
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
    DMG_BLAST_SURFACE_STRING,
    "DMG_DIRECT",
    "DMG_BUCKSHOT"
  };

  char ret[1000];

#if defined _TF2
  if (bitMask <= 0)
  {
    ret = "DMG_GENERIC";
    return ret;
  }
#endif

#if defined _L4D2
  if (bitMask == 0)
  {
    ret = "DMG_GENERIC";
    return ret;
  }
  else if (bitMask < 0)
  {
    ret = "DMG_DISMEMBER";
    return ret;
  }
#endif

  bool isRetEmpty = true;

  for (int type = 0; type < TOTAL_DMG_TYPES; type++)
  {
    if (bitMask & (1 << type))
    {
      FormatEx(ret, sizeof(ret), "%s%s%s", ret, (isRetEmpty && type != TOTAL_DMG_TYPES - 1 ? "" : " "), dmgTypes[type]);
      isRetEmpty = false;
    }
  }

  return ret;
}