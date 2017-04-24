module Main exposing (main)

import Html exposing (Html, text)
import Statey


--MODEL


type alias Model =
    { user : String, password : String }


init : ( Model, Cmd Msg )
init =
    { user = "", password = "" } ! []


type Msg
    = LoginPressed



--UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LoginPressed ->
            model ! []



--VIEW


view : Model -> Html Msg
view model =
    text model.user



--MAIN


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = always Sub.none
        }
