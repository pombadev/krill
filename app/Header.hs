module Header (make) where

import qualified Brick
import qualified Brick.Widgets.Border as B
import qualified Brick.Widgets.Border.Style as BS
import qualified Data.Text as T

headers :: [(T.Text, BS.BorderStyle)]
headers =
    [ ("Active", BS.unicodeRounded)
    , ("Recent", BS.unicodeRounded)
    , ("Comments", BS.unicodeRounded)
    , ("Search", BS.unicodeRounded)
    ]

makeHeaders :: (T.Text, BS.BorderStyle) -> Brick.Widget ()
makeHeaders (styleName, sty) =
    Brick.withBorderStyle sty $
        B.border $
            Brick.txt $ "  " <> styleName <> " "

make :: [Brick.Widget ()]
make =
    makeHeaders <$> headers