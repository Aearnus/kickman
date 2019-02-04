{-# LANGUAGE ExistentialQuantification #-}

module Characters where

import Types
import SFML.Graphics
import SFML.System
import Debug.Trace
import Input
import Coords

instance SFDrawable Character where
  draw t char rens = do
    eitherRect <- createRectangleShape
    case eitherRect of
      Left _ -> do
        return ()
      Right rect -> do
        setFillColor rect blue
        setSize rect $ Vec2f 15 15
        let (Coords screenPos) = toScreenCoords . Types.position . info $ char
        setPosition rect $ Vec2f (realToFrac . fst $ screenPos) (realToFrac . snd $ screenPos)
        drawRectangle t rect rens

bound :: (Num a, Ord a) => a -> a -> a
bound outer inner =
  if inner < 0 then
    max (-outer) inner
  else
    min outer inner

updateCharacter :: Character    -- The Character to update
                  -> World      -- The world the Character is in
                  -> Input      -- The currently pressed inputs
                  -> Time       -- The time elapsed between updates
                  -> Character  -- The updated Character
updateCharacter char world input elapsed =
  char {
    info = (info char) {
      Types.position =
        let (Coords (x, y)) = (Types.position . info) char
            (Coords (vx, vy)) = (Types.velocity . info) char
            t = realToFrac $ asSeconds elapsed
        in Coords (x + t*vx, y + t*vy),
      Types.velocity =
        let (Coords (vx, vy)) = (Types.velocity . info) char
            (Coords (ax, ay)) = (acceleration . info) char
            groundSpeed' = (groundSpeed . stats) char
            weight' = (weight . stats) char
            t = realToFrac $ asSeconds elapsed
            -- velocity specific things
            vxFromInput = bound (abs $ groundSpeed' * (horizontal input)) ((t * groundSpeed' * (1 / weight') * (horizontal input)) + vx)
            vxFromAccel = t*ax
            vyFromAccel = t*ay
        in
          Coords (
            vxFromInput + vxFromAccel,
            vyFromAccel
          ),
      Types.acceleration =
        let t = realToFrac $ asSeconds elapsed
        in Coords (0, -9.8)
    }
  }
  where
    canJump :: Character -> Bool
    canJump char = let info_ = info char in onGround info_


baseCharacter :: Character
baseCharacter = Character {
    stats = defaultStats,
    info = defaultInfo
  }

kickman :: Character
kickman = baseCharacter {
  stats = Stats {
    maxHp = 100,
    groundSpeed = 150,
    fallSpeed = 100,
    weight = 0.5,
    hitboxes = []
  }
}
