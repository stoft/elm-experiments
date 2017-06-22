module Main exposing (..)

import Html exposing (Html, text, div, a, h4, p)
import Html.Attributes exposing (href)
import Navigation exposing (Location)
import UrlParser as Url
    exposing
        ( parseHash
        , parsePath
        , s
        , (</>)
        , (<?>)
        , intParam
        , string
        , oneOf
        , Parser
        )


main : Program Never Model Msg
main =
    Navigation.program (fromLocation >> SetRoute)
        { init = init
        , update = update
        , view = view
        , subscriptions = always Sub.none
        }


init : Location -> ( Model, Cmd Msg )
init location =
    ( { route = "" }, Cmd.none )


type alias Model =
    { route : String }


view : Model -> Html Msg
view model =
    div []
        [ a [ href "#" ] [ text "home" ]
        , div [] []
        , a [ href "#/items" ] [ text "items" ]
        , div [] []
        , a [ href "#/items/1" ] [ text "items/1" ]
        , div [] []
        , a [ href "#/items/new?param=1" ] [ text "items/new?param=1" ]
        , h4 [] [ text "Current Route" ]
        , p [] [ text model.route ]
        ]


type Msg
    = SetRoute (Maybe Route)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetRoute route ->
            ( { model | route = toString route }, Cmd.none )



-- ROUTING --


type Route
    = Home
    | Items
    | Item String
    | NewItem (Maybe Int)


route : Parser (Route -> a) a
route =
    oneOf
        [ Url.map Home (s "")
        , Url.map Items (s "items")
        , Url.map NewItem (s "items" </> s "new" <?> intParam "param")
        , Url.map Item (s "items" </> string)
        ]


fromLocation : Location -> Maybe Route
fromLocation location =
    location
        |> fixLocationQuery
        |> parseHash route


fixLocationQuery : Location -> Location
fixLocationQuery location =
    let
        hash =
            String.split "?" location.hash
                |> List.head
                |> Maybe.withDefault ""

        search =
            String.split "?" location.hash
                |> List.drop 1
                |> String.join "?"
                |> String.append "?"
    in
        { location | hash = hash, search = search }
