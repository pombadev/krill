module Main (main) where

import Brick (
    App (..),
    BrickEvent (VtyEvent),
    Widget,
    appAttrMap,
    attrMap,
    attrName,
    defaultMain,
    hBox,
    halt,
    on,
    put,
    showFirstCursor,
    (<=>),
 )

import Brick.AttrMap (AttrMap)
import Brick.Types (EventM)
import Brick.Widgets.Center (hCenter)

import Graphics.Vty (Key (KChar, KEsc), black, white)
import Graphics.Vty.Input (Event (EvKey))

import qualified Krill.Body as Body
import qualified Krill.Footer as Footer
import qualified Krill.Header as Header
import Krill.Types (KrillState (..))

appEvent :: BrickEvent () e -> EventM () KrillState ()
appEvent (VtyEvent ev) =
    case ev of
        EvKey KEsc [] -> halt
        EvKey (KChar 'q') [] -> halt
        EvKey (KChar 'a') [] -> put Active
        EvKey (KChar 'r') [] -> put Recent
        EvKey (KChar 'c') [] -> put Comments
        EvKey (KChar 's') [] -> put Search
        EvKey (KChar '?') [] -> put Help
        _ -> return ()
appEvent _ = return ()

ui :: KrillState -> [Widget ()]
ui s =
    [ hCenter
        (hBox (Header.make s))
        <=> Body.make s
        <=> hCenter Footer.make
    ]

attributeMap :: AttrMap
attributeMap = attrMap (white `on` black) [(attrName "activeBtn", black `on` white)]

main :: IO ()
main = do
    let app =
            App
                { appDraw = ui
                , appChooseCursor = showFirstCursor
                , appHandleEvent = appEvent
                , appStartEvent = return ()
                , appAttrMap = const attributeMap
                }

    state <- defaultMain app Active

    print $ "State: " ++ show state