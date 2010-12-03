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
        , workspaces = ["mail", "chat", "web", "code", "physics", "term", "papers", "surf", "misc"]
--           , normalBorderColor = "#3f3c6d"
--           , focusedBorderColor = "#4f66ff"
}

