{-# LANGUAGE ExistentialQuantification #-}

module World where

import Input
import SFML.Graphics
import SFML.System

class (SFDrawable b) => BaseCharacter b where
  update :: b -> World -> Input -> b
data Character = forall b. BaseCharacter b => Character b
instance SFDrawable Character where
  draw t char rens = return ()
instance BaseCharacter Character where
  update (Character b) = update $ Character b

data World = World {
  characters :: [Character]
}
defaultWorld = World { characters = [] }

instance SFDrawable World where
  draw t world rens = do
    eitherRect <- createRectangleShape
    case eitherRect of
      Left _ -> do
        return ()
      Right rect -> do
        setFillColor rect blue
        setSize rect (Vec2f 500 500)
        setPosition rect (Vec2f 0.5 0.5)
        drawRectangle t rect rens
