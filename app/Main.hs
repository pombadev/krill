module Main (main) where

import Brick ((<=>))
import qualified Brick
import qualified Brick.Widgets.Center as C

import qualified Body
import qualified Header

ui :: Brick.Widget ()
ui =
    C.hCenter
        (Brick.hBox Header.make)
        <=> Body.make

main :: IO ()
main = Brick.simpleMain ui
