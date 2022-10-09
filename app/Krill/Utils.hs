module Krill.Utils (hottest) where

import Network.HTTP.Request

-- hottest :: IO ()
hottest = do
    putStrLn "Hello?"
    -- let req = Request GET "https://lobste.rs/hottest" [("Accept", "application/json")] Nothing
    --  in requestBody req
    res <- get "https://lobste.rs/hottest"

    -- res <- send req

    print $! ">>> " ++ show (responseStatus res)

    return ()