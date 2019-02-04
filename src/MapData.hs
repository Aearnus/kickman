{-# LANGUAGE DataKinds #-}

module MapData where

import Types
import SFML.Graphics
import SFML.System
import Coords

defaultMap :: MapData
defaultMap = MapData {
  solidPlatforms = [

  ]
}

instance SFDrawable MapData where
  draw t mapdata rens = mapM_ (\platform -> draw t platform rens) (solidPlatforms mapdata)

instance SFDrawable Platform where
  draw t platform rens = do
    let (c1, c2) = (boundingBox platform) :: (Coords MapCoords, Coords MapCoords)
        (Coords (sc1x, sc1y), Coords (sc2x, sc2y)) = (toScreenCoords c1, toScreenCoords c2) :: (Coords ScreenCoords, Coords ScreenCoords)
    eitherRect <- createRectangleShape
    case eitherRect of
      Left _ -> do
        return ()
      Right rect -> do
        setFillColor rect red
        setSize rect $ Vec2f (realToFrac $ sc2x - sc1x) (realToFrac $ sc2y - sc1y)
        setPosition rect $ Vec2f (realToFrac sc1x) (realToFrac sc2x)
        drawRectangle t rect rens
