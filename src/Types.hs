{-# LANGUAGE ExistentialQuantification #-}

module Types where

-- This file is specifically for DATA DECLARATIONS and their corresponding
-- DEFAULT IMPLEMENTATIONS (sometimes), and TYPECLASSES. All INSTANCES exist in the
-- corresponding Haskell module files -- as these typically contain actual
-- real life code.

import SFML.Graphics
import SFML.System
import Input

data Hitbox = Hitbox {
  corner1 :: (Double, Double),
  corner2 :: (Double, Double)
}

data Stats = Stats {
  maxHp :: Double,
  speed :: Double,
  weight :: Double,
  hitboxes :: [Hitbox]
}

data VolatileInfo = VolatileInfo {
  position :: (Double, Double),
  velocity :: (Double, Double)
}
defaultInfo = VolatileInfo {
  Types.position = (0,0),
  velocity = (0,0)
}

class (SFDrawable b) => Character_ b where
  updateCharacter :: b         -- The Character_ to update
                     -> World  -- The world the Character_ is in
                     -> Input  -- The currently pressed inputs
                     -> Time   -- The time elapsed between updates
                     -> b      -- The updated Character_
  stats :: b -> Stats
  info :: b -> VolatileInfo
data Character = forall b. Character_ b => Character b
instance Show Character where
  show char = "CharacterData"


-- World Types
data World = World {
  characters :: [Character]
} deriving (Show)
