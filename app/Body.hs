module Body (make) where

import qualified Brick
import qualified Brick.Widgets.Border as B
import qualified Brick.Widgets.Border.Style as BS
import qualified Brick.Widgets.Center as C

make :: Brick.Widget n
make =
    Brick.withBorderStyle BS.unicode $
        B.border $
            C.center (Brick.str "Content")
