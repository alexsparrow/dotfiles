import XMonad
import XMonad.Util.EZConfig
import XMonad.Config.Gnome
import XMonad.Util.Run(spawnPipe)
import XMonad.Hooks.DynamicLog
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

myManageHook :: [ManageHook]
myManageHook =
    [ resource  =? "Do"   --> doIgnore
    , className =? "Skype"          --> moveTo "2:chat"
    , className =? "Evolution"    --> moveTo "1:mail"
    ]
    where moveTo = doF . W.shift

-- Layouts
myLayout = avoidStruts $ onWorkspace "2:chat" imLayout $ standardLayouts
  where
    -- define the list of standardLayouts
    standardLayouts = tiled ||| Mirror tiled ||| Full ||| simpleTabbed

    -- notice withIM is acting on it
    imLayout        = withIM (1/10) skype (standardLayouts)

    -- default tiling algorithm partitions the screen into two panes
    tiled   = Tall nmaster delta ratio

    -- The default number of windows in the master pane
    nmaster = 1

    -- Default proportion of screen occupied by master pane
    ratio   = 1/2

    -- Percent of screen to increment by when resizing panes
    delta   = 3/100

    skype = Title "alex_sparrow - Skype™ (Beta)" `Or` Title "Skype™ 2.1 (Beta) for Linux"

main = do
  xmproc <- spawnPipe "xmobar"
  xmonad $ gnomeConfig
    { manageHook = manageHook gnomeConfig <+> composeAll myManageHook
    , modMask = mod4Mask
    , terminal = "urxvt"
    , logHook = dynamicLogWithPP $ xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
    , workspaces = ["1:mail", "2:chat", "3:web", "4:code", "5:term", "6:write", "7:read", "8:bs", "9:etc"]
    , keys = newKeys
     , layoutHook = myLayout
--           , normalBorderColor = "#3f3c6d"
--           , focusedBorderColor = "#4f66ff"
        }

newKeys x  = M.union (keys defaultConfig x) (M.fromList (myKeys x))
myKeys conf@(XConfig {XMonad.modMask = modm}) =
  [
    ((modm, xK_g), goToSelected defaultGSConfig)
  ]

