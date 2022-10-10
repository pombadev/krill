{-# OPTIONS_GHC -Wno-type-defaults #-}

module Krill.Utils (hottest) where

import Network.HTTP.Request

-- import Control.Monad.IO.Class (MonadIO (liftIO))
import Data.Aeson
import Data.ByteString (fromStrict)

-- import Data.Maybe (fromJust)
import GHC.Generics (Generic)

data Lobster = Lobster
    { title :: String
    , url :: Maybe String
    , short_id_url :: String
    }
    deriving (Show, Generic)

instance FromJSON Lobster
instance ToJSON Lobster

hottest :: IO ()
hottest = do
    let req = do
            Request
                GET
                "https://lobste.rs/hottest"
                [("Accept", "application/json"), ("User-Agent", "Hola/v1")]
                Nothing

    res <- send req

    let body = responseBody res

    let c = decode (fromStrict body) :: Maybe [Lobster]

    print c

    return ()