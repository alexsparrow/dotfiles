import Dzen
import XMonad
import XMonad.Util.EZConfig
import XMonad.Config.Gnome
import XMonad.Util.Run(spawnPipe)
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.UrgencyHook
import System.IO

import XMonad.Actions.GridSelect

import qualified Data.Map as M
import qualified XMonad.StackSet as W


import XMonad.Layout
import XMonad.Layout.Grid
import XMonad.Layout.IM
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
import XMonad.Layout.ResizableTile
import XMonad.Layout.StackTile
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.Tabbed
import Data.Ratio ((%))
import XMonad.Util.Dmenu

import qualified XMonad.StackSet as SS
import XMonad.Actions.DynamicWorkspaces

import qualified XMonad.Prompt as XMP
import XMonad.Prompt.Shell
import XMonad.Prompt.XMonad
import XMonad.Prompt.RunOrRaise
import XMonad.Layout.Spiral

import XMonad.Actions.SpawnOn


myManageHook :: [ManageHook]
myManageHook =
    [ resource  =? "Do"   --> doIgnore
    ,  className =? "Synapse" --> doIgnore
    , className =? "Skype"          --> moveTo "2:chat"
    , className =? "Evolution"    --> moveTo "1:mail"
    , className =? "Transmission" --> moveTo "8:bs"
    , composeOne [
      transience
     , isFullscreen -?> doFullFloat
      ]
      -- Move any window related to Evo to the 8th desktop and float it (it
      -- currently freaks out as fullscreen in xmonad). Hopefully Evo will die
      -- soon.
    , isInProperty "WM_NAME" "Koala" --> composeAll [moveTo "8:bs", doRectFloat (SS.RationalRect 0.1 0.05 0.3 0.7)]
    , isInProperty "WM_NAME" "Vievo" --> moveTo "8:bs"
    , className =? "Gloobus-preview"   --> doCenterFloat
    ]
    where moveTo = doF . W.shift


-- Layouts
myLayout = avoidStruts $ onWorkspace "2:chat" imLayout $ standardLayouts
  where
    -- define the list of standardLayouts
    standardLayouts = tiled ||| Mirror tiled ||| Full ||| simpleTabbed ||| spiral (6/7)

    -- notice withIM is acting on it
    imLayout        = withIM (1%7) skypeRoster Grid

    -- default tiling algorithm partitions the screen into two panes
    tiled   = Tall nmaster delta ratio

    -- The default number of windows in the master pane
    nmaster = 1

    -- Default proportion of screen occupied by master pane
    ratio   = 1/2

    -- Percent of screen to increment by when resizing panes
    delta   = 3/100

    skypeRoster     = (ClassName "Skype") `And` (Not (Title "Options")) `And` (Not (Role "Chats")) `And` (Not (Role "CallWindowForm"))

dzenBar :: DzenConf
dzenBar = defaultDzen
    -- use the default as a base and override width and
    -- colors
    {
       width   = Just $ Percent 100
    ,  height = Just 17
    , fgColor = Just "#909090"
    , bgColor = Just "#303030"
    }

myLogHook h = dynamicLogWithPP $ defaultPP -- the h here...
    -- display current workspace as darkgrey on light grey (opposite of default colors)
    { ppCurrent         = dzenColor "#303030" "#909090" . pad

    -- display other workspaces which contain windows as a brighter grey
    , ppHidden          = dzenColor "#909090" "" . pad

    -- display other workspaces with no windows as a normal grey
    , ppHiddenNoWindows = dzenColor "#606060" "" . pad

    -- display the current layout as a brighter grey
    , ppLayout          = dzenColor "#909090" "" . pad

    -- if a window on a hidden workspace needs my attention, color it so
    , ppUrgent          = dzenColor "#ff0000" "" . pad . dzenStrip

    -- shorten if it goes over 100 characters
    , ppTitle           = shorten 100

    -- no separator between workspaces
    , ppWsSep           = ""

    -- put a few spaces between each object
    , ppSep             = "  "

    , ppOutput          = hPutStrLn h -- ... must match the h here
    }

main = do
  d <- spawnDzen dzenBar
  xmonad $ withUrgencyHook NoUrgencyHook $ defaultConfig
    { manageHook = composeAll myManageHook <+> manageDocks
    , modMask = mod4Mask
    , terminal = "urxvtc"
    , logHook = myLogHook d
    , workspaces = ["1:mail", "2:chat", "3:web", "4:code", "5:term", "6:write", "7:read", "8:bs", "9:etc"]
    , keys = newKeys
    , layoutHook = smartBorders (myLayout)
--           , normalBorderColor = "#3f3c6d"
--           , focusedBorderColor = "#4f66ff"
        }

-- raiseVolume = spawn "aumix -v -2"
-- lowerVolume = spawn "aumix -v +2"
-- muteVolume = spawn "amixer -q set PCM toggle"

raiseVolume = spawn "amixer -c 0 set Master 2+ unmute"
lowerVolume = spawn "amixer -c 0 set Master 2-"
muteVolume = spawn "amixer sset Master toggle"

newKeys x  = M.union (keys defaultConfig x) (M.fromList (myKeys x))
myKeys conf@(XConfig {XMonad.modMask = modm}) =
  [
    ((modm, xK_g), goToSelected defaultGSConfig)
  , ((modm, xK_BackSpace), focusUrgent)
  , ((modm, xK_p), spawn "exe=`dmenu_run -b -nb black -nf yellow -sf yellow` && eval \"exec $exe\"")
  , ((modm .|. shiftMask, xK_l), spawn "xscreensaver-command -lock")
  , ((modm, xK_F12), raiseVolume)
  , ((modm, xK_F11), lowerVolume)
  , ((modm, xK_F10), muteVolume)
  , ((modm, xK_o), runOrRaisePrompt XMP.defaultXPConfig)
  , ((modm, xK_s), shellPrompt XMP.defaultXPConfig)
  , ((modm, xK_f), spawnHere "firefox")
  , ((modm, xK_x), spawnHere "emacsclient -c -n -a '' ")
  , ((modm, xK_BackSpace), focusUrgent)
  , ((modm, xK_F9), spawn "mpc toggle")
  , ((modm, xK_F8), spawn "~/.alexdot/bin/touchpad.sh")
  ]
