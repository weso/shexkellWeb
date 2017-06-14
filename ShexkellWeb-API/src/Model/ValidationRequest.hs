{-# LANGUAGE DeriveGeneric #-}

module Model.ValidationRequest where


import GHC.Generics

import Shexkell
import Shexkell.Data.ShEx
import Shexkell.Text.JSON.ShexParser

import Data.RDF

import Data.Aeson

import qualified Data.Text as T


data ValidationRequest = ValidationRequest {
    schema   :: String
  , shapeMap :: String
  , graph    :: String
} deriving (Generic, Show)

instance FromJSON ValidationRequest