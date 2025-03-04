module Config where

import qualified Data.Map as M
import Data.Monoid
import Graphics.X11.ExtraTypes.XF86
import System.Exit
import Theme
import XMonad
import qualified XMonad.StackSet as W
import XMonad.Util.SpawnOnce

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
logosTerminal = "kitty"

-- Whether focus follows the mouse pointer.
logosFocusFollowsMouse :: Bool
logosFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
logosClickJustFocuses :: Bool
logosClickJustFocuses = False

-- Width of the window border in pixels.
--
logosBorderWidth = 3

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
logosModMask = mod4Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
logosWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

-- Border colors for unfocused and focused windows, respectively.
--
logosNormalBorderColor = charcoalGrey

logosFocusedBorderColor = amethyst

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
logosKeys conf@(XConfig {XMonad.modMask = modm}) =
  M.fromList $
    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf),
      -- launch scort
      ((modm .|. shiftMask, xK_s), spawn "scrot -s '%Y%m%d-%H%M%S.png' -e 'mv $f ~/pictures/screenshots && feh ~/pictures/screenshots/$f' -z"),
      -- launch rofi
      ((modm, xK_p), spawn "rofi -show drun"),
      -- launch clipmenu
      ((modm, xK_v), spawn "clipmenu"),
      -- volume control
      ((0, xF86XK_AudioRaiseVolume), spawn "volume.sh up"),
      ((0, xF86XK_AudioLowerVolume), spawn "volume.sh down"),
      ((0, xF86XK_AudioMute), spawn "volume.sh mute"),
      -- screen brightness control
      ((0, xF86XK_MonBrightnessUp), spawn "brightnessctl s +5%"),
      ((0, xF86XK_MonBrightnessDown), spawn "brightnessctl s 5-%"),
      -- close focused window
      ((modm .|. shiftMask, xK_c), kill),
      -- Rotate through the available layout algorithms
      ((modm, xK_space), sendMessage NextLayout),
      --  Reset the layouts on the current workspace to default
      ((modm .|. shiftMask, xK_space), setLayout $ XMonad.layoutHook conf),
      -- Resize viewed windows to the correct size
      ((modm, xK_n), refresh),
      -- Move focus to the next window
      ((modm, xK_Tab), windows W.focusDown),
      -- Move focus to the next window
      ((modm .|. shiftMask, xK_Tab), windows W.focusUp),
      -- Move focus to the next window
      ((modm, xK_j), windows W.focusDown),
      -- Move focus to the previous window
      ((modm, xK_k), windows W.focusUp),
      -- Move focus to the master window
      ((modm, xK_m), windows W.focusMaster),
      -- Swap the focused window and the master window
      ((modm, xK_Return), windows W.swapMaster),
      -- Swap the focused window with the next window
      ((modm .|. shiftMask, xK_j), windows W.swapDown),
      -- Swap the focused window with the previous window
      ((modm .|. shiftMask, xK_k), windows W.swapUp),
      -- Shrink the master area
      ((modm, xK_h), sendMessage Shrink),
      -- Expand the master area
      ((modm, xK_l), sendMessage Expand),
      -- Push window back into tiling
      ((modm, xK_t), withFocused $ windows . W.sink),
      -- Increment the number of windows in the master area
      ((modm, xK_comma), sendMessage (IncMasterN 1)),
      -- Deincrement the number of windows in the master area
      ((modm, xK_period), sendMessage (IncMasterN (-1))),
      -- Toggle the status bar gap
      -- Use this binding with avoidStruts from Hooks.ManageDocks.
      -- See also the statusBar function from Hooks.DynamicLog.
      --
      -- , ((modm              , xK_b     ), sendMessage ToggleStruts)

      -- Quit xmonad
      ((modm .|. shiftMask, xK_q), io (exitWith ExitSuccess)),
      -- Restart xmonad
      ((modm, xK_q), spawn "xmonad --recompile; xmonad --restart")
    ]
      ++
      --
      -- mod-[1..9], Switch to workspace N
      -- mod-shift-[1..9], Move client to workspace N
      --
      [ ((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9],
          (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
      ]
      ++
      --
      -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
      -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
      --
      [ ((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0 ..],
          (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
      ]

------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
logosMouseBindings (XConfig {XMonad.modMask = modm}) =
  M.fromList $
    -- mod-button1, Set the window to floating mode and move by dragging
    [ ( (modm, button1),
        ( \w ->
            focus w
              >> mouseMoveWindow w
              >> windows W.shiftMaster
        )
      ),
      -- mod-button2, Raise the window to the top of the stack
      ((modm, button2), (\w -> focus w >> windows W.shiftMaster)),
      -- mod-button3, Set the window to floating mode and resize by dragging
      ( (modm, button3),
        ( \w ->
            focus w
              >> mouseResizeWindow w
              >> windows W.shiftMaster
        )
      )
      -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
logosLayout = tiled ||| Mirror tiled ||| Full
  where
    -- default tiling algorithm partitions the screen into two panes
    tiled = Tall nmaster delta ratio

    -- The default number of windows in the master pane
    nmaster = 1

    -- Default proportion of screen occupied by master pane
    ratio = 1 / 2

    -- Percent of screen to increment by when resizing panes
    delta = 3 / 100

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
logosManageHook =
  composeAll
    [ -- className =? "MPlayer" --> doFloat,
      -- className =? "Gimp" --> doFloat,
      resource =? "desktop_window" --> doIgnore,
      resource =? "kdesktop" --> doIgnore
    ]

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook

--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
logosEventHook = mempty

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
logosLogHook = return ()

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
logosStartupHook = do
  spawnOnce "CM_SELECTIONS=clipboard clipmenud"
  spawnOnce "dunst -conf ~/.config/dunst/dunstrc"
  spawnOnce "feh --bg-fill --no-fehbg ~/.wallpapers/haskell-xmonad.png"
  spawnOnce "redshift -c ~/.config/redshift/redshift.conf"
  -- spawnOnce "xautolock -time 30 -locker \"loginctl lock-session $XDG_SESSION_ID\""
  spawnOnce "xset s off"
  spawnOnce "xset dpms 0 0 1800" -- 30 mins
  spawnOnce "xss-lock -- betterlockscreen -l dim &"
-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
logosXMonad =
  def
    { -- basic
      terminal = logosTerminal,
      focusFollowsMouse = logosFocusFollowsMouse,
      clickJustFocuses = logosClickJustFocuses,
      borderWidth = logosBorderWidth,
      modMask = logosModMask,
      workspaces = logosWorkspaces,
      normalBorderColor = logosNormalBorderColor,
      focusedBorderColor = logosFocusedBorderColor,
      -- key bindings
      keys = logosKeys,
      mouseBindings = logosMouseBindings,
      -- hooks, layouts
      layoutHook = logosLayout,
      manageHook = logosManageHook,
      handleEventHook = logosEventHook,
      logHook = logosLogHook,
      startupHook = logosStartupHook
    }
