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
  putStrLn "1"
  clearRenderWindow win white
  putStrLn "2"
  draw win gs Nothing
  putStrLn "3"
  display win
  putStrLn "4"
  elapsedTime <- restartClock frameClock
  putStrLn "5"
  maybeEvent <- pollEvent win
  putStrLn "6"
  input <- keybindsToInput defaultKeybinds
  putStrLn "7"
  let willClose = shouldClose maybeEvent
  putStrLn "8"
  let gs' = updateGameState gs [input] elapsedTime
  putStrLn "9"
  sfSleep $ milliseconds 50
  putStrLn "10"
  trace (show input) $ unless willClose (eventLoop win gs' frameClock)

main :: IO ()
main = do
  window <- createRenderWindow (VideoMode 1366 768 8) "Kickmen" [SFClose] Nothing
  frameClock <- createClock
  eventLoop window defaultGameState frameClock
  close window
  destroy window
