module Krill.Types (KrillState (..)) where

-- | The state
data KrillState = Active | Recent | Comments | Search deriving (Show)