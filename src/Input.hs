module Input where

import SFML.Window

data Keybinds = Keybinds {
  upBind :: KeyCode,
  downBind :: KeyCode,
  leftBind :: KeyCode,
  rightBind :: KeyCode,
  jumpBind :: KeyCode,
  kickBind :: KeyCode
}

defaultKeybinds = Keybinds {
  upBind = KeyW,
  downBind = KeyS,
  leftBind = KeyA,
  rightBind = KeyD,
  jumpBind = KeySpace,
  kickBind = KeyN
}

data Input = Input {
  vertical :: Double,
  horizontal :: Double,
  jump :: Double,
  kick :: Bool
} deriving (Show)

defaultInput = Input {
  vertical = 0,
  horizontal = 0,
  jump = 0,
  kick = True
}

keybindsToInput :: Keybinds -> IO Input
keybindsToInput keybinds = do
  up <- isKeyPressed (upBind keybinds)
  down <- isKeyPressed (downBind keybinds)
  left <- isKeyPressed (leftBind keybinds)
  right <- isKeyPressed (rightBind keybinds)
  jump <- isKeyPressed (jumpBind keybinds)
  kick <- isKeyPressed (kickBind keybinds)
  return $ Input {
    vertical = (ohFuck up) - (ohFuck down),
    horizontal = (ohFuck right) - (ohFuck left),
    jump = ohFuck jump,
    kick = kick
  }
  where
    ohFuck b = if b then 1.0 else 0.0
