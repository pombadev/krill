module Krill.Footer (make) where

import Brick (Widget, str, withBorderStyle)
import Brick.Widgets.Border (border)
import Brick.Widgets.Border.Style (unicodeRounded)

make :: s -> [Widget n]
make _ =
    [ withBorderStyle unicodeRounded $ border $ str "Next"
    , withBorderStyle unicodeRounded $ border $ str "Prev"
    ]