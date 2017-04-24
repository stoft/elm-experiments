module Main exposing (main)

import Html exposing (Html, text)
import Model exposing (Model)
import StateTracker exposing (notAuthenticated, authenticated)
import Statey exposing (StateRecord, getState)


--MODEL


init : ( Model, Cmd Msg )
init =
    { user = "user", password = "password", state = notAuthenticated } ! []


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
    if getState model == notAuthenticated then
        text model.user
    else if getState model == authenticated then
        text model.password
    else
        text "unknown state"



--MAIN


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = always Sub.none
        }
