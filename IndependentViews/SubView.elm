module SubView exposing (view, Msg)

import Html exposing (input, Html)
import Html.Attributes exposing (type_, placeholder, value)
import Html.Events exposing (onInput)


type Msg
    = FieldUpdated String


view : String -> Html Msg
view field =
    input
        [ type_ "text"
        , onInput FieldUpdated
        , placeholder "something..."
        , value field
        ]
        []
