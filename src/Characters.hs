{-# LANGUAGE ExistentialQuantification #-}

module Characters where

import Types
import SFML.Graphics
import SFML.System
import Debug.Trace
import Input

instance SFDrawable Character where
  draw t char rens = do
    eitherRect <- createRectangleShape
    case eitherRect of
      Left _ -> do
        return ()
      Right rect -> do
        setFillColor rect blue
        setSize rect $ Vec2f 15 15
        setPosition rect $ Vec2f (realToFrac . fst . Types.position . info $ char) (realToFrac . snd . Types.position . info $ char)
        drawRectangle t rect rens

baseCharacter :: Character
baseCharacter = Character {
    updateCharacter =
      (\char world input elapsed -> char {
      info = (info char) {
        Types.position =
          let (x, y) = (Types.position . info) char
              speedValue = (speed . stats) char
              secondsElapsed = realToFrac $ asSeconds elapsed
          in (secondsElapsed * speedValue * (horizontal input) + x, secondsElapsed * speedValue * (-(vertical input)) + y)
      }
    }),
    stats = defaultStats,
    info = defaultInfo
  }

kickman :: Character
kickman = baseCharacter {
  stats = Stats {
    maxHp = 100,
    speed = 150,
    weight = 10,
    hitboxes = []
  }
}
