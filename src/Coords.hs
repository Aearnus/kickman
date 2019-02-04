{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE DeriveFunctor #-}

module Coords where

import Config
import Debug.Trace
import Data.Function

res_WIDTH_D :: Double
res_WIDTH_D = fromIntegral res_WIDTH
res_HEIGHT_D :: Double
res_HEIGHT_D = fromIntegral res_HEIGHT

remeasure :: Floating a =>
             a -> a -- prebounds
          -> a -> a -- postbounds
          -> a      -- prevalue
          -> a
remeasure prebottom pretop postbottom posttop value =
  let percentThrough = (value - prebottom) / (pretop - prebottom)
  in  ((posttop - postbottom) * percentThrough) + postbottom

data CoordType = MapCoords | ScreenCoords
newtype Coords (a :: CoordType) = Coords (Double, Double) deriving (Show)

-- bounded vertically from -128 to 128
class ToMapCoords cs where
  toMapCoords :: cs -> Coords MapCoords
instance ToScreenCoords (Coords MapCoords) where
  toScreenCoords (Coords (x, y)) = Coords $ ((,) `on` (remeasure 128 (-128) 0 res_HEIGHT_D)) x y

-- bounded from 0 to RES_WIDTH and RES_HEIGHT
class ToScreenCoords cs where
  toScreenCoords :: cs -> Coords ScreenCoords
instance ToMapCoords (Coords ScreenCoords) where
  toMapCoords (Coords (x, y)) = Coords $ ((,) `on` (remeasure 0 res_HEIGHT_D 128 (-128))) x y

type LocalCharacterCoords = Coords MapCoords
type HitboxCharacterCoords = (Coords MapCoords, Coords MapCoords)
-- instance ToMapCoords HitboxCharacterCoords where
--   toMapCoords (local, global) = local + global
-- instance ToScreenCoords HitboxCharacterCoords where
--   toScreenCoords cs = toScreenCoords ((toMapCoords cs) :: MapCoords)
