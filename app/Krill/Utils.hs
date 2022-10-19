{-# OPTIONS_GHC -Wno-type-defaults #-}

module Krill.Utils (hottest, Lobster (..)) where

import Network.HTTP.Request (
    Method (GET),
    Request (Request),
    Response (responseBody),
    send,
 )

-- import Control.Monad.IO.Class (MonadIO (liftIO))
import Data.Aeson
import Data.ByteString (fromStrict)

-- import Data.Maybe (fromJust)

import Control.Concurrent (Chan, writeChan)
import Data.Maybe (fromJust)
import GHC.Generics (Generic)

data Lobster = Lobster
    { title :: String
    , url :: Maybe String
    , short_id_url :: String
    }
    deriving (Show, Generic)

instance FromJSON Lobster
instance ToJSON Lobster

hottest :: Chan [Lobster] -> IO ()
hottest c = do
    let req = do
            Request
                GET
                "https://lobste.rs/hottest"
                [("Accept", "application/json"), ("User-Agent", "Hola/v1")]
                Nothing

    res <- send req

    let body = responseBody res

    -- crash if no value for now
    let r = fromJust $ decode (fromStrict body)

    writeChan c r
