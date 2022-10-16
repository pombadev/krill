module Krill.Help (make) where

import Brick (Widget, str)
import Brick.Widgets.Center (hCenter)
import Brick.Widgets.Core (vBox)
import Brick.Widgets.Dialog (dialog, renderDialog)

make :: p -> [Widget n]
make _ =
    let helpDialog = renderDialog $ dialog (Just " Help ") Nothing 50
     in let helpBody =
                [ helpDialog
                    ( vBox
                        [ hCenter $ str "Press `a` for Active"
                        , hCenter $ str "Press `r` for Recent"
                        , hCenter $ str "Press `h` for Hottest"
                        , hCenter $ str "Press `?` for Help"
                        , hCenter $ str "Press `q` to quit"
                        , hCenter $ str "Press `Esc` to go back"
                        ]
                    )
                ]
         in helpBody