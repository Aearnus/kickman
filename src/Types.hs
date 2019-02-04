{-# LANGUAGE ExistentialQuantification #-}
{-# LANGUAGE DataKinds #-}

module Types where

-- This file is specifically for DATA DECLARATIONS and their corresponding
-- DEFAULT IMPLEMENTATIONS (sometimes), and TYPECLASSES. All INSTANCES exist in the
-- corresponding Haskell module files -- as these typically contain actual
-- real life code.

import SFML.Graphics
import SFML.System
import Input
import Coords

-- Character types
data Hitbox = Hitbox {
  corner1 :: LocalCharacterCoords,
  corner2 :: LocalCharacterCoords
}

data Stats = Stats {
  maxHp :: Double,
  groundSpeed :: Double,
  fallSpeed :: Double,
  weight :: Double,
  hitboxes :: [Hitbox]
}
defaultStats = Stats {
  maxHp = 0,
  groundSpeed = 0,
  fallSpeed = 0,
  weight = 0,
  hitboxes = []
}

data VolatileInfo = VolatileInfo {
  position :: Coords MapCoords,
  velocity :: Coords MapCoords,
  acceleration :: Coords MapCoords,
  onGround :: Bool,
  hitstunTimeLeft :: Double
}
defaultInfo = VolatileInfo {
  Types.position = Coords (0,0),
  velocity = Coords (0,0),
  acceleration = Coords (0,0),
  onGround = False,
  hitstunTimeLeft = 0
}

data Character = Character {
  stats :: Stats,
  info :: VolatileInfo
}
instance Show Character where
  show char = "CharacterData"

-- World Types
data World = World {
  characters :: [Character],
  mapData :: MapData
} deriving (Show)

data Platform = Platform {
  boundingBox :: (Coords MapCoords, Coords MapCoords)
} deriving (Show)
data MapData = MapData {
  solidPlatforms :: [Platform]
} deriving (Show)
