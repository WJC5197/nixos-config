module StatusBar where

import Theme
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Util.EZConfig
import XMonad.Util.Loggers

logosXmobarPP :: PP
logosXmobarPP =
  def
    { ppCurrent = xcWhite . wrap " " "" . xmobarBorder "Top" golden 2,
      ppSep = xcApricot " | ",
      ppTitleSanitize = xmobarStrip,
      ppHidden = xcWhite . wrap " " "",
      ppHiddenNoWindows = xcDarkGrey . wrap " " "",
      ppUrgent = xcDarkRed . wrap (xcGolden "!") (xcGolden "!"),
      ppOrder = \[ws, l, _, wins] -> [ws, l, wins],
      ppExtras = [logTitles formatFocused formatUnfocused]
    }
  where
    formatFocused = wrap (xcWhite "[") (xcWhite "]") . xcGolden . ppWindow
    formatUnfocused = wrap (xcDarkGrey "[") (xcDarkGrey "]") . xcAmethyst . ppWindow

    -- \| Windows should have *some* title, which should not not exceed a
    -- sane length.
    ppWindow :: String -> String
    ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 15

    xcAmethyst, xcApricot, xcDarkGrey, xcDarkRed, xcGolden, xcWhite :: String -> String
    xcAmethyst = xmobarColor amethyst ""
    xcApricot = xmobarColor apricot ""
    xcDarkGrey = xmobarColor darkGrey ""
    xcDarkRed = xmobarColor darkRed ""
    xcGolden = xmobarColor golden ""
    xcWhite = xmobarColor white ""

logosXmobar = statusBarProp "xmobar" (pure logosXmobarPP)
