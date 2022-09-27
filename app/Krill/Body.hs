module Krill.Body (make) where

import qualified Brick
import qualified Brick.Widgets.Border as B
import qualified Brick.Widgets.Border.Style as BS
import qualified Brick.Widgets.Center as C

make :: Show s => s -> Brick.Widget n
make mystate =
    Brick.withBorderStyle BS.unicode $
        B.border $
            C.center (Brick.str (show mystate))
