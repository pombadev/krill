module Krill.Types (
    KrillState (..),
    KrillView (..),
    KrillAppState (..),
    generateViews,
) where

-- | The state
data KrillView = Hottest | Active | Recent | Help
    deriving (Show, Eq, Enum, Bounded, Ord)

-- thanks @geekosaur for this on https://web.libera.chat/#haskell
generateViews :: [KrillView]
generateViews = [minBound .. maxBound]

data KrillAppState = Loading | Loaded
    deriving (Eq, Show, Ord)

data KrillState = KrillState
    { prev :: Maybe KrillView
    , current :: KrillView
    , kState :: KrillAppState
    }
    deriving (Show, Eq, Ord)
