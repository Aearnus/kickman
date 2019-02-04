module World where

import Input
import SFML.Graphics
import SFML.System
import Types
import Characters
import Debug.Trace
import MapData
import Coords

defaultWorld = World {
  characters = [kickman],
  mapData = MapData {
    solidPlatforms = [Platform {
      boundingBox = (Coords (-64, 64), Coords (64, -64))
    }]
  }
}

updateWorld :: World           -- The World to update
               -> [Input]      -- The currently pressed inputs
               -> Time         -- The time elapsed since the last update
               -> World        -- The new World
updateWorld world input elapsed =
  let charactersAndInputs  = zip input (characters world)
      updatedCharacters    = map (\(i, c) -> updateCharacter c world i elapsed) charactersAndInputs
  in world { characters = updatedCharacters }

instance SFDrawable World where
  draw t world rens = do
    mapM_ (\char -> draw t char rens) (characters world)
    draw t (mapData world) rens
