module Krill.Types (KrillState (..), KrillView (..), generateStates) where

-- | The state
data KrillView = Hottest | Active | Recent | Help deriving (Show, Eq, Enum, Bounded, Ord)

-- thanks @geekosaur for this on https://web.libera.chat/#haskell
generateStates :: [KrillView]
generateStates = [minBound .. maxBound]

data KrillState = KrillState
    { prev :: Maybe KrillView
    , current :: KrillView
    }
    deriving (Show, Eq, Ord)
