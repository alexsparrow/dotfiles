import XMonad
import XMonad.Util.EZConfig
import XMonad.Config.Gnome
import XMonad.Util.Run(spawnPipe)
import XMonad.Hooks.DynamicLog
import System.IO

myManageHook :: [ManageHook]
myManageHook =
    [ resource  =? "Do"   --> doIgnore ]

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
--           , normalBorderColor = "#3f3c6d"
--           , focusedBorderColor = "#4f66ff"
}

