{-# LANGUAGE ExistentialQuantification #-}

module Characters where

import Types
import SFML.Graphics
import SFML.System
import Debug.Trace
import Input

instance SFDrawable Character where
  draw t (Character b) rens = do
    putStrLn "drawing Character"
    draw t b rens
instance Character_ Character where
  updateCharacter (Character b) = updateCharacter $ Character b
  stats (Character b) = stats $ Character b
  info (Character b) = info $ Character b

data BaseCharacter = BaseCharacter {
  baseStats :: Stats,
  baseInfo :: VolatileInfo
}
instance SFDrawable BaseCharacter where
  draw t char rens = do
    putStrLn "drawing BaseCharacter"
    eitherRect <- createRectangleShape
    case eitherRect of
      Left _ -> do
        return ()
      Right rect -> do
        setFillColor rect blue
        setSize rect $ Vec2f 15 15
        setPosition rect $ Vec2f (realToFrac . fst . Types.position . info $ char) (realToFrac . snd . Types.position . info $ char)
        drawRectangle t rect rens
instance Character_ BaseCharacter where
  updateCharacter char world input elapsed = char {
    baseInfo = (baseInfo char) {
      Types.position =
        let positionValue = (Types.position . baseInfo) char
            speedValue = (speed . baseStats) char
            x = fst positionValue
            y = snd positionValue
            secondsElapsed = realToFrac $ asSeconds elapsed
        in (secondsElapsed * speedValue * (horizontal input) + x, secondsElapsed * speedValue * (vertical input) + y)
    }
  }
  stats = baseStats
  info = baseInfo

kickman :: BaseCharacter
kickman = BaseCharacter {
  baseStats = Stats {
    maxHp = 100,
    speed = 15,
    weight = 10,
    hitboxes = []
  },
  baseInfo = defaultInfo
}
