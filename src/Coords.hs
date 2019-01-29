{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE FlexibleInstances #-}

module Coords where

import Config

res_WIDTH_D :: Double
res_WIDTH_D = fromIntegral res_WIDTH
res_HEIGHT_D :: Double
res_HEIGHT_D = fromIntegral res_HEIGHT

type Coords = (Double, Double)
instance Num Coords where
  (+) (x1, y1) (x2, y2) = (x1 + x2, y1 + y2)
  (-) (x1, y1) (x2, y2) = (x1 - x2, y1 - y2)
  (*) (x1, y1) (x2, y2) = (x1 * x2, y1 * y2)
  abs                   = fmap abs
  signum                = fmap signum
  fromInteger a         = error "nonsense"

-- bounded vertically from -128 to 128
type MapCoords = Coords
class ToMapCoords cs where
  toMapCoords :: cs -> MapCoords
instance ToScreenCoords MapCoords where
  toScreenCoords (x, y) = (((x / 256) + 0.5) * res_HEIGHT_D, ((y / 256) + 0.5) * res_HEIGHT_D)

-- bounded from 0 to RES_WIDTH and RES_HEIGHT
type ScreenCoords = Coords
class ToScreenCoords cs where
  toScreenCoords :: cs -> ScreenCoords
instance ToMapCoords ScreenCoords where
  toMapCoords (x, y) = (((x / res_HEIGHT_D) * 256) - 128, ((y / res_HEIGHT_D) * 256) - 128)

type LocalCharacterCoords = Coords
type HitboxCharacterCoords = (LocalCharacterCoords, MapCoords)
instance ToMapCoords HitboxCharacterCoords where
  toMapCoords (local, global) = local + global
