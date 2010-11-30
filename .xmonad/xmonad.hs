import XMonad
import XMonad.Util.EZConfig
import XMonad.Config.Gnome

myManageHook :: [ManageHook]
myManageHook = 
    [ resource  =? "Do"   --> doIgnore ]

main = xmonad gnomeConfig
    { manageHook = manageHook gnomeConfig <+> composeAll myManageHook
	, modMask = mod4Mask
         , terminal = "urxvt" }

