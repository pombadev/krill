module Main (main) where

import Brick (
    App (..),
    BrickEvent (VtyEvent),
    Widget,
    appAttrMap,
    attrMap,
    attrName,
    defaultMain,
    emptyWidget,
    hBox,
    halt,
    on,
    put,
    showFirstCursor,
    str,
    vBox,
    (<=>),
 )

import Brick.AttrMap (AttrMap)
import Brick.Types (EventM)
import Brick.Widgets.Center (hCenter)
import Brick.Widgets.Dialog (dialog, renderDialog)

import Graphics.Vty (Key (KChar, KEsc), black, white)
import Graphics.Vty.Input (Event (EvKey))

import qualified Krill.Body as Body
import qualified Krill.Footer as Footer
import qualified Krill.Header as Header
import Krill.Types (KrillState (..))

appEvent :: BrickEvent () e -> EventM () KrillState ()
appEvent (VtyEvent ev) =
    case ev of
        EvKey KEsc [] -> put Hottest
        EvKey (KChar 'q') [] -> halt
        EvKey (KChar 'a') [] -> put Active
        EvKey (KChar 'r') [] -> put Recent
        EvKey (KChar 'h') [] -> put Hottest
        EvKey (KChar '?') [] -> put Help
        _ -> return ()
appEvent _ = return ()

ui :: KrillState -> [Widget ()]
ui state =
    let helpDialog = renderDialog $ dialog (Just " Help ") Nothing 50
     in [ hCenter
            (hBox (Header.make state))
            <=> ( if state == Help
                    then
                        helpDialog
                            ( vBox
                                [ hCenter $ str "Press `q` to quit"
                                , hCenter $ str "Press `a` for Active"
                                , hCenter $ str "Press `r` for Recent"
                                , hCenter $ str "Press `h` for Hottest"
                                , hCenter $ str "Press `?` for Help"
                                ]
                            )
                    else emptyWidget
                )
            <=> Body.make state
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

    _ <- defaultMain app Active

    return ()