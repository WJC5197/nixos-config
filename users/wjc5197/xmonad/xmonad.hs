module Main where

import Config (logosXMonad)
import StatusBar (logosXmobar)
import XMonad (xmonad)
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.StatusBar

main :: IO ()
main =
  xmonad
    . ewmhFullscreen
    . ewmh
    . withEasySB logosXmobar defToggleStrutsKey
    $ logosXMonad
