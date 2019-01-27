module GameState where

import World
import Input
import SFML.System
import SFML.Graphics

data Scene = InMainMenu | InGame World

instance SFDrawable Scene where
  draw t InMainMenu rens = return ()
  draw t (InGame world) rens = draw t world rens

data GameState = GameState {
  currentScene :: Scene,
  keybindings :: [Keybinds]
}

defaultGameState = GameState {
  currentScene = (InGame defaultWorld),
  keybindings = [defaultKeybinds]
}

updateGameState :: GameState    -- The GameState to update
                -> [Input]      -- The currently presed inputs
                -> Time         -- The time elapsed since the last update
                -> GameState    -- The new GameState
updateGameState gs input elapsed = gs

instance SFDrawable GameState where
  draw t gs rens = draw t (currentScene gs) rens
