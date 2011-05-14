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

myManageHook :: [ManageHook]
myManageHook =
    [ resource  =? "Do"   --> doIgnore
    , className =? "Skype"          --> moveTo "2:chat"
    , className =? "Evolution"    --> moveTo "1:mail"
    , className =? "Transmission" --> moveTo "8:bs"
    , composeOne [
      transience,
      isFullscreen -?> doFullFloat
      ]
    ]
    where moveTo = doF . W.shift


-- Layouts
myLayout = avoidStruts $ onWorkspace "2:chat" imLayout $ standardLayouts
  where
    -- define the list of standardLayouts
    standardLayouts = tiled ||| Mirror tiled ||| Full ||| simpleTabbed

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
    , terminal = "urxvt"
    , logHook = myLogHook d
    , workspaces = ["1:mail", "2:chat", "3:web", "4:code", "5:term", "6:write", "7:read", "8:bs", "9:etc"]
    , keys = newKeys
     , layoutHook = smartBorders myLayout
--           , normalBorderColor = "#3f3c6d"
--           , focusedBorderColor = "#4f66ff"
        }

newKeys x  = M.union (keys defaultConfig x) (M.fromList (myKeys x))
myKeys conf@(XConfig {XMonad.modMask = modm}) =
  [
    ((modm, xK_g), goToSelected defaultGSConfig)
  , ((modm, xK_BackSpace), focusUrgent)
  , ((modm, xK_p), dmenu [] >> return ())
  , ((modm .|. shiftMask, xK_l), spawn "xscreensaver-command -lock")
  ]
