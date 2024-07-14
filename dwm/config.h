#define XF86AudioMute         0x1008ff12
#define XF86AudioLowerVolume  0x1008ff11
#define XF86AudioRaiseVolume  0x1008ff13
#define XF86AudioPlay         0x1008ff14
#define XF86MonBrightnessDown 0x1008ff03
#define XF86MonBrightnessUp   0x1008ff02

static const unsigned int borderpx = 0;
static const unsigned int snap     = 32;
static const int showbar           = 0;
static const int topbar            = 1;
static const float mfact           = 0.55;
static const int nmaster           = 1;
static const int resizehints       = 0;
static const int lockfullscreen    = 1;
static const Layout layouts[]      = { { "", tile } };
static const Rule rules[]          = { { NULL, NULL, NULL, 0, False, -1 } };
static const char *tags[]          = { "chat", "dev", "irc", "recon", "supernets", "work", "www", "media", "other" };
static const char *fonts[]         = { "Misc Ohsnap.Icons:style=Regular:size=11" };
static const char dmenufont[]      = "Misc Ohsnap.Icons:style=Regular:size=11";
static const char *colors[][3]     = {
	[SchemeNorm]   = { "#FFFFFF", "#000000", "#444444" },
	[SchemeSel]    = { "#00D787", "#000000", "#00D787" },
};

#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY, view,       {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY, toggleview, {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY, tag,        {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY, toggletag,  {.ui = 1 << TAG} },

#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

static       char  dmenumon[2]      = "0"; // TODO: Do we really need this?
static const char *dmenucmd[]       = { "dmenu_run", "-m", "0", "-fn", dmenufont, "-nb", "#000000", "-nf", "#FFFFFF", "-sb", "#000000", "-sf", "#00D787", NULL };
static const char *termcmd[]        = { "alacritty", NULL };
static const char *volume_toggle[]  = { "pactl", "set-sink-mute", "0", "toggle", NULL };
static const char *volume_down[]    = { "amixer", "-q", "set", "Master", "10-", NULL };
static const char *volume_up[]      = { "amixer", "-q", "set", "Master", "10+", NULL };
static const char *music_toggle[]   = { "cmus-remote", "-u", NULL };
static const char *backlight_down[] = { "xbacklight", "-dec", "10", NULL };
static const char *backlight_up[]   = { "xbacklight", "-inc", "10", NULL };

static Key keys[] = {
	{ MODKEY, XK_Return,             spawn,      {.v = termcmd } },
	{ MODKEY, XK_Down,               incnmaster, {.i = +1 } },
	{ MODKEY, XK_Up,                 incnmaster, {.i = -1 } },
	{ MODKEY, XK_Left,               setmfact,   {.f = -0.05} },
	{ MODKEY, XK_Right,              setmfact,   {.f = +0.05} },
	{ MODKEY, XK_h,                  togglebar,  {0} },
	{ MODKEY, XK_k,                  killclient, {0} },
	{ MODKEY, XK_q,                  quit,       {0} },
	{ MODKEY, XK_f,                  setlayout,  {.v = &layouts[0]    } },
	{ MODKEY, XK_r,                  spawn,      {.v = dmenucmd       } },
	{      0, XF86AudioMute,         spawn,      {.v = volume_toggle  } },
	{      0, XF86AudioLowerVolume,  spawn,      {.v = volume_down    } },
	{      0, XF86AudioRaiseVolume,  spawn,      {.v = volume_up      } },
	{      0, XF86AudioPlay,         spawn,      {.v = music_toggle   } },
	{      0, XF86MonBrightnessDown, spawn,      {.v = backlight_down } },
	{      0, XF86MonBrightnessUp,   spawn,      {.v = backlight_up   } },
	{      0, XK_Print,              spawn,      SHCMD("~/.scripts/shotz -u") },
	TAGKEYS(  XK_1, 0)
	TAGKEYS(  XK_2, 1)
	TAGKEYS(  XK_3, 2)
	TAGKEYS(  XK_4, 3)
	TAGKEYS(  XK_5, 4)
	TAGKEYS(  XK_6, 5)
	TAGKEYS(  XK_7, 6)
	TAGKEYS(  XK_8, 7)
	TAGKEYS(  XK_9, 8)
};

static Button buttons[] = {
	{ ClkWinTitle,  0,      Button2, zoom,        {0} },
	{ ClkClientWin, MODKEY, Button1, movemouse,   {0} },
	{ ClkClientWin, MODKEY, Button3, resizemouse, {0} },
	{ ClkTagBar,    0,      Button1, view,        {0} },
	{ ClkTagBar,    MODKEY, Button1, tag,         {0} },
};
