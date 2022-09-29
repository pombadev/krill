module Krill.Types (KrillState (..)) where

-- | The state
data KrillState = Active | Recent | Comments | Search | Help deriving (Show)