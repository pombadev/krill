module Krill.Body (make) where

import Brick (Widget, str)
import Brick.Widgets.Border (border)
import Brick.Widgets.Border.Style (unicode)
import Brick.Widgets.Center (center)
import Brick.Widgets.Core (withBorderStyle)

import Control.Concurrent (Chan, readChan)
import GHC.IO (unsafePerformIO)

-- import Brick.Widgets.List (GenericList, List, renderList)
import Krill.Types (KrillState, KrillView)
import Krill.Utils (Lobster (..))

make :: KrillState -> Chan [Lobster] -> Widget KrillView
make _ comm = do
    let r = unsafePerformIO (readChan comm)

    let b = unlines $ map (\i -> i.title) r

    -- let box = renderList (\_ _ -> str "") True [str "test"]

    let f = withBorderStyle unicode $ border $ center (str b)
     in f
