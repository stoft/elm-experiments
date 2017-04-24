module Main exposing (main)

import Html
import SubTypes


type SuperType
    = NoOp
    | SubType SubTypes.Type


main =
    let
        t =
            SubType SubTypes.MyType
    in
        Html.text "MyType found!"
