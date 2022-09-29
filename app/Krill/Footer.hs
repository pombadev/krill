module Krill.Footer (make) where

import Brick (Widget, hBox, txt)

make :: Widget n
make =
    hBox [txt "Press Esc/q to quit"]