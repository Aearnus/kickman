{-# LANGUAGE ExistentialQuantification #-}

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
  position :: MapCoords,
  velocity :: MapCoords,
  onGround :: Bool
}
defaultInfo = VolatileInfo {
  Types.position = (0,0),
  velocity = (0,0),
  onGround = False
}

data Character = Character {
  stats :: Stats,
  info :: VolatileInfo
}
instance Show Character where
  show char = "CharacterData"

-- World Types
data World = World {
  characters :: [Character]
} deriving (Show)

data Platform = Platform {
  boundingBox :: MapCoords
}
data MapData = MapData {
  solidPlatforms :: [Platform]
}
