module Colors.Pywal where

import System.Environment (getEnv)
import XMonad

colorScheme :: String
colorScheme = "pywal"

-- Use environment variables to fetch colors
getWalColor :: String -> IO String
getWalColor color = getEnv $ "WAL_COLOR" ++ color

colorBack :: IO String
colorBack = getWalColor "0"

colorFore :: IO String
colorFore = getWalColor "7"

color01 :: IO String
color01 = getWalColor "0"

color02 :: IO String
color02 = getWalColor "1"

color03 :: IO String
color03 = getWalColor "2"

color04 :: IO String
color04 = getWalColor "3"

color05 :: IO String
color05 = getWalColor "4"

color06 :: IO String
color06 = getWalColor "5"

color07 :: IO String
color07 = getWalColor "6"

color08 :: IO String
color08 = getWalColor "7"

color09 :: IO String
color09 = getWalColor "8"

color10 :: IO String
color10 = getWalColor "9"

color11 :: IO String
color11 = getWalColor "10"

color12 :: IO String
color12 = getWalColor "11"

color13 :: IO String
color13 = getWalColor "12"

color14 :: IO String
color14 = getWalColor "13"

color15 :: IO String
color15 = getWalColor "14"

color16 :: IO String
color16 = getWalColor "15"

colorTrayer :: IO String
colorTrayer = do
  color <- getWalColor "0"
  return $ "--tint 0x" ++ drop 1 color
