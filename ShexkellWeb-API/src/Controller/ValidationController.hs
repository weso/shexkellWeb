{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}

module Controller.ValidationController where

import Web.Spock 
import Web.Spock.Config
import Network.HTTP.Types.Status

import Control.Monad.Trans
import Data.Monoid
import qualified Data.Text as T

import Model.ValidationRequest

import Shexkell 


type Api = SpockM () () () ()

type ApiAction a = SpockAction () () () a


hello :: MonadIO m => T.Text -> ActionCtxT ctx m a
hello prueba = text $ "Hello" <> prueba


validation = do
  ValidationRequest{..} <- jsonBody' :: ApiAction ValidationRequest
  case validate (ShexOptions CompactFormat TurtleFormat) shapeMap graph schema of
    Right result -> json result
    Left err -> setStatus badRequest400 >> json err