// More button values to be used with IsPressingButton()
::IN_ATTACK <- 1
::IN_JUMP <- 2
::IN_DUCK <- 4
::IN_FORWARD <- 8
::IN_BACK <- 16
::IN_USE <- 32
::IN_CANCEL <- 64
::IN_LEFT <- 128
::IN_RIGHT <- 256
::IN_MOVELEFT <- 512
::IN_MOVERIGHT <- 1024
::IN_ATTACK2 <- 2048
::IN_RUN <- 4096
::IN_RELOAD <- 8192
::IN_ALT1 <- 16384
::IN_ALT2 <- 32768
::IN_SCORE <- 65536
::IN_SPEED <- 131072
::IN_WALK <- 262144
::IN_ZOOM <- 524288
::IN_WEAPON1 <- 1048576
::IN_WEAPON2 <- 2097152
::IN_BULLRUSH <- 4194304
::IN_GRENADE1 <- 8388608
::IN_GRENADE2 <- 16777216
::IN_ATTACK3 <- 33554432
::IN_LOOKSPIN <- 0x2000000

// Flags to be used with the m_fFlags network property values
::FL_ONGROUND <- (1 << 0)		/**< At rest / on the ground */
::FL_DUCKING <- (1 << 1)		/**< Player flag -- Player is fully crouched */
::FL_WATERJUMP <- (1 << 2)		/**< player jumping out of water */
::FL_ONTRAIN <- (1 << 3)		/**< Player is _controlling_ a train, so movement commands should be ignored on client during prediction. */
::FL_INRAIN <- (1 << 4)		/**< Indicates the entity is standing in rain */
::FL_FROZEN <- (1 << 5)		/**< Player is frozen for 3rd person camera */
::FL_ATCONTROLS <- (1 << 6)		/**< Player can't move, but keeps key inputs for controlling another entity */
::FL_CLIENT <- (1 << 7)		/**< Is a player */
::FL_FAKECLIENT <- (1 << 8)		/**< Fake client, simulated server side don't send network messages to them */
::FL_INWATER <- (1 << 9)		/**< In water */
::FL_FLY <- (1 << 10)		/**< Changes the SV_Movestep() behavior to not need to be on ground */
::FL_SWIM <- (1 << 11)		/**< Changes the SV_Movestep() behavior to not need to be on ground (but stay in water) */
::FL_CONVEYOR <- (1 << 12)
::FL_NPC <- (1 << 13)
::FL_GODMODE <- (1 << 14)
::FL_NOTARGET <- (1 << 15)
::FL_AIMTARGET <- (1 << 16)		/**< set if the crosshair needs to aim onto the entity */
::FL_PARTIALGROUND <- (1 << 17)		/**< not all corners are valid */
::FL_STATICPROP <- (1 << 18)		/**< Eetsa static prop!		 */
::FL_GRAPHED <- (1 << 19)		/**< worldgraph has this ent listed as something that blocks a connection */
::FL_GRENADE <- (1 << 20)
::FL_STEPMOVEMENT <- (1 << 21)		/**< Changes the SV_Movestep() behavior to not do any processing */
::FL_DONTTOUCH <- (1 << 22)		/**< Doesn't generate touch functions, generates Untouch() for anything it was touching when this flag was set */
::FL_BASEVELOCITY <- (1 << 23)		/**< Base velocity has been applied this frame (used to convert base velocity into momentum) */
::FL_WORLDBRUSH <- (1 << 24)		/**< Not moveable/removeable brush entity (really part of the world, but represented as an entity for transparency or something) */
::FL_OBJECT <- (1 << 25)		/**< Terrible name. This is an object that NPCs should see. Missiles, for example. */
::FL_KILLME <- (1 << 26)		/**< This entity is marked for death -- will be freed by game DLL */
::FL_ONFIRE <- (1 << 27)		/**< You know... */
::FL_DISSOLVING <- (1 << 28)		/**< We're dissolving! */
::FL_TRANSRAGDOLL <- (1 << 29)		/**< In the process of turning into a client side ragdoll. */
::FL_UNBLOCKABLE_BY_PLAYER <- (1 << 30)		/**< pusher that can't be blocked by the player */
::FL_FREEZING <- (1 << 31)		/**< We're becoming frozen! */
::FL_EP2V_UNKNOWN1 <- (1 << 31)		/**< Unknown */

// Entity Flags to be used with the m_iEFlags network property values
::EFL_KILLME <- (1<<0)		/**< This entity is marked for death -- This allows the game to actually delete ents at a safe time */
::EFL_DORMANT <- (1<<1)		/**< Entity is dormant, no updates to client */
::EFL_NOCLIP_ACTIVE <- (1<<2)		/**< Lets us know when the noclip command is active. */
::EFL_SETTING_UP_BONES <- (1<<3)		/**< Set while a model is setting up its bones. */
::EFL_KEEP_ON_RECREATE_ENTITIES <- (1<<4)		/**< This is a special entity that should not be deleted when we restart entities only */
::EFL_DIRTY_SHADOWUPDATE <- (1<<5)		/**< Client only- need shadow manager to update the shadow... */
::EFL_NOTIFY <- (1<<6)		/**< Another entity is watching events on this entity (used by teleport) */
::EFL_FORCE_CHECK_TRANSMIT <- (1<<7)
::EFL_BOT_FROZEN <- (1<<8)		/**< This is set on bots that are frozen. */
::EFL_SERVER_ONLY <- (1<<9)		/**< Non-networked entity. */
::EFL_NO_AUTO_EDICT_ATTACH <- (1<<10)		/**< Don't attach the edict we're doing it explicitly */
::EFL_DIRTY_ABSTRANSFORM <- (1<<11)
::EFL_DIRTY_ABSVELOCITY <- (1<<12)
::EFL_DIRTY_ABSANGVELOCITY <- (1<<13)
::EFL_DIRTY_SURROUNDING_COLLISION_BOUNDS <- (1<<14)
::EFL_DIRTY_SPATIAL_PARTITION <- (1<<15)
::EFL_HAS_PLAYER_CHILD <- (1<<16)		/**< One of the child entities is a player. */
::EFL_IN_SKYBOX <- (1<<17)		/**< This is set if the entity detects that it's in the skybox. This forces it to pass the "in PVS" for transmission. */
::EFL_USE_PARTITION_WHEN_NOT_SOLID <- (1<<18)		/**< Entities with this flag set show up in the partition even when not solid */
::EFL_TOUCHING_FLUID <- (1<<19)		/**< Used to determine if an entity is floating */
::EFL_IS_BEING_LIFTED_BY_BARNACLE <- (1<<20)
::EFL_NO_ROTORWASH_PUSH <- (1<<21)		/**< I shouldn't be pushed by the rotorwash */
::EFL_NO_THINK_FUNCTION <- (1<<22)
::EFL_NO_GAME_PHYSICS_SIMULATION <- (1<<23)
::EFL_CHECK_UNTOUCH <- (1<<24)
::EFL_DONTBLOCKLOS <- (1<<25)		/**< I shouldn't block NPC line-of-sight */
::EFL_DONTWALKON <- (1<<26)		/**< NPCs should not walk on this entity */
::EFL_NO_DISSOLVE <- (1<<27)		/**< These guys shouldn't dissolve */
::EFL_NO_MEGAPHYSCANNON_RAGDOLL <- (1<<28)		/**< Mega physcannon can't ragdoll these guys. */
::EFL_NO_WATER_VELOCITY_CHANGE <- (1<<29)		/**< Don't adjust this entity's velocity when transitioning into water */
::EFL_NO_PHYSCANNON_INTERACTION <- (1<<30)		/**< Physcannon can't pick these up or punt them */
::EFL_NO_DAMAGE_FORCES <- (1<<31)		/**< Doesn't accept forces from physics damage */

// Move types to be used with network properties
::MOVETYPE_NONE <- 0
::MOVETYPE_ISOMETRIC <- 1
::MOVETYPE_WALK <- 2
::MOVETYPE_STEP <- 3
::MOVETYPE_FLY <- 4
::MOVETYPE_FLYGRAVITY <- 5	
::MOVETYPE_VPHYSICS <- 6
::MOVETYPE_PUSH <- 7
::MOVETYPE_NOCLIP <- 8
::MOVETYPE_LADDER <- 9
::MOVETYPE_OBSERVER <- 10
::MOVETYPE_CUSTOM <- 11

// Hitgroups to be used with m_LastHitGroup
::HITGROUP_GENERIC <- 0
::HITGROUP_HEAD <- 1
::HITGROUP_CHEST <- 2
::HITGROUP_STOMACH <- 3
::HITGROUP_LEFTARM <- 4
::HITGROUP_RIGHTARM <- 5
::HITGROUP_LEFTLEG <- 6
::HITGROUP_RIGHTLEG <- 7
::HITGROUP_GEAR <- 10 // alerts NPC, but doesn't do damage or bleed (1/100th damage)

// Damage types that can be used with Hurt(), etc
::DMG_GENERIC <- 0
::DMG_CRUSH <- (1 << 0)
::DMG_BULLET <- (1 << 1)
::DMG_SLASH <- (1 << 2)
::DMG_BURN <- (1 << 3)
::DMG_VEHICLE <- (1 << 4)
::DMG_FALL <- (1 << 5)
::DMG_BLAST <- (1 << 6)
::DMG_CLUB <- (1 << 7)
::DMG_SHOCK <- (1 << 8)
::DMG_SONIC <- (1 << 9)
::DMG_ENERGYBEAM <- (1 << 10)
::DMG_PREVENT_PHYSICS_FORCE <- (1 << 11)
::DMG_NEVERGIB <- (1 << 12)
::DMG_ALWAYSGIB <- (1 << 13)
::DMG_DROWN <- (1 << 14)
::DMG_PARALYZE <- (1 << 15)
::DMG_NERVEGAS <- (1 << 16)
::DMG_POISON <- (1 << 17)
::DMG_RADIATION <- (1 << 18)
::DMG_DROWNRECOVER <- (1 << 19)
::DMG_CHOKE <- (1 << 20)
::DMG_ACID <- (1 << 20)
::DMG_MELEE <- (1 << 21)
::DMG_SLOWBURN <- (1 << 21)
::DMG_REMOVENORAGDOLL <- (1 << 22)
::DMG_PHYSGUN <- (1 << 23)
::DMG_PLASMA <- (1 << 24)
::DMG_STUMBLE <- (1 << 25)
::DMG_AIRBOAT <- (1 << 25)
::DMG_DISSOLVE <- (1 << 26)
::DMG_BLAST_SURFACE <- (1 << 27)
::DMG_DIRECT <- (1 << 28)
::DMG_BUCKSHOT <- (1 << 29)
::DMG_HEADSHOT <- (1 << 30)
::DMG_DISMEMBER <- (1 << 31)

// Settings for the m_takedamage network property
::DAMAGE_NO <- 0
::DAMAGE_EVENTS_ONLY <- 1
::DAMAGE_YES <- 2
::DAMAGE_AIM <- 3

// "Zombie" types, to be used with GetPlayerType()
::Z_INFECTED <- 0
::Z_COMMON <- 0
::Z_SMOKER <- 1
::Z_BOOMER <- 2
::Z_HUNTER <- 3
::Z_SPITTER <- 4
::Z_JOCKEY <- 5
::Z_CHARGER <- 6
::Z_WITCH <- 7
::Z_TANK <- 8
::Z_SURVIVOR <- 9
::Z_MOB <- 10
::Z_WITCH_BRIDE <- 11

// RenderModes
::RENDER_NORMAL <- 0		/**< src */
::RENDER_TRANSCOLOR <- 1		/**< c*a+dest*(1-a) */
::RENDER_TRANSTEXTURE <- 2		/**< src*a+dest*(1-a) */
::RENDER_GLOW <- 3		/**< src*a+dest -- No Z buffer checks -- Fixed size in screen space */
::RENDER_TRANSALPHA <- 4		/**< src*srca+dest*(1-srca) */
::RENDER_TRANSADD <- 5		/**< src*a+dest */
::RENDER_ENVIRONMENTAL <- 6		/**< not drawn, used for environmental effects */
::RENDER_TRANSADDFRAMEBLEND <- 7		/**< use a fractional frame value to blend between animation frames */
::RENDER_TRANSALPHAADD <- 8		/**< src + dest*(1-a) */
::RENDER_WORLDGLOW <- 9		/**< Same as kRenderGlow but not fixed size in screen space */
::RENDER_NONE <- 10		/**< Don't render. */

// RenderFx
::RENDERFX_NONE <- 0
::RENDERFX_PULSE_SLOW <- 1
::RENDERFX_PULSE_FAST <- 2
::RENDERFX_PULSE_SLOW_WIDE <- 3
::RENDERFX_PULSE_FAST_WIDE <- 4
::RENDERFX_FADE_SLOW <- 5
::RENDERFX_FADE_FAST <- 6
::RENDERFX_SOLID_SLOW <- 7
::RENDERFX_SOLID_FAST <- 8
::RENDERFX_STROBE_SLOW <- 9
::RENDERFX_STROBE_FAST <- 10
::RENDERFX_STROBE_FASTER <- 11
::RENDERFX_FLICKER_SLOW <- 12
::RENDERFX_FLICKER_FAST <- 13
::RENDERFX_NO_DISSIPATION <- 14
::RENDERFX_DISTORT <- 15		/**< Distort/scale/translate flicker */
::RENDERFX_HOLOGRAM <- 16		/**< kRenderFxDistort + distance fade */
::RENDERFX_EXPLODE <- 17		/**< Scale up really big! */
::RENDERFX_GLOWSHELL <- 18		/**< Glowing Shell */
::RENDERFX_CLAMP_MIN_SCALE <- 19		/**< Keep this sprite from getting very small (SPRITES only!) */
::RENDERFX_ENV_RAIN <- 20		/**< for environmental rendermode, make rain */
::RENDERFX_ENV_SNOW <- 21		/**<  "        "            "    , make snow */
::RENDERFX_SPOTLIGHT <- 22		/**< TEST CODE for experimental spotlight */
::RENDERFX_RAGDOLL <- 23		/**< HACKHACK: TEST CODE for signalling death of a ragdoll character */
::RENDERFX_PULSE_FAST_WIDER <- 24
::RENDERFX_MAX <- 25