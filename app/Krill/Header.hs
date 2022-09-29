{-# OPTIONS_GHC -Wno-redundant-constraints #-}

module Krill.Header (make) where

import Brick (Widget, attrName, txt, withAttr, withBorderStyle)
import Brick.Widgets.Border (border)
import Brick.Widgets.Border.Style (BorderStyle, unicodeRounded)
import Data.Text (Text, pack)

import Krill.Types (KrillState)

headers :: [(Text, BorderStyle)]
headers =
    [ ("Active", unicodeRounded)
    , ("Recent", unicodeRounded)
    , ("Comments", unicodeRounded)
    , ("Search", unicodeRounded)
    ]

makeHeaders :: KrillState -> (Text, BorderStyle) -> Widget ()
makeHeaders st (view, sty) = do
    let stt = pack (show st)

    withBorderStyle sty $
        border $
            if stt == view
                then
                    withAttr (attrName "activeBtn") $
                        txt view
                else txt view

make :: KrillState -> [Widget ()]
make st = do
    let hs =
            makeHeaders st <$> headers
     in hs