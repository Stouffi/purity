module Main where

import Prelude

import Control.Monad.Indexed ((:*>))
import Data.Int (fromString)
import Data.Maybe (Maybe(..), fromMaybe)
import Effect (Effect)
import Hyper.Node.Server (Hostname(..), Port(..), Options, defaultOptionsWithLogging, runServer)
import Hyper.Response (closeHeaders, respond, writeStatus)
import Hyper.Status (statusOK)
import Node.Process (lookupEnv)

defaultPort :: Int
defaultPort = 3000

portFromEnv :: Maybe String -> Int
portFromEnv (Nothing) = defaultPort
portFromEnv (Just p) = fromMaybe defaultPort portFromString
  where portFromString = fromString p

serverOptions :: Effect Options
serverOptions = do
  port <- lookupEnv "PORT"
  pure defaultOptionsWithLogging
    { hostname = Hostname "0.0.0.0"
    , port = Port (portFromEnv port)
    }

main :: Effect Unit
main = do
  opts <- serverOptions
  let app = writeStatus statusOK
        :*> closeHeaders
        :*> respond "Hello, Hyper!"
  runServer opts {} app
