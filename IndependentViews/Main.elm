module Main exposing (main)

import Html exposing (Html, text)
import SubView


type alias Model =
    { field : String }


init : ( Model, Cmd Msg )
init =
    { field = "value" } ! []


type Msg
    = NoOp
    | SubViewMsg SubView.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        SubViewMsg svmsg ->
            case svmsg of
                SubView.FieldUpdated value ->
                    { model | field = value } ! []


view : Model -> Html Msg
view model =
    Html.map SubViewMsg
        (SubView.view model.field)



-- Html.text model.field


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = always Sub.none
        }
