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
    modify,
    neverShowCursor,
    on,
    (<=>),
 )
import Brick.AttrMap (AttrMap)
import Brick.Types (EventM)
import Brick.Widgets.Center (hCenter)
import Graphics.Vty (Key (KChar, KEsc), black, white)
import Graphics.Vty.Input (Event (EvKey))

import qualified Krill.Body as Body
import qualified Krill.Cli as Cli
import qualified Krill.Footer as Footer
import qualified Krill.Header as Header
import qualified Krill.Help as KrillHelp
import Krill.Types (KrillAppState (..), KrillState (..), KrillView (..))
import Krill.Utils (Lobster)
import qualified Krill.Utils

import Control.Concurrent (Chan, forkIO, newChan)
import Control.Monad (when)
import Data.Maybe (fromMaybe)
import Text.Printf (printf)

appEvent :: BrickEvent KrillView e -> EventM KrillView KrillState ()
appEvent (VtyEvent ev) =
    case ev of
        EvKey KEsc [] -> modify (\s -> s{prev = Nothing, current = fromMaybe Hottest s.prev})
        EvKey (KChar 'a') [] -> modify (\s -> s{current = Active, prev = Just s.current})
        EvKey (KChar 'r') [] -> modify (\s -> s{current = Recent, prev = Just s.current})
        EvKey (KChar 'h') [] -> modify (\s -> s{current = Hottest, prev = Just s.current})
        EvKey (KChar '?') [] -> modify (\s -> s{current = Help, prev = Just s.current})
        EvKey (KChar 'q') [] -> halt
        _ -> return ()
appEvent _ = return ()

ui :: KrillState -> Chan [Lobster] -> [Widget KrillView]
ui state c =
    case state.current of
        Help -> KrillHelp.make state
        _ ->
            [ hCenter (hBox (Header.make state))
                <=> Body.make state c
                <=> hCenter (hBox $ Footer.make state)
            ]

attributeMap :: AttrMap
attributeMap =
    attrMap
        (white `on` black)
        [ (attrName "activeBtn", black `on` white)
        -- , (dialogAttr, white `on` blue)
        -- , (buttonAttr, black `on` white)
        -- , (buttonSelectedAttr, bg red)
        ]

main :: IO ()
main = do
    isTui <- Cli.run

    when isTui $ do
        comm <- newChan

        let app =
                App
                    { appDraw = \s -> ui s comm
                    , appChooseCursor = neverShowCursor
                    , appHandleEvent = appEvent
                    , appStartEvent = return ()
                    , appAttrMap = const attributeMap
                    }

        let s = KrillState{kState = Loading, prev = Nothing, current = Hottest}

        _ <- forkIO $ Krill.Utils.hottest comm

        state <- defaultMain app s

        printf "Selected state is `%s`, previous state was `%s`\n" (show state.current) (show state.prev)

        return ()