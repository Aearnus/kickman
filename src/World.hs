module World where

import Input
import SFML.Graphics
import SFML.System
import Types
import Characters
import Debug.Trace

defaultWorld = World { characters = [Character kickman] }

updateWorld :: World           -- The World to update
               -> [Input]      -- The currently pressed inputs
               -> Time         -- The time elapsed since the last update
               -> World        -- The new World
updateWorld world input elapsed =
  let charactersAndInputs  = zip input (characters world)
      updatedCharacters    = map (\c -> updateCharacter (snd c) world (fst c) elapsed) charactersAndInputs
  in world { characters = updatedCharacters }

instance SFDrawable World where
  draw t world rens = do
    putStrLn "drawing world"
    mapM_ (\char -> draw t char rens) (characters world)
