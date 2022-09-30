module Krill.Types (KrillState (..), genState) where

-- | The state
data KrillState = Hottest | Active | Recent | Help deriving (Show, Eq, Enum, Bounded)

-- thanks @geekosaur for this!
-- https://web.libera.chat/#haskell
genState :: [KrillState]
genState = [minBound .. maxBound]