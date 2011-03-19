module Haskeroids.Player (Player(..)) where

import Haskeroids.Geometry
import Haskeroids.Geometry.Transform
import Haskeroids.Render (LineRenderable(..))
import Haskeroids.Tick
import Haskeroids.Keyboard (isKeyDown)
import Haskeroids.Controls

-- | Data type for tracking current player state
data Player = Player { playerBody :: Body }

instance LineRenderable Player where
    lineSegments (Player b) = map (transform b) $ shipLines

instance Tickable Player where
    tick kb (Player b) | isKeyDown kb turnRight = Player $ rotate 0.2 b
                       | isKeyDown kb turnLeft  = Player $ rotate (-0.2) b
    tick _ p = p
    
-- | Constant for the ship size
shipSize = 12.0 :: Float

-- | List of lines that make up the ship hull
shipLines :: [LineSegment]
shipLines = pointsToSegments points
    where points = [polar shipSize      0,
                    polar shipSize      (0.7*pi),
                    polar (shipSize*0.2) pi,
                    polar shipSize      (1.3*pi),
                    polar shipSize      0]
