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
        let screenPos = toScreenCoords . Types.position . info $ char
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
        let (x, y) = (Types.position . info) char
            (vx, vy) = (Types.velocity . info) char
            t = realToFrac $ asSeconds elapsed
        in (x + t*vx, y + t*vy),
      Types.velocity =
        let (vx, vy) = (Types.velocity . info) char
            groundSpeed' = (groundSpeed . stats) char
            weight' = (weight . stats) char
            t = realToFrac $ asSeconds elapsed
        in (bound (abs $ groundSpeed' * (horizontal input)) ((t * groundSpeed' * (1 / weight') * (horizontal input)) + vx), 0)
    }
  }

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
