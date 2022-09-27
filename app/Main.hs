module Main (main) where

import qualified Brick
import qualified Brick.Widgets.Center as C

import Brick (BrickEvent (VtyEvent), defaultMain, halt, showFirstCursor, (<=>))
import Brick.AttrMap (attrMap)

import qualified Brick.Types as T
import qualified Graphics.Vty as V

-- import Brick.Widgets.Core ((<+>))

-- import Brick.Widgets.Core (str)
import qualified Krill.Body as Body
import qualified Krill.Footer as Footer
import qualified Krill.Header as Header

data KrillState = Active | Recent | Comments | Search deriving (Show)

appEvent :: BrickEvent () e -> T.EventM () s ()
appEvent (VtyEvent ev) =
    case ev of
        V.EvKey V.KEsc [] -> halt
        V.EvKey (V.KChar 'q') [] -> halt
        _ -> return ()
appEvent _ = return ()

ui :: KrillState -> [Brick.Widget ()]
ui s =
    [ C.hCenter
        (Brick.hBox Header.make)
        -- <=> C.hCenter (str (show s))
        -- <+> Brick.txt "Text"
        <=> Body.make s
        <=> C.hCenter Footer.make
    ]

main :: IO ()
main = do
    let app =
            Brick.App
                { appDraw = ui
                , appChooseCursor = showFirstCursor
                , appHandleEvent = appEvent
                , appStartEvent = return ()
                , appAttrMap = const $ attrMap V.defAttr []
                }

    state <- defaultMain app Active

    print $ "State: " ++ show state