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
    showFirstCursor,
    suspendAndResume,
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
        EvKey (KChar 'a') [] -> suspendAndResume $ return Active
        EvKey (KChar 'r') [] -> suspendAndResume $ return Recent
        EvKey (KChar 'c') [] -> suspendAndResume $ return Comments
        EvKey (KChar 's') [] -> suspendAndResume $ return Search
        EvKey (KChar '?') [] -> suspendAndResume $ return Help
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