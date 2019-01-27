module GameState where

import Types
import World
import Input
import SFML.System
import SFML.Graphics
import Debug.Trace

data Scene = InMainMenu | InGame World

instance SFDrawable Scene where
  draw t InMainMenu rens = return ()
  draw t (InGame world) rens = trace "drawing scene" $ draw t world rens

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
updateGameState gs input elapsed =
  case (currentScene gs) of
    InMainMenu -> gs
    InGame world -> gs { currentScene = InGame (updateWorld world input elapsed) }

instance SFDrawable GameState where
  draw t gs rens = trace "drawing gamestate" $ draw t (currentScene gs) rens
