module Main where

import World
import SFML.Window
import SFML.System
import SFML.Graphics
import GameState
import Input
import Control.Monad
import Debug.Trace

shouldClose e = case e of
  Nothing -> False
  Just event -> case event of
    SFEvtClosed -> True
    otherwise -> False

eventLoop :: RenderWindow -> GameState -> Clock -> IO ()
eventLoop win gs frameClock = do
  clearRenderWindow win white
  draw win gs Nothing
  display win
  elapsedTime <- restartClock frameClock
  maybeEvent <- pollEvent win
  input <- keybindsToInput defaultKeybinds
  let willClose = shouldClose maybeEvent
  let gs' = updateGameState gs [input] elapsedTime
  unless willClose (eventLoop win gs' frameClock)

main :: IO ()
main = do
  window <- createRenderWindow (VideoMode 1366 768 8) "Kickmen" [SFClose] Nothing
  frameClock <- createClock
  eventLoop window defaultGameState frameClock
  close window
  destroy window
