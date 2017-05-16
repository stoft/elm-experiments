module Test exposing (..)

import Chae.Tree as Tree exposing (Tree)
import Html exposing (text)


list =
    [ { id = "bc", name = "Bar", parentIds = [ "bc" ] }, { id = "bc", name = "Foo", parentIds = [] } ]


tree =
    Tree.fromList (.id) (.parentIds) list


main =
    (toString >> Html.text) tree
