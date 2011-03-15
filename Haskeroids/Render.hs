
module Haskeroids.Render (LineRenderable(..)) where

import Graphics.Rendering.OpenGL
import Haskeroids.Util

-- | Object that can be rendered as a group of lines
class LineRenderable r where
    lineSegments :: r -> [LineSegment]

    render :: r -> IO ()
    render = renderLines . lineSegments


-- | Render a list of line segments using OpenGL
renderLines :: [LineSegment] -> IO ()
renderLines lns = do
    currentColor $= Color4 0.9 0.9 0.9 1.0
    renderPrimitive Lines $ mapM_ lineVertices lns

-- | Generate the OpenGL vertices of a single line segment
lineVertices :: LineSegment -> IO ()
lineVertices (LineSegment ((x,y),(x',y'))) = do
    vertex $ Vertex2 x y
    vertex $ Vertex2 x' y'