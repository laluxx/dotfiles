module Colors.Pywal
    ( colorScheme
    , colorBack
    , colorFore
    , color01
    , color02
    , color03
    , color04
    , color05
    , color06
    , color07
    , color08
    , color09
    , color10
    , color11
    , color12
    , color13
    , color14
    , color15
    , color16
    , colorTrayer
    ) where

import System.IO.Unsafe (unsafePerformIO)

-- Read Pywal colors
getPywalColor :: Int -> String
getPywalColor i = unsafePerformIO $ do
    let colorsFile = "/home/l/.cache/wal/colors.sh"  -- Replace this with your actual path
    colorsData <- readFile colorsFile
    let colorLines = lines colorsData
    return (drop 7 (colorLines !! (i+2))) -- To get the color

-- Define your color scheme using Pywal colors
colorBack :: String
colorBack = getPywalColor 0

colorFore :: String
colorFore = getPywalColor 1

color01 :: String
color01 = getPywalColor 2

color02 :: String
color02 = getPywalColor 3

color03 :: String
color03 = getPywalColor 4

color04 :: String
color04 = getPywalColor 5

color05 :: String
color05 = getPywalColor 6

color06 :: String
color06 = getPywalColor 7

color07 :: String
color07 = getPywalColor 8

color08 :: String
color08 = getPywalColor 9

color09 :: String
color09 = getPywalColor 10

color10 :: String
color10 = getPywalColor 11

color11 :: String
color11 = getPywalColor 12

color12 :: String
color12 = getPywalColor 13

color13 :: String
color13 = getPywalColor 14

color14 :: String
color14 = getPywalColor 15

color15 :: String
color15 = getPywalColor 16

color16 :: String
color16 = getPywalColor 17

colorScheme :: String
colorScheme = "pywal"

colorTrayer :: String
colorTrayer = "--tint 0x" ++ drop 1 colorBack
