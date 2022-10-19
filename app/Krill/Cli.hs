module Krill.Cli (run) where

import System.Console.GetOpt (
  ArgDescr (NoArg),
  ArgOrder (Permute),
  OptDescr (..),
  getOpt,
  usageInfo,
 )
import System.Environment (getArgs)
import System.Exit (exitFailure, exitSuccess)

data Flag = Help | Version | Verbose

options :: [OptDescr Flag]
options =
  [ Option ['v'] ["version"] (NoArg Version) "Print version information"
  , Option ['h'] ["help"] (NoArg Help) "Print help information"
  , Option ['V'] ["verbose"] (NoArg Verbose) "Log things to stdout"
  ]

-- | Run cli
run :: IO Bool
run = do
  args <- getArgs

  case getOpt Permute options args of
    (f, _, []) ->
      case f of
        [Help] -> putStr ("Unofficial TUI client for lobste.rs\n\n" ++ usageInfo header options) >> exitSuccess
        [Version] -> putStrLn "v0.1.0" >> exitSuccess
        [Verbose] -> putStrLn "verbose" >> exitSuccess
        [] -> return True
        _ ->
          putStrLn ("error: multiple flags can't be specified\n\n" ++ header) >> exitFailure
    (_, _, errs) -> do
      putStr $ concat errs ++ usageInfo header options
      exitFailure
 where
  header = "Usage: krill [-vVh]"
