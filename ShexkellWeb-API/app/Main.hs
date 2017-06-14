{-# LANGUAGE OverloadedStrings #-}

module Main where

import Lib
import Controller.ValidationController

import Web.Spock
import Web.Spock.Config
import Network.Wai.Middleware.Cors

import Control.Monad.Trans
import Data.Monoid
import Data.IORef
import qualified Data.Text as T


data MySession = EmptySession
data MyAppState = DummyAppState (IORef Int)


main :: IO ()
main = do 
  ref   <- newIORef 0
  spockCfg <- defaultSpockCfg () PCNoDatabase ()
  runSpock 8080 (spock spockCfg app)


app :: SpockM () () () ()
app = do
  middleware (cors $ const $ Just corsPolicy)
  post "validate" validation

corsPolicy :: CorsResourcePolicy
corsPolicy = CorsResourcePolicy {
    corsOrigins = Nothing
  , corsMethods = corsMethods simpleCorsResourcePolicy
  , corsRequestHeaders =["Authorization", "Content-Type"]
  , corsExposedHeaders = corsExposedHeaders simpleCorsResourcePolicy
  , corsMaxAge = corsMaxAge simpleCorsResourcePolicy
  , corsVaryOrigin = corsVaryOrigin simpleCorsResourcePolicy
  , corsRequireOrigin = False
  , corsIgnoreFailures = corsIgnoreFailures simpleCorsResourcePolicy
}