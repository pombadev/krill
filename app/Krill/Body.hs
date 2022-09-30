module Krill.Body (make) where

import Brick (Widget, str)
import Brick.Widgets.Border (border)
import Brick.Widgets.Border.Style (unicode)
import Brick.Widgets.Center (center)
import Brick.Widgets.Core (withBorderStyle)

make :: Show s => s -> Widget n
make state =
    withBorderStyle unicode $
        border $
            center (str (show state))
