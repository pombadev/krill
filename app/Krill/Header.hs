{-# HLINT ignore "Use tuple-section" #-}
module Krill.Header (make) where

import Brick (Widget, attrName, txt, withAttr, withBorderStyle)
import Brick.Widgets.Border (border)
import Brick.Widgets.Border.Style (BorderStyle, unicodeRounded)
import Data.Text (pack)

import Krill.Types (KrillState (..), KrillView, generateViews)

makeHeaders :: KrillState -> (KrillView, BorderStyle) -> Widget KrillView
makeHeaders state (view, sty) = do
    let item = txt (pack (show view))

    withBorderStyle sty $
        border $
            if state.current == view
                then withAttr (attrName "activeBtn") item
                else item

make :: KrillState -> [Widget KrillView]
make state = do
    let headers =
            makeHeaders state <$> map (\state' -> (state', unicodeRounded)) generateViews
     in headers