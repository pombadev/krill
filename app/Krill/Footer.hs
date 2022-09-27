module Krill.Footer (make) where

import qualified Brick

make :: Brick.Widget n
make =
    Brick.hBox [Brick.txt "Press Esc/q to quit"]