module Page.Home exposing (..)

import Html exposing (Html, text)


type alias Model =
    {}


init : Model
init =
    {}


type Msg
    = Noop


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    model ! []


view : Model -> Html Msg
view model =
    Html.text "home"
